CREATE TABLE Appointment_Schedule ( 
    schedule_id SERIAL PRIMARY KEY, 
    clinician_id INT NOT NULL, 
    available_date DATE NOT NULL, 
    start_time TIME NOT NULL, 
    end_time TIME NOT NULL, 
    is_booked BOOLEAN DEFAULT FALSE, 

    CONSTRAINT fk_schedule_clinician 
        FOREIGN KEY (clinician_id) 
        REFERENCES Clinician(clinician_id) 
        ON DELETE CASCADE,

    CONSTRAINT chk_time_valid 
        CHECK (end_time > start_time),

    CONSTRAINT unique_schedule 
        UNIQUE (clinician_id, available_date, start_time)
);