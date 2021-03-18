# DO NOT MODIFY
target: run_api run_frontend

run_api:
	cd api \
	&& pip install -r requirements.txt \
	&& python3 -m api

run_frontend:
	cd frontend \
	&& npm install \
	&& npm run dev
