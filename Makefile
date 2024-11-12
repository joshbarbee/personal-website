.PHONY: all frontend backend plan apply clean destroy

FRONTEND_DIR=frontend
DIST_DIR=dist
BACKEND_DIR=backend
BACKEND_DIST_DIR=$(DIST_DIR)/backend

all: apply

frontend:
	mkdir -p $(DIST_DIR)
	cd $(FRONTEND_DIR) && npm install && npm run build

plan: frontend backend
	cd infra && terraform plan

apply: frontend backend
	cd infra && terraform apply -auto-approve

backend:
	mkdir -p $(BACKEND_DIST_DIR)
	cp -r $(BACKEND_DIR)/* $(BACKEND_DIST_DIR)
	cd $(BACKEND_DIST_DIR) && pip install -r requirements.txt -t .
	cd $(DIST_DIR) && zip -r backend.zip backend
	
clean:
	rm -rf $(DIST_DIR)

destroy:
	cd infra && terraform destroy