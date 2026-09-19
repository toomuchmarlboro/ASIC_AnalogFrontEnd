// Converted from rtl/tdm8_rx.vhd. See notes/tdm8_rx.md.
// The VHDL `rst` (active-high) is `rst_n` here; see notes/decisions.md.

module tdm8_rx (
    input  wire         rst_n,   // active-low, asynchronous
    input  wire         bclk_in,
    input  wire         lrclk_in,
    input  wire         sdata_in,
    output reg  [191:0] ch_data_out
);

    localparam integer C_BIT_ADJ     = -1;   // measured; do not change
    localparam         C_RAW_CAPTURE = 1'b0;

    reg [263:0] shift_reg;
    reg         lrclk_d;
    reg         lrclk_d2;
    reg         sdata_f;
    integer     k;

    always @(negedge bclk_in or negedge rst_n) begin
        if (!rst_n)
            sdata_f <= 1'b0;
        else
            sdata_f <= sdata_in;
    end

    always @(posedge bclk_in or negedge rst_n) begin
        if (!rst_n) begin
            shift_reg   <= {264{1'b0}};
            ch_data_out <= {192{1'b0}};
            lrclk_d     <= 1'b0;
            lrclk_d2    <= 1'b0;
        end else begin

            lrclk_d  <= lrclk_in;
            lrclk_d2 <= lrclk_d;

            shift_reg <= {shift_reg[262:0], sdata_f};

            if (lrclk_d == 1'b1 && lrclk_d2 == 1'b0 && C_RAW_CAPTURE) begin
                ch_data_out <= shift_reg[255 + C_BIT_ADJ -: 192];
            end else if (lrclk_d == 1'b1 && lrclk_d2 == 1'b0) begin
                for (k = 0; k <= 7; k = k + 1) begin
                    ch_data_out[191 - 24*k -: 24]
                        <= shift_reg[255 + C_BIT_ADJ - 32*k -: 24];
                end
            end

        end
    end

endmodule
