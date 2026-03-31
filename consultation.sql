CREATE TABLE Consultation (
    consultation_id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    clinician_id INT NOT NULL,
    triage_id INT,
    consultation_date TIMESTAMP,
    status VARCHAR(50) CHECK (status IN ('Scheduled', 'Completed', 'Cancelled')) DEFAULT 'Scheduled',
    notes TEXT,
    CONSTRAINT fk_patient_consult FOREIGN KEY(patient_id) REFERENCES Patient(patient_id) ON DELETE CASCADE,
    CONSTRAINT fk_clinician FOREIGN KEY(clinician_id) REFERENCES Clinician(clinician_id) ON DELETE SET NULL,
    CONSTRAINT fk_triage FOREIGN KEY(triage_id) REFERENCES AI_Triage_Session(triage_id)
);