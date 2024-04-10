`ifndef __ALU_SV
`define __ALU_SV
`ifdef VERILATOR
`include "param.sv"
`else

`endif


module alu(
  input clk,
  input exu_valid,
  input  [63:0] A,
  input  [63:0] B,
  input  [`ALUOP_WIDTH-1:0] ALUop,
  output logic [63:0] data,
  output logic alu_data_ok
  );

  always_comb begin
    case (ALUop)
      0: data = A + B;
      1: data = A - B;
      2: data = A & B;
      3: data = A | B;
      4: data = A ^ B;
      5: data = {63'b0,$signed(A) < $signed(B)};
      6: data = {63'b0,$unsigned(A) < $unsigned(B)};
      7: data = A << B[5:0];
      8: data = A >> B[5:0];
      9: data = $signed(A) >>> B[5:0];
      10:data = {{32{{A+B}[31]}},{A+B}[31:0]};
      11:data = {{32{{A-B}[31]}},{A-B}[31:0]};
      12:data = {{32{{A<<B[4:0]}[31]}},{A<<B[4:0]}[31:0]};
      13:data = {{32{{A[31:0]>>B[4:0]}[31]}},{A[31:0]>>B[4:0]}[31:0]};
      14:data = {{32{{$signed(A[31:0])>>>B[4:0]}[31]}},{$signed(A[31:0])>>>B[4:0]}[31:0]};
      20:data = B;
      default: data = 0;
    endcase    
   // alu_data_ok=1;
  end
  always_ff @( posedge clk ) begin
        if(exu_valid)alu_data_ok<=1;
        else alu_data_ok<=0;
        
    end

endmodule

`endif