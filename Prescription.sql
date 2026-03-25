CREATE TABLE Prescription ( 
    prescription_id SERIAL PRIMARY KEY, 
    consultation_id INT NOT NULL, 
    medication_name VARCHAR(150) NOT NULL, 
    dosage VARCHAR(100) NOT NULL, 
    frequency VARCHAR(100), 
    duration VARCHAR(50), 
    instructions TEXT, 
    issued_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 

    CONSTRAINT fk_prescription_consult 
        FOREIGN KEY (consultation_id) 
        REFERENCES Consultation(consultation_id) 
        ON DELETE CASCADE
);