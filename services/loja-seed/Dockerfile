FROM mysql:8.4
COPY --from=src db/seed.sql /seed.sql
COPY seed.sh /seed.sh
ENTRYPOINT ["bash", "/seed.sh"]
