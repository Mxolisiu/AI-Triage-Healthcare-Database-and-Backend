CREATE TABLE Telehealth_Session (
    session_id SERIAL PRIMARY KEY,
    consultation_id INT UNIQUE,
    session_link TEXT,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    session_status VARCHAR(50) DEFAULT 'Pending',
    CONSTRAINT fk_consultation FOREIGN KEY(consultation_id) REFERENCES Consultation(consultation_id) ON DELETE CASCADE
);