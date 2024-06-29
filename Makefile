.PHONY: compose/build compose/up

# Dockerのコンテナイメージをビルド
compose/build:
	docker compose build

# Dockerのコンテナを起動
compose/up:
	docker compose up

.PHONY: db/setup db/migrate

# DBの初期構築
db/setup:
	docker compose run --rm web bundle exec rake db:create
	docker compose run --rm web bundle exec rake db:migrate

# DBのマイグレーション
db/migrate:
	docker compose run web bundle exec rake db:migrate

.PHONY: g/model g/route g/migrate

g/model:
	FILENAME="$(name).rb"; \
	if [ -f models/$$FILENAME ]; then \
		echo "$$FILENAME already exists. Skipping creation."; \
	else \
		CLASSNAME=$(shell echo $(name) | awk '{print toupper(substr($$0, 1, 1)) substr($$0, 2)}'); \
		echo "class $$CLASSNAME < ActiveRecord::Base\n\nend" > models/$$FILENAME; \
	fi \

g/route:
	FILENAME="$(name).rb"; \
	if [ -f routes/$$FILENAME ]; then \
		echo "$$FILENAME already exists. Skipping creation."; \
	else \
		CLASSNAME=$(shell echo $(name) | awk '{print toupper(substr($$0, 1, 1)) substr($$0, 2)}'); \
		echo "module Routes\n  class $(CLASSNAME)Route < Base\n\n  end\nend" > routes/$$FILENAME; \
	fi \

g/migrate:
	docker compose run web bundle exec rake db:create_migration NAME=$(name)
