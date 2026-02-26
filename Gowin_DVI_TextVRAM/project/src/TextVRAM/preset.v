module preset(
  input clk
 ,input rst_n
 ,output reg [15:0] cpu_addr
 ,output reg        cpu_we
 ,output wire [7:0]  cpu_wdata
,output reg led
);
reg tim;

//reg [7:0] ROM[0:100];
reg [7:0] sft;

always @(posedge clk or negedge rst_n) begin
  if( !rst_n ) 
   tim <= 1'b0;
  else
   tim <= ~tim;
end

always @(posedge clk or negedge rst_n) begin
  if( !rst_n ) begin
      sft <= 8'b1000_0000;
    end
    else begin
      if( tim && (sft != 8'b0000_0001) ) begin
       sft[7:0] <= {1'b0, sft[7:1]};
     end
     else begin
       sft <= sft;
     end
  end 
end



reg [2:0] w_state;
reg [2:0] r_state;

reg pre_cpu_we;

parameter [2:0]  P_IDLE  = 3'b000; 
parameter [2:0]  P_START = 3'b001;
parameter [2:0]  P_RUN   = 3'b010;
parameter [2:0]  P_FIN   = 3'b011; 

always_comb begin
  if( ~tim ) begin
    w_state = r_state;
  end
  else begin
    case( r_state ) 
      P_IDLE :
        if( sft == 8'b0000_0001 ) 
          w_state = P_START ;
        else
          w_state = r_state;
      P_START:
          w_state = P_RUN;
      P_RUN :
        if( cpu_addr > 4800*3)
          w_state = P_FIN ;
        else
          w_state = r_state;
      P_FIN:
          w_state = r_state;
      default:
          w_state = r_state;
    endcase
  end
end

always @(posedge clk or negedge rst_n) begin
  if( !rst_n )
    r_state <= P_IDLE;
  else
    r_state <= w_state;
end




function [7:0] func_mes(input [13:0] addr); 
 case(addr) 
    16'h00: func_mes = "H";
     16'h01: func_mes = "e";
     16'h02: func_mes = "l";
     16'h03: func_mes = "l";
     16'h04: func_mes = "o";
     16'h05: func_mes = ",";
     16'h06: func_mes = " ";
     16'h07: func_mes = "W";
     16'h08: func_mes = "o";
     16'h09: func_mes = "r";
     16'h0A: func_mes = "l";
     16'h0B: func_mes = "d";
     16'h0C: func_mes = ".";
    'h12C0: func_mes = 'hFF;
    'h12C0*2: func_mes =  'h00; 
    'h12C0*3: func_mes = 'h00; 
    default :func_mes = 'hFF;
  endcase
endfunction


always @(posedge clk  or negedge rst_n) begin
    if( !rst_n ) 
      cpu_addr  <= 16'h0000;
    else begin
      if( ~tim ) 
        cpu_addr  <= cpu_addr;
      else if( (r_state == P_RUN) )
        cpu_addr  <= cpu_addr + 16'h0001;
      else 
        cpu_addr  <= cpu_addr;
    end
end




wire [7:0] dbg = func_mes(cpu_addr);
always @(posedge clk  or negedge rst_n) begin
    if( !rst_n ) begin
      cpu_we<= 1'b0;
      led       <= 1'b0;
    end
    else begin
      if( ~tim ) begin
        cpu_we    <= 1'b0;
        led       <= 1'b0;
      end
      else if( (r_state == P_RUN) || (r_state== P_START) ) begin
        cpu_we    <= 1'b1;
        led <= 1'b1; 
      end
      else begin
        cpu_we    <= 1'b0;
        led       <= 1'b0;
      end   
    end
end

assign cpu_wdata   = func_mes(cpu_addr);



endmodule



