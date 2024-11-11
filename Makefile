.PHONY: all package

FRONTEND_DIR=frontend
DIST_DIR=dist

all: package

package:
	mkdir -p $(DIST_DIR)
	cd $(FRONTEND_DIR) && npm install && npm run build

plan: package
	cd infra && terraform plan

apply: package
	cd infra && terraform apply
	
clean:
	rm -rf $(DIST_DIR)

destroy:
	cd infra && terraform destroy