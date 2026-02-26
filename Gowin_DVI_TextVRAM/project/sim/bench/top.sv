//module GSR(
//  input GSR0);
//endmodule

module top;
  // Clock period (25.175MHz -> ~39.72ns, use 40ns for simplicity)
  parameter CLK_PERIOD = 40;

  logic clk=0;
  logic rst_n=1;

  initial begin
    $dumpfile("wave.fst");
    $dumpvars(0);
  end


  GSR GSR(.GSRI());

   // Clock generation
   initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end



  wire pix_clk = dut.pix_clk;
  integer i;
  initial begin
    rst_n =1;
    repeat(10) @(posedge clk) rst_n <=0;
    repeat(1) @(posedge clk) rst_n <=1;

    repeat(1000) @(posedge clk);
    //for(i=0; i<7; i=i+1) begin
    //  $display("Count %d",i);
    //  repeat(20000) @(posedge pix_clk);
    //end 

    for(i=0;i<2; i=i+1) begin
      $display("Count %d",i);
      @(negedge dut.tp0_vs_in);
    end 

    $finish;
  end


//  GSR GSR(.GSRI());

  video_top dut
  (
     .I_clk        (clk)
    ,.I_rst_n      (rst_n)
    
    ,.O_led         ()
    ,.O_tmds_clk_p  ()
    ,.O_tmds_clk_n  ()
    ,.O_tmds_data_p ()
    ,.O_tmds_data_n ()  

    ,.led()
  );


endmodule
