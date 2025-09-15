module tb;
logic clk=0;
logic rstn =1;



initial while(1) clk = #10 ~clk;
initial $dumpvars(0);

initial begin
  repeat(1) @(posedge clk);
  rstn <= 1'b0;
  repeat(10) @(posedge clk);
  rstn <= 1'b1;

  repeat(1054*800*4) @(posedge clk);

  $finish;
end 


wire pix_clk = clk;
wire hdmi4_rst_n = rstn;

bit [9:0] cnt_vs = 0;

//===========================================================================
//testpattern
testpattern testpattern_inst
(
    .I_pxl_clk   (pix_clk            ),//pixel clock
    .I_rst_n     (hdmi4_rst_n        ),//low active 
    .I_mode      ({1'b0,cnt_vs[9:8]} ),//data select
    .I_sqr_width (16'd30             ),
    .I_single_r  (8'd0               ),
    .I_single_g  (8'd255             ),
    .I_single_b  (8'd0               ),                  //800x600(60)  //1024x768   //1280x720    
    .I_h_total   (16'd1054           ),//hor total time  // 16'd1056  // 16'd1344  // 16'd1650  
    .I_h_sync    (16'd128            ),//hor sync time   // 16'd128   // 16'd136   // 16'd40    
    .I_h_bporch  (16'd88             ),//hor back porch  // 16'd88    // 16'd160   // 16'd220   
    .I_h_res     (16'd800            ),//hor resolution  // 16'd800   // 16'd1024  // 16'd1280  
    .I_v_total   (16'd628            ),//ver total time  // 16'd628   // 16'd806   // 16'd750    
    .I_v_sync    (16'd4              ),//ver sync time   // 16'd4     // 16'd6     // 16'd5     
    .I_v_bporch  (16'd23             ),//ver back porch  // 16'd23    // 16'd29    // 16'd20    
    .I_v_res     (16'd600            ),//ver resolution  // 16'd600   // 16'd768   // 16'd720    
    .I_hs_pol    (1'b1               ),//HS polarity , 0:negetive ploarity，1：positive polarity
    .I_vs_pol    (1'b1               ),//VS polarity , 0:negetive ploarity，1：positive polarity
    .O_de        (tp0_de_in          ),   
    .O_hs        (tp0_hs_in          ),
    .O_vs        (tp0_vs_in          ),
    .O_data_r    (tp0_data_r         ),   
    .O_data_g    (tp0_data_g         ),
    .O_data_b    (tp0_data_b         )
);


endmodule
