build-staging:
	@MIX_ENV=staging mix release --env=staging

build-prod:
	@MIX_ENV=prod mix release --env=prod
