-- --------------------------------------------------------------------
-- Date: 22/12/2014 11:33:59
-- --------------------------------------------------------------------
-- Tool: "eeschema (2013-07-07 BZR 4022)-stable
-- --------------------------------------------------------------------
-- File: C:/Users/Esteve/Documents/PCB/sensor_hub/sensor_hub.sch
-- --------------------------------------------------------------------
-- Interfaces:
--      - Wishbone B4 complaint
--      - Altera Avalon Interface complaint
--
-- Module implements:
--      -
--      -
-- --------------------------------------------------------------------
-- Author:
--      PhD. Esteve Farres Berenguer
--      C / Can Planes, 6
--      ES17160 - Anglès - Girona
--      Catalonia - Spain
--
-- Contact:
--      mobile: +34 659 17 59 69
--      web: https://plus.google.com/+EsteveFarresBerenguer/posts
--      email: esteve.farres@gmail.com
--
-- --------------------------------------------------------------------
-- Code Revision History :
--      -
-- --------------------------------------------------------------------
-- Ver: | Author |Mod. Date   |Changes Made:
-- V1.0 | E.F.B. | YYYY/MM/DD | Initial ver
-- --------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity C:/Users/Esteve/Documents/PCB/sensor_hub/sensor_hub.sch is
    port (
    );

