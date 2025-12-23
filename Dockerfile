FROM centos:7

# Add the old repos as centos7 is deprecated
RUN sed -i \
    -e 's|^mirrorlist=|#mirrorlist=|g' \
    -e 's|^#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' \
    /etc/yum.repos.d/CentOS-Base.repo

# Install all the requirements for diamond, questasim and other goodies
RUN yum -y update && yum -y install \
    qt \
    qt-x11 \
    qt-devel \
    libXrender \
    libXext \
    libXft \
    libSM \
    fontconfig \
    freetype \
    tcl \
    python3 \
    git \
    wget \
    unzip \
    && yum clean all

# Download, extract and install lattice in headless mode
RUN wget -O /tmp/diamond.zip "https://files.latticesemi.com/Diamond/3.14/3.14.0.75.2_Diamond_lin.zip" && \
    unzip /tmp/diamond.zip -d /tmp/diamond && \
    ldd //tmp/diamond/3.14.0.75.2_Diamond_lin.run && \
    chmod +x /tmp/diamond/3.14.0.75.2_Diamond_lin.run && \
    /tmp/diamond/3.14.0.75.2_Diamond_lin.run --console --verbose --prefix /opt/fpga_tool/diamond && \
    rm -rf /tmp/diamond /tmp/diamond.zip

# Install Python packages
RUN pip3 install --no-cache-dir vunit_hdl pathlib

#needed to fix diamond not showing text on the x11 connection
ENV QT_X11_NO_MITSHM=1

ENV PATH="/opt/fpga_tool/diamond/bin/lin64:$PATH"
ENV PATH="/opt/fpga_tool/diamond/questasim/bin:$PATH"
ENV LM_LICENSE_FILE=/opt/fpga_tool/diamond/license/license.dat

WORKDIR /workspace
