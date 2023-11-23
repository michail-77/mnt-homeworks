import sentry_sdk

sentry_sdk.init(
    dsn="https://8ca7fe4470dc0fcf7f839af3e1f1234e@o4506274857353216.ingest.sentry.io/4506274933178368",
    environment="development"
    release="1.0"
)

if __name__ == "__main__":
    division_zero = 1 /0
