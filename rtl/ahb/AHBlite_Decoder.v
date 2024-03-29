module AHBlite_Decoder
#(
    /*RAMCODE enable parameter*/
    parameter Port0_en = 1,
    /************************/

    /*RAMDATA enable parameter*/
    parameter Port1_en = 1,
    /************************/

    /*Keyboard enable parameter*/
    parameter Port2_en = 1,
    /************************/

    /*LCD enable parameter*/
    parameter Port3_en = 1,
    /************************/

    /*Buzzermusic enable parameter*/
    parameter Port4_en = 1,
    /************************/

    /*APB enable parameter*/
    parameter Port5_en = 1
    /************************/
)(
    input [31:0] HADDR,

    /*RAMCODE OUTPUT SELECTION SIGNAL*/
    output wire P0_HSEL,

    /*Keyboard OUTPUT SELECTION SIGNAL*/
    output wire P1_HSEL,

    /*RAMDATA OUTPUT SELECTION SIGNAL*/
    output wire P2_HSEL,

    /*LCD OUTPUT SELECTION SIGNAL*/
    output wire P3_HSEL,

    /*Buzzermusic OUTPUT SELECTION SIGNAL*/ 
    output wire P4_HSEL,

    /*APB OUTPUT SELECTION SIGNAL*/ 
    output wire P5_HSEL      
);

//RAMCODE-----------------------------------

//0x00000000-0x0000ffff
/*Insert RAMCODE decoder code there*/
assign P0_HSEL = (HADDR[31:16] == 16'h0000) ? Port0_en : 1'b0; 
/***********************************/

//RAMDATA-----------------------------

//0X20000000-0X2000FFFF
/*Insert RAMDATA decoder code there*/
assign P1_HSEL = (HADDR[31:16] == 16'h2000) ? Port1_en : 1'b0; 
/***********************************/

//PERIPHRAL-----------------------------

//0X40000000 key_data/key_clear
/*Insert Keyboard decoder code there*/
assign P2_HSEL = (HADDR[31:4] == 28'h4000000) ? Port2_en : 1'b0; 
/***********************************/

//0X40050000 LCD 
/*Insert LCD decoder code there*/
assign P3_HSEL = (HADDR[31:16] == 16'h4005)   ? Port3_en : 1'b0;
/***********************************/

//0X40000010 Buzzermusic select and en
/*Insert Buzzermusic decoder code there*/
assign P4_HSEL = (HADDR[31:4] == 28'h4000001) ? Port4_en : 1'b0;
/***********************************/

//0X30000000 APB select and en
/*Insert Buzzermusic decoder code there*/
assign P5_HSEL = (HADDR[31:16] == 16'h3000) ? Port5_en : 1'b0;
/***********************************/
endmodule