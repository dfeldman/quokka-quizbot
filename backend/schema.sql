
CREATE TABLE IF NOT EXISTS oauth_auth_request (
    state TEXT NOT NULL PRIMARY KEY,
    authserver_iss TEXT NOT NULL,
    did TEXT,
    handle TEXT,
    pds_url TEXT,
    pkce_verifier TEXT NOT NULL,
    scope TEXT NOT NULL,
    dpop_authserver_nonce TEXT NOT NULL,
    dpop_private_jwk TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS oauth_session (
    did TEXT NOT NULL PRIMARY KEY,
    handle TEXT,
    pds_url TEXT NOT NULL,
    authserver_iss TEXT NOT NULL,
    access_token TEXT,
    refresh_token TEXT,
    dpop_authserver_nonce TEXT NOT NULL,
    dpop_pds_nonce TEXT,
    dpop_private_jwk TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS quiz_scores (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    did TEXT NOT NULL,
    quiz_id TEXT NOT NULL,
    quiz_url TEXT NOT NULL,
    score INTEGER NOT NULL,
    completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    answers JSON NOT NULL,
    social_post_url TEXT,
    UNIQUE(did, quiz_id)
);

CREATE TABLE IF NOT EXISTS social_posts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    did TEXT NOT NULL,
    quiz_id TEXT NOT NULL,
    post_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(did, quiz_id)
);