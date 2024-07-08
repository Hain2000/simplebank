--name: CreateAccount :one 
INSERT INTO authors (
    name, bio
) VALUES (
    $1, $2
)

RETURNING *;
