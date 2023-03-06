# Test implimentation of anaconda

# Base image
FROM continuumio/anaconda3


# # cache downloads
RUN --mount=type=cache,target=/root/.cache

# # Install Anaconda
RUN /opt/conda/bin/conda update -n base -c defaults conda && \
    /opt/conda/bin/conda install -y jupyter pandas matplotlib && \
    /opt/conda/bin/conda install -c anaconda git && \
    /opt/conda/bin/conda install -c plotly plotly && \
    /opt/conda/bin/conda install -c anaconda pandas-datareader && \
    /opt/conda/bin/conda clean -afy


# # Expose port
EXPOSE 8888

# # Set working directory
WORKDIR /data-analytics

# Copy over code files. update below data-analytics
# COPY analytics-requirements.txt /data-analytics

# Run application

CMD ["/opt/conda/bin/jupyter", "notebook", "--notebook-dir=/data-analytics/notebooks", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]



# Testing jupyter notebook
# CMD [ "/data-analytics/opt/conda/bin/jupyter", "notebook" , "hello.py" ]

###### use the code to run the production environment
# # # # # # # # # # # # # # FROM continuumio/miniconda3:4.8.2

# # # # # # # # # # # # # # COPY environment.yml /opt/env/
# # # # # # # # # # # # # # RUN conda env update -n base -f /opt/env/environment.yml \
# # # # # # # # # # # # # #     && conda install --no-update-deps tini \
# # # # # # # # # # # # # #     && conda clean -afy

# # # # # # # # # # # # # # RUN useradd --shell /bin/bash my_user
# # # # # # # # # # # # # # USER my_user

# # # # # # # # # # # # # # WORKDIR /opt/src
# # # # # # # # # # # # # # COPY src/ /opt/src/

# # # # # # # # # # # # # # ENTRYPOINT [ "tini", "-g", "--" ]
# # # # # # # # # # # # # # CMD [ "python" , "hello.py" ]