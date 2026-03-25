CREATE TYPE urgency_level_enum AS ENUM ('Low', 'Medium', 'High', 'Emergency');

CREATE TABLE AI_Triage_Session ( 
    triage_id SERIAL PRIMARY KEY, 
    patient_id INT NOT NULL, 
    symptoms_input JSONB NOT NULL, 
    ai_assessment TEXT, 
    urgency_level urgency_level_enum, 
    recommended_specialization VARCHAR(100), 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 

    CONSTRAINT fk_patient 
        FOREIGN KEY (patient_id) 
        REFERENCES Patient(patient_id) 
        ON DELETE CASCADE 
);