architecture rtl of C:/Users/Esteve/Documents/PCB/sensor_hub/sensor_hub.sch is

    -- Components 

    component avalon_st_sink_to_wb_df_master_pipelined is 
    port(
        signal clk : in std_logic;
        signal reset_n : in std_logic;
        signal st_sink_valid : in std_logic;
        signal st_sink_data : in std_logic;
        signal st_sink_ready : out std_logic;
        signal CYC_O : out std_logic;
        signal WE_O : out std_logic;
        signal SEL_O : out std_logic;
        signal STB_O : out std_logic;
        signal DAT_O : out std_logic;
        signal ACK_I : in std_logic;
        signal STALL_I : in std_logic;
    );

    component wb_df_slave_to_avalon_st_src is 
    port(
        signal clk : in std_logic;
        signal reset_n : in std_logic;
        signal CYC_I : in std_logic;
        signal WE_I : in std_logic;
        signal SEL_I : in std_logic;
        signal STB_I : in std_logic;
        signal DAT_I : in std_logic;
        signal ACK_O : out std_logic;
        signal st_src_valid : out std_logic;
        signal st_src_data : out std_logic;
        signal st_src_ready : in std_logic;
    );

    component uart_core_to_wb_df is 
    port(
        signal CLK : in std_logic;
        signal RESET : in std_logic;
        signal UART_CYC_0 : out std_logic;
        signal UART_WE_O : out std_logic;
        signal UART_SEL_O : out std_logic;
        signal UART_STB_O : out std_logic;
        signal UART_ADR_O : out std_logic;
        signal UART_DAT_O : out std_logic;
        signal UART_DAT_I : in std_logic;
        signal UART_ACK_I : in std_logic;
        signal UART_CTI_O : out std_logic;
        signal UART_BTE_O : out std_logic;
        signal RXDRY_N : out std_logic;
        signal TXRDY_N : out std_logic;
        signal MASTER_CYC_O : out std_logic;
        signal MASTER_WE_O : out std_logic;
        signal MASTER_SEL_O : out std_logic;
        signal MASTER_STB_O : out std_logic;
        signal MASTER_DATA_O : out std_logic;
        signal MASTER_ACK_I : out std_logic;
        signal SLAVE_CYC_I : in std_logic;
        signal SLAVE_WE_I : in std_logic;
        signal SLAVE_SEL_I : in std_logic;
        signal SLAVE_STB_I : in std_logic;
        signal SLAVE_DAT_I : in std_logic;
        signal SLAVE_ACK_O : out std_logic;
        signal SLAVE_STALL_O : out std_logic;
    );

    component st_bytes_to_am is 
    port(
        signal clk : in std_logic;
        signal reset_n : in std_logic;
        signal in_valid : in std_logic;
        signal in_data : in std_logic;
        signal in_ready : out std_logic;
        signal out_valid : in std_logic;
        signal out_data : out std_logic;
        signal out_ready : in std_logic;
        signal am_address : out std_logic;
        signal am_read : out std_logic;
        signal am_write : out std_logic;
        signal am_byteenable : out std_logic;
        signal am_writedata : out std_logic;
        signal am_readdata : in std_logic;
        signal am_waitrequest : in std_logic;
        signal am_readdatavalid : in std_logic;
    );

    component uart_core is 
    port(
        signal CLK : in std_logic;
        signal RESET : in std_logic;
        signal SIN : in std_logic;
        signal SOUT : out std_logic;
        signal INTR : out std_logic;
        signal UART_CYC_I : in std_logic;
        signal UART_WE_I : in std_logic;
        signal UART_SEL_I : in std_logic;
        signal UART_STB_I : in std_logic;
        signal UART_ADR_I : in std_logic;
        signal UART_DAT_I : in std_logic;
        signal UART_DAT_O : out std_logic;
        signal UART_ACK_O : out std_logic;
        signal UART_CTI_I : in std_logic;
        signal UART_BTE_I : in std_logic;
        signal RXDRY_N : out std_logic;
        signal TXRDY_N : out std_logic;
    );

    component as_to_wb_master is 
    port(
        signal clk : in std_logic;
        signal reset_n : in std_logic;
        signal as_address : in std_logic;
        signal as_read : in std_logic;
        signal as_write : in std_logic;
        signal as_byteenable : in std_logic;
        signal as_writedata : in std_logic;
        signal as_readdata : out std_logic;
        signal as_waitrequest : out std_logic;
        signal as_readdatavalid : out std_logic;
        signal CYC_O : out std_logic;
        signal WE_O : out std_logic;
        signal SEL_O : out std_logic;
        signal STB_O : out std_logic;
        signal ADR_O : out std_logic;
        signal DAT_O : out std_logic;
        signal DAT_I : in std_logic;
        signal ACK_I : in std_logic;
    );

    -- Signals 
    signal /SIN : std_logic;
    signal /INTR : std_logic;
    signal /SOUT : std_logic;
    signal /u5_out_valid : std_logic;
    signal /u6_byteenable : std_logic;
    signal /u6_write : std_logic;
    signal /u6_read : std_logic;
    signal /u6_address : std_logic;
    signal /u6_writedata : std_logic;
    signal /u6_readdatavalid : std_logic;
    signal /u6_waitrequest : std_logic;
    signal /u6_readdata : std_logic;
    signal /CYC_O : std_logic;
    signal /WE_O : std_logic;
    signal /SEL_O : std_logic;
    signal /STB_O : std_logic;
    signal /ADR_O : std_logic;
    signal /DAT_O : std_logic;
    signal /DAT_I : std_logic;
    signal /ACK_I : std_logic;
    signal /clk : std_logic;
    signal /reset_n : std_logic;
    signal /u2_stb : std_logic;
    signal /u5_out_data : std_logic;
    signal /u5_in_ready : std_logic;
    signal /u5_in_data : std_logic;
    signal /u5_in_valid : std_logic;
    signal /u2_stall : std_logic;
    signal /u2_ack : std_logic;
    signal /u2_dat : std_logic;
    signal /u5_out_ready : std_logic;
    signal /u2_sel : std_logic;
    signal /u2_we : std_logic;
    signal /u2_cyc : std_logic;
    signal /u3_ack : std_logic;
    signal /u3_dat : std_logic;
    signal /u3_stb : std_logic;
    signal /u3_sel : std_logic;
    signal /u3_we : std_logic;
    signal /reset : std_logic;
    signal /rxdry_n : std_logic;
    signal /txrdy_n : std_logic;
    signal /uart_bte : std_logic;
    signal /uart_cti : std_logic;
    signal /uart_ack : std_logic;
    signal /dat_from_uart : std_logic;
    signal /dat_to_uart : std_logic;
    signal /uart_adr : std_logic;
    signal /uart_stb : std_logic;
    signal /uart_sel : std_logic;
    signal /uart_we : std_logic;
    signal /uart_cyc : std_logic;
    signal /u3_cyc : std_logic;


