# Package make targets
SPI_PKG         = \
+incdir+$(UVMF_VIP_LIBRARY_HOME)/interface_packages/spi_pkg \
-F $(UVMF_VIP_LIBRARY_HOME)/interface_packages/spi_pkg/spi_filelist_hvl.f 

SPI_PKG_HDL         = \
+incdir+$(UVMF_VIP_LIBRARY_HOME)/interface_packages/spi_pkg \
-F $(UVMF_VIP_LIBRARY_HOME)/interface_packages/spi_pkg/spi_filelist_hdl.f 

COMP_SPI_PKG_TGT_0 = q_comp_spi_pkg
COMP_SPI_PKG_TGT_1 = v_comp_spi_pkg
COMP_SPI_PKG_TGT = $(COMP_SPI_PKG_TGT_$(USE_VELOCE))

comp_spi_pkg: $(COMP_SPI_PKG_TGT)
	$(HDL_COMP_CMD) $(SPI_PKG_HDL)

q_comp_spi_pkg:
	$(HVL_COMP_CMD) $(SPI_PKG)

v_comp_spi_pkg: q_comp_spi_pkg
	$(VELANALYZE_HVL_CMD) $(SPI_PKG)

