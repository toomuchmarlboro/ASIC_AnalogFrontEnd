// Dual-clock FIFO, replacing the Altera dcfifo megafunction (ip/async_fifo).
// See notes/fifo.md.
//
// Port names and behaviour follow the megafunction so the top-level port map
// carries over: standard (not show-ahead) read, q registered and updated on the
// rdclk edge that samples rdreq; a write when full and a read when empty are
// ignored, as with overflow_checking/underflow_checking = ON.
//
// Structure: binary pointers one bit wider than the address, each converted to
// Gray code in its own domain and registered, then passed through two flops in
// the other domain. full and empty are compared against the synchronised
// pointer and registered. rst_n is asynchronous to both clocks; each domain
// releases its own copy synchronously.

module async_fifo #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 9           // depth = 2**ADDR_WIDTH, at least 4 (ADDR_WIDTH >= 2)
) (
    input  wire                  rst_n,

    input  wire                  wrclk,
    input  wire                  wrreq,
    input  wire [DATA_WIDTH-1:0] data,
    output reg                   wrfull,

    input  wire                  rdclk,
    input  wire                  rdreq,
    output reg  [DATA_WIDTH-1:0] q,
    output reg                   rdempty
);

    localparam DEPTH = 1 << ADDR_WIDTH;

    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    // ---- reset release, one synchroniser per domain -----------------------

    reg [1:0] wr_rst_sync;
    reg [1:0] rd_rst_sync;
    wire      wr_rst_n = wr_rst_sync[1];
    wire      rd_rst_n = rd_rst_sync[1];

    always @(posedge wrclk or negedge rst_n) begin
        if (!rst_n) wr_rst_sync <= 2'b00;
        else        wr_rst_sync <= {wr_rst_sync[0], 1'b1};
    end

    always @(posedge rdclk or negedge rst_n) begin
        if (!rst_n) rd_rst_sync <= 2'b00;
        else        rd_rst_sync <= {rd_rst_sync[0], 1'b1};
    end

    // ---- write domain -----------------------------------------------------

    reg  [ADDR_WIDTH:0] wbin;
    reg  [ADDR_WIDTH:0] wgray;
    reg  [ADDR_WIDTH:0] rgray;                // read-domain pointer, declared here for use below
    reg  [ADDR_WIDTH:0] rgray_w1, rgray_w2;   // read pointer, synchronised

    wire                wr_en    = wrreq && !wrfull;
    wire [ADDR_WIDTH:0] wbin_nxt = wbin + {{ADDR_WIDTH{1'b0}}, wr_en};
    wire [ADDR_WIDTH:0] wgray_nxt = (wbin_nxt >> 1) ^ wbin_nxt;

    // full: next write pointer equals the read pointer with its top two bits
    // inverted
    wire wfull_nxt = (wgray_nxt ==
                      {~rgray_w2[ADDR_WIDTH:ADDR_WIDTH-1], rgray_w2[ADDR_WIDTH-2:0]});

    always @(posedge wrclk) begin
        if (wr_en) mem[wbin[ADDR_WIDTH-1:0]] <= data;
    end

    always @(posedge wrclk or negedge wr_rst_n) begin
        if (!wr_rst_n) begin
            wbin     <= {(ADDR_WIDTH+1){1'b0}};
            wgray    <= {(ADDR_WIDTH+1){1'b0}};
            wrfull   <= 1'b0;
            rgray_w1 <= {(ADDR_WIDTH+1){1'b0}};
            rgray_w2 <= {(ADDR_WIDTH+1){1'b0}};
        end else begin
            wbin     <= wbin_nxt;
            wgray    <= wgray_nxt;
            wrfull   <= wfull_nxt;
            rgray_w1 <= rgray;
            rgray_w2 <= rgray_w1;
        end
    end

    // ---- read domain ------------------------------------------------------

    reg  [ADDR_WIDTH:0] rbin;
    reg  [ADDR_WIDTH:0] wgray_r1, wgray_r2;   // write pointer, synchronised

    wire                rd_en    = rdreq && !rdempty;
    wire [ADDR_WIDTH:0] rbin_nxt = rbin + {{ADDR_WIDTH{1'b0}}, rd_en};
    wire [ADDR_WIDTH:0] rgray_nxt = (rbin_nxt >> 1) ^ rbin_nxt;

    wire rempty_nxt = (rgray_nxt == wgray_r2);

    always @(posedge rdclk or negedge rd_rst_n) begin
        if (!rd_rst_n) begin
            rbin     <= {(ADDR_WIDTH+1){1'b0}};
            rgray    <= {(ADDR_WIDTH+1){1'b0}};
            rdempty  <= 1'b1;
            q        <= {DATA_WIDTH{1'b0}};
            wgray_r1 <= {(ADDR_WIDTH+1){1'b0}};
            wgray_r2 <= {(ADDR_WIDTH+1){1'b0}};
        end else begin
            rbin     <= rbin_nxt;
            rgray    <= rgray_nxt;
            rdempty  <= rempty_nxt;
            if (rd_en) q <= mem[rbin[ADDR_WIDTH-1:0]];
            wgray_r1 <= wgray;
            wgray_r2 <= wgray_r1;
        end
    end

endmodule
