
# Adapted from docker-uv-renv by Daniel Chen (MIT License)
# https://github.com/chendaniely/docker-uv-renv

# Start from Ubuntu Linux with R installed.
FROM rocker/r-ver:4.6.1

# Install curl
RUN apt-get update && apt-get install --yes curl

# Set the working directory inside the image
WORKDIR /workspace

# Store R packages outside the project directory
RUN echo "RENV_PATHS_LIBRARY=/opt/renv/library" >> /usr/local/lib/R/etc/Renviron.site

# Copy the required project files
COPY renv.lock .Rprofile hello.R ./
COPY renv/activate.R renv/

# Restore the exact R packages
RUN Rscript -e "renv::restore()"
