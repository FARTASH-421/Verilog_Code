# axi4_2x2_fabric environment packages source and make target

# Include all requisite sub-environment package targets for this bench

axi4_2x2_fabric_ENV_PKG =\
		 $(UVMF_VIP_LIBRARY_HOME)/environment_packages/axi4_2x2_fabric_env_pkg/axi4_2x2_fabric_env_pkg.sv

comp_axi4_2x2_fabric_env_pkg:   
		$(HVL_COMP_CMD) +incdir+$(UVMF_VIP_LIBRARY_HOME)/environment_packages/axi4_2x2_fabric_env_pkg $(axi4_2x2_fabric_ENV_PKG)

ifeq ($(MTI_VCO_MODE),64)
  GCC_COMP_ARCH = -m64
else
  GCC_COMP_ARCH = -m32
endif

C_FILE_COMPILE_LIST_axi4_2x2_fabric_env_pkg	= \

O_FILE_COMPILE_LIST_axi4_2x2_fabric_env_pkg = $(notdir $(C_FILE_COMPILE_LIST_axi4_2x2_fabric_env_pkg:.c=.o))

GCC_COMP_ARGS_axi4_2x2_fabric_env_pkg	+= -I$(UVMF_VIP_LIBRARY_HOME)/environment_packages/axi4_2x2_fabric_env_pkg/dpi \
	

GCC_LINK_ARGS_axi4_2x2_fabric_env_pkg	+= \
	 \
 	-o .so

comp_axi4_2x2_fabric_env_pkg_c_files:
	@echo "--------------------------------"
	@echo "Compiling Environment C source"
	@echo "--------------------------------"
	gcc $(GCC_COMP_ARCH) $(GCC_COMP_ARGS_axi4_2x2_fabric_env_pkg) $(C_FILE_COMPILE_LIST_axi4_2x2_fabric_env_pkg)
	@echo "--------------------------------"
	@echo "Linking Environment C objects into a shared object"
	@echo "--------------------------------"
	gcc $(GCC_COMP_ARCH) $(GCC_LINK_ARGS_axi4_2x2_fabric_env_pkg) $(O_FILE_COMPILE_LIST_axi4_2x2_fabric_env_pkg)
	@echo "--------------------------------"

