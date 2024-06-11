{\rtf1\ansi\ansicpg1252\cocoartf2709
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww20260\viewh24980\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 \'97\'97DRAM controller FSM as has been explained in the class\
\
library ieee;\
use ieee.std_logic_1164.all;\
entity mem_ctrl is\
   port(\
      \
\
end mem_ctrl ;\
\
architecture mult_seg_arch of mem_ctrl is\
   type mc_state_type is\
      (idle, read1, read2, read3, read4, write);\
   signal state_reg, state_next: mc_state_type;\
begin\
   -- state register\
   process(clk,reset)\
   begin\
      if (reset='1') then\
         state_reg <= idle;\
      elsif (clk'event and clk='1') then\
         state_reg <= state_next;\
      end if;\
   end process;\
   -- next-state logic\
   process(state_reg,mem,rw,burst)\
   begin\
      case state_reg is\
         when idle =>\
            if mem='1' then\
               if rw='1' then\
                  state_next <= read1;\
               else\
                  state_next <= write;\
               end if;\
            else\
               state_next <= idle;\
            end if;\
         when write =>\
            state_next <= idle;\
         when read1 =>\
            if (burst='1') then\
               state_next <= read2;\
            else\
               state_next <= idle;\
            end if;\
         when read2 =>\
            state_next <= read3;\
         when read3 =>\
            state_next <= read4;\
         when read4 =>\
            state_next <= idle;\
      end case;\
   end process;\
   -- Moore output logic\
   process(state_reg)\
   begin\
      we <= '0'; -- default value\
      oe <= '0';  -- default value\
      case state_reg is\
         when idle =>\
         when write =>\
            we <= '1';\
         when read1 =>\
            oe <= '1';\
         when read2 =>\
            oe <= '1';\
         when read3 =>\
            oe <= '1';\
         when read4 =>\
            oe <= '1';\
      end case;\
   end process;\
   -- Mealy output logic\
   process(state_reg,mem,rw)\
   begin\
      we_me <= '0'; -- default value\
      case state_reg is\
         when idle =>\
            if (mem='1') and (rw='0') then\
              we_me <= '1';\
            end if;\
         when write =>\
         when read1 =>\
         when read2 =>\
         when read3 =>\
         when read4 =>\
      end case;\
   end process;\
end mult_seg_arch;}