begin
    -- Instances 
    U4 : component AVALON_ST_SINK_TO_WB_DF_MASTER_PIPELINED
    port map(
        st_sink_valid => /u5_out_valid, 
        clk => /clk, 
        reset_n => /reset_n, 
        STB_O => /u2_stb, 
        st_sink_data => /u5_out_data, 
        STALL_I => /u2_stall, 
        ACK_I => /u2_ack, 
        DAT_O => /u2_dat, 
        st_sink_ready => /u5_out_ready, 
        SEL_O => /u2_sel, 
        WE_O => /u2_we, 
        CYC_O => /u2_cyc, 
        );


    U5 : component ST_BYTES_TO_AM
    port map(
        out_valid => /u5_out_valid, 
        am_byteenable => /u6_byteenable, 
        am_write => /u6_write, 
        am_read => /u6_read, 
        am_address => /u6_address, 
        am_writedata => /u6_writedata, 
        am_readdatavalid => /u6_readdatavalid, 
        am_waitrequest => /u6_waitrequest, 
        am_readdata => /u6_readdata, 
        clk => /clk, 
        reset_n => /reset_n, 
        out_data => /u5_out_data, 
        in_ready => /u5_in_ready, 
        in_data => /u5_in_data, 
        in_valid => /u5_in_valid, 
        out_ready => /u5_out_ready, 
        );


    U3 : component WB_DF_SLAVE_TO_AVALON_ST_SRC
    port map(
        clk => /clk, 
        reset_n => /reset_n, 
        st_src_ready => /u5_in_ready, 
        st_src_data => /u5_in_data, 
        st_src_valid => /u5_in_valid, 
        ACK_O => /u3_ack, 
        DAT_I => /u3_dat, 
        STB_I => /u3_stb, 
        SEL_I => /u3_sel, 
        WE_I => /u3_we, 
        CYC_I => /u3_cyc, 
        );


    U2 : component UART_CORE_TO_WB_DF
    port map(
        CLK => /clk, 
        SLAVE_STB_I => /u2_stb, 
        SLAVE_STALL_O => /u2_stall, 
        SLAVE_ACK_O => /u2_ack, 
        SLAVE_DAT_I => /u2_dat, 
        SLAVE_SEL_I => /u2_sel, 
        SLAVE_WE_I => /u2_we, 
        SLAVE_CYC_I => /u2_cyc, 
        MASTER_ACK_I => /u3_ack, 
        MASTER_DATA_O => /u3_dat, 
        MASTER_STB_O => /u3_stb, 
        MASTER_SEL_O => /u3_sel, 
        MASTER_WE_O => /u3_we, 
        RESET => /reset, 
        RXDRY_N => /rxdry_n, 
        TXRDY_N => /txrdy_n, 
        UART_BTE_O => /uart_bte, 
        UART_CTI_O => /uart_cti, 
        UART_ACK_I => /uart_ack, 
        UART_DAT_I => /dat_from_uart, 
        UART_DAT_O => /dat_to_uart, 
        UART_ADR_O => /uart_adr, 
        UART_STB_O => /uart_stb, 
        UART_SEL_O => /uart_sel, 
        UART_WE_O => /uart_we, 
        UART_CYC_0 => /uart_cyc, 
        MASTER_CYC_O => /u3_cyc, 
        );


    U1 : component UART_CORE
    port map(
        SIN => /SIN, 
        INTR => /INTR, 
        SOUT => /SOUT, 
        CLK => /clk, 
        RESET => /reset, 
        RXDRY_N => /rxdry_n, 
        TXRDY_N => /txrdy_n, 
        UART_BTE_I => /uart_bte, 
        UART_CTI_I => /uart_cti, 
        UART_ACK_O => /uart_ack, 
        UART_DAT_O => /dat_from_uart, 
        UART_DAT_I => /dat_to_uart, 
        UART_ADR_I => /uart_adr, 
        UART_STB_I => /uart_stb, 
        UART_SEL_I => /uart_sel, 
        UART_WE_I => /uart_we, 
        UART_CYC_I => /uart_cyc, 
        );


    U6 : component AS_TO_WB_MASTER
    port map(
        as_byteenable => /u6_byteenable, 
        as_write => /u6_write, 
        as_read => /u6_read, 
        as_address => /u6_address, 
        as_writedata => /u6_writedata, 
        as_readdatavalid => /u6_readdatavalid, 
        as_waitrequest => /u6_waitrequest, 
        as_readdata => /u6_readdata, 
        CYC_O => /CYC_O, 
        WE_O => /WE_O, 
        SEL_O => /SEL_O, 
        STB_O => /STB_O, 
        ADR_O => /ADR_O, 
        DAT_O => /DAT_O, 
        DAT_I => /DAT_I, 
        ACK_I => /ACK_I, 
        clk => /clk, 
        reset_n => /reset_n, 
        );




end architecture rtl;
