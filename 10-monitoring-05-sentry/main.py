import sentry_sdk

sentry_sdk.init(
    dsn="https://8baf98794ef8dc0878aebbe332e3542e@o4506274857353216.ingest.sentry.io/4506275295723520",
    environment="development",
    release="1.0",
    traces_sample_rate=1.0,
    profiles_sample_rate=1.0,
)

if __name__ == "__main__":
    division_zero = 1 /0
