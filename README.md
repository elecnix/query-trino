# query-trino GitHub Action

This GitHub action allows users to run SQL queries using Trino.

This action runs an SQL statement using the [Trino CLI](https://trino.io/docs/current/client/cli.html).

## Inputs

- `config`: **Required** The contents of a [Trino configuration file](https://trino.io/docs/current/client/cli.html#configuration-file)
- `version`: (optional) Trino version to run
- `password`: (optional) Optional password to pass as [TRINO_PASSWORD](https://trino.io/docs/current/client/cli.html?highlight=password#username-and-password-authentication) to the Trino CLI
- `query`: SQL query to run. Required unless `query-file` is provided
- `query-file`: Path to a file containing the SQL query to run
- `output-format`: Query [output format](https://trino.io/docs/current/client/cli.html#cli-output-format). Defaults to ALIGNED (ASCII character table with values)

## Outputs

- `result`: The results of the query

## Example usage

    steps:
      - name: Run Query
        id: query
        uses: elecnix/query-trino
        with:
          query: "SELECT 'hello' AS txt;"
          config: |
            user=${{ vars.TRINO_USERNAME }}
            server=https://mycluster-mycatalog.trino.galaxy.starburst.io
          password: '${{ secrets.TRINO_PASSWORD }}'
      - name: Get output
        run: echo "${{ steps.query.outputs.result }}"
