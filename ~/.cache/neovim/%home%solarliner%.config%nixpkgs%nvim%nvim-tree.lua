Vim�UnDo� �m �k>����i�/#�|g`����Rx�D>.ҭ      <vim.api.nvim_set_keymap('i', '<C-b>', ':NvimTreeToggle', {})             #       #   #   #    c��   
 _�                             ����                                                                                                                                                                                                                                                                                                                                                             c��     �                   5��                                                  �                                                �                                                �                                                �                                                �                       
                  
       �                                              �                                                �                                                �                                              �                                             �                                             �                                             �                                             �                                             �                                             �                                             �                                             �                                             �                                             �                         "                      �                         "                      �                          #                      5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             c��     �                 �             5��                          #                      �                          #                      �                        %                     �                        %                     �                        %                     �                        %                     �                        3                     �                        3                     �                        3                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             c��     �                 �             5��                          5                      �                          5                      �                         5                      �                         8                      �                        :                     �                        :                     �                        :                     �                        :                     �                        L                     �                        L                     �                        L                     �                        L                     �                        L                     �                        L                     �                        L                     �                        L                     �                        L                     �                        L                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             c��    �                 g.nvim_tree_side = "right5��                         Q                      5�_�                           ����                                                                                                                                                                                                                                                                                                                                                V   "    c�     �                  local M = {}�                M.config = function()     local g = vim.g         g.nvim_tree_side = "right"   end5��                                 J               �                                                �                                                �                                                �                                                �                                                �                                              �                                              �                                              �                                              �                                              �                                              �                                              �                      	                 	       �               	                 	              �                                              �                                              �                                              �                                              �                                              �                                                �                                                �                                             �                                             �                                             �                        -                     �                        .                     �                        -                     �                        -                     �                        -                     �                        2                      �                         3                     �                        5                     �                        5                     �                        5                     �                     	   5              	       �              	       
   5       	       
       �              
          5       
              �                        B                     �                        B                     �                        B                     �                        B                     �                        H                      �                         K                      �                          I                      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                V   "    c�3    �                  5��                          I                      5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             c��     �                 �             5��                          I                      �                         K                      �                     
   P              
       �                        Z                      �                      	   [              	       �                        `                     �                        f                     �                     
   f              
       �                        p                      �                         u                      �                         q                     �                         t                      �                        u                      �                         x                      5�_�      	                     ����                                                                                                                                                                                                                                                                                                                                                             c��     �      	           diagnostics = {},5��                        �                      �                         �                      �                         �                      5�_�      
           	          ����                                                                                                                                                                                                                                                                                                                                                             c��    �      	   
          �      	   	    5��                          �                      �                         �                     �                        �                     �                        �                     �                        �                     �                        �                     �                        �                     5�_�   	              
   	        ����                                                                                                                                                                                                                                                                                                                                                             c��     �   	              �   	      
    5��    	                      �                      �    	                  	   �               	       5�_�   
                 
   	    ����                                                                                                                                                                                                                                                                                                                                                             c��     �   	              git = {},5��    	   	                 �                      5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             c��     �   
                �   
          5��    
                      �                      �    
                     �                     �    
                    �                     �    
                    �                     �    
                    �                     �    
                    �                      �                         �                      5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             c�0     �                 �             5��                          �                      �                         �                      �                        �                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             c�4     �                 renderer = {},5��                        �                      �                          �                      �                         �                      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             c�5     �                5��                          �                      �                        �                     �                        �                     �                         �                      �                        �                      �                         �                     �                                             �                                              �                                            �                        !                     �                         (                     �                        )                    �                     
   )             
       �              
           )      
               5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             c�I     �                      "5��                          "                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             c�J     �                     �             5��                          �                      �                      
                 
       5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             c�R     �                     �             5��                          3                     �                         9                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             c��     �                   �             5��                          J                     �                         J                    5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             c��     �                   view = {},5��                         J                    5�_�                       
    ����                                                                                                                                                                                                                                                                                                                                                             c��     �                 view = {},5��       
                 T                     �                         U                    �                          U                     �                         U                     �                         X                     5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             c��    �                5��                          U                     �                        Y                    �                        Y                    �                        Y                    5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             c�
     �                 }5��                         u                     �                         v                     �                          w                     �                          w                     5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             c�    �                 require'nvim-tree'.setup {     open_on_setup = true,     open_on_tab = true,     system_open = {       cmd = "xdg-open",     },     diagnostics = {       enable = true,     },   	  git = {       enable = true,       ignore = false,     },     renderer = {       special_files = {         "LICENSE",         "README.md",         "Cargo.toml",         "Makefile",     },   
  view = {       adaptive_size = true,     },   },   }5��                         E                    �                         L                    �                         Y                    �                         u                    �                          |                     5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             c�     �                  �               5��                          �                     �                          �                     �                         �                    �                        �                    �                        �                    �                        �                    �                        �                    �                        �                    �                        �                    �                        �                    �                        �                    �                        �                    �                        �                    �                        �                    �                        �                    �                        �                    �                        �                    �                        �                    �                        �                    �                     	   �             	       �                        �                    �                        �                    �                        �                    �                        �                    �                        �                    �                        �                    �       (                 �                    �       '                 �                    �       '                 �                    �       '                 �                    �       '                 �                    �       '              	   �             	       �       '       	          �      	              �       :                 �                    5�_�                       G    ����                                                                                                                                                                                                                                                                                                                                                             c�7     �             5��                          �                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             c�:     �                 Hvim.api.nvim_set_keymap('n', '<C-b>', 'NvimTreeToggle', { expr = true })5��                         �                     5�_�                       7    ����                                                                                                                                                                                                                                                                                                                               G          7       v   7    c�d    �                 Ivim.api.nvim_set_keymap('ni', '<C-b>', 'NvimTreeToggle', { expr = true })5��       7                  �                     5�_�                       7    ����                                                                                                                                                                                                                                                                                                                                                             c�}    �                 8vim.api.nvim_set_keymap('ni', '<C-b>', 'NvimTreeToggle')5��       7                  �                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             c     �                 <vim.api.nvim_set_keymap('ni', '<C-b>', 'NvimTreeToggle', {})5��                         �                     5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             c     �               �               5��                          �              <       5�_�      !                      ����                                                                                                                                                                                                                                                                                                                                                             c    �                 ;vim.api.nvim_set_keymap('n', '<C-b>', 'NvimTreeToggle', {})5��                        �                    5�_�       "           !      '    ����                                                                                                                                                                                                                                                                                                                               &          &          &    c©   	 �                 ;vim.api.nvim_set_keymap('i', '<C-b>', 'NvimTreeToggle', {})�               ;vim.api.nvim_set_keymap('n', '<C-b>', 'NvimTreeToggle', {})5��       '                  �                     �       '                  �                     5�_�   !   #           "      6    ����                                                                                                                                                                                                                                                                                                                               5          5          5    c��     �                 <vim.api.nvim_set_keymap('i', '<C-b>', ':NvimTreeToggle', {})�               <vim.api.nvim_set_keymap('n', '<C-b>', ':NvimTreeToggle', {})5��       6                  �                     �       6                  �                     5�_�   "               #      7    ����                                                                                                                                                                                                                                                                                                                               7          7          7    c��   
 �                 @vim.api.nvim_set_keymap('n', '<C-b>', ':NvimTreeToggle<BR>', {})   @vim.api.nvim_set_keymap('i', '<C-b>', ':NvimTreeToggle<BR>', {})5��       7                 �                    �       7                 �                    5��