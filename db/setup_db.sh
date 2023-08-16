#!/bin/bash
echo "Get password for Postgres"
export POSTGRES_PASSWORD=$(kubectl get secret --namespace default $1-postgresql -o jsonpath="{.data.postgres-password}" | base64 -d)

echo "Starting create schema..." && \
kubectl port-forward --namespace default svc/$1-postgresql 5432:5432 & PGPASSWORD=$POSTGRES_PASSWORD psql --host 127.0.0.1 -U postgres -d postgres -p 5432 < 1_create_tables.sql && \
echo "Create schema successfully"

echo "Seeding users..." && 
echo "================================================================" &&\
kubectl port-forward --namespace default svc/$1-postgresql 5432:5432 & PGPASSWORD=$POSTGRES_PASSWORD psql --host 127.0.0.1 -U postgres -d postgres -p 5432 < 2_seed_users.sql && \
echo "================================================================" && \
echo "Seed users successfully"

echo "Seeding tokens..." && \
echo "================================================================" && \
# Don't need forward again
psql --host 127.0.0.1 -U postgres -d postgres -p 5432 < 3_seed_tokens.sql && \
echo "================================================================" && \
echo "Seed tokens successfully"