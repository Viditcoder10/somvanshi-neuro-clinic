-- Somvanshi Neuro Clinic Management System Database Schema

-- Drop existing tables if they exist
DROP TABLE IF EXISTS medicines CASCADE;
DROP TABLE IF EXISTS prescriptions CASCADE;
DROP TABLE IF EXISTS appointments CASCADE;
DROP TABLE IF EXISTS vitals CASCADE;
DROP TABLE IF EXISTS patients CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS medicine_database CASCADE;

-- Patients Table
CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    patient_id VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    mobile VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(255),
    age INTEGER,
    gender VARCHAR(20),
    date_of_birth DATE,
    address TEXT,
    emergency_contact VARCHAR(15),
    blood_group VARCHAR(5),
    allergies TEXT,
    medical_history TEXT,
    location VARCHAR(50) DEFAULT 'JPN',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Vitals Table
CREATE TABLE vitals (
    id SERIAL PRIMARY KEY,
    patient_id INTEGER REFERENCES patients(id) ON DELETE CASCADE,
    visit_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    weight DECIMAL(5,2),
    height DECIMAL(5,2),
    bmi DECIMAL(5,2),
    bp_systolic INTEGER,
    bp_diastolic INTEGER,
    pulse INTEGER,
    temperature DECIMAL(4,2),
    spo2 INTEGER,
    blood_sugar INTEGER,
    created_by INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Prescriptions Table
CREATE TABLE prescriptions (
    id SERIAL PRIMARY KEY,
    patient_id INTEGER REFERENCES patients(id) ON DELETE CASCADE,
    doctor_id INTEGER NOT NULL,
    visit_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    chief_complaint TEXT,
    diagnosis TEXT,
    advice TEXT,
    follow_up_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Medicines Table (per prescription)
CREATE TABLE medicines (
    id SERIAL PRIMARY KEY,
    prescription_id INTEGER REFERENCES prescriptions(id) ON DELETE CASCADE,
    medicine_name VARCHAR(255) NOT NULL,
    dosage VARCHAR(100),
    duration VARCHAR(50),
    instructions TEXT,
    quantity INTEGER
);

-- Appointments Table
CREATE TABLE appointments (
    id SERIAL PRIMARY KEY,
    patient_id INTEGER REFERENCES patients(id) ON DELETE CASCADE,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status VARCHAR(50) DEFAULT 'scheduled',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Users Table (Doctors, Staff, Admin)
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL,
    location VARCHAR(50),
    qualification VARCHAR(255),
    registration_number VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Medicine Database Table
CREATE TABLE medicine_database (
    id SERIAL PRIMARY KEY,
    brand_name VARCHAR(255) NOT NULL,
    generic_name VARCHAR(255),
    salt_composition TEXT,
    manufacturer VARCHAR(255),
    medicine_type VARCHAR(100),
    price DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Indexes for better performance
CREATE INDEX idx_patient_mobile ON patients(mobile);
CREATE INDEX idx_patient_id ON patients(patient_id);
CREATE INDEX idx_patient_name ON patients(name);
CREATE INDEX idx_appointments_date ON appointments(appointment_date);
CREATE INDEX idx_vitals_patient ON vitals(patient_id);
CREATE INDEX idx_prescriptions_patient ON prescriptions(patient_id);
CREATE INDEX idx_medicine_brand ON medicine_database(brand_name);
CREATE INDEX idx_medicine_generic ON medicine_database(generic_name);

-- Insert sample data for testing

-- Sample user (Doctor)
INSERT INTO users (name, email, password, role, qualification, registration_number) 
VALUES 
('Dr. Somvanshi', 'doctor@somvanshi.com', 'password123', 'doctor', 'MBBS, MD (Neurology)', 'MCI-12345');

-- Sample medicines
INSERT INTO medicine_database (brand_name, generic_name, salt_composition, manufacturer, medicine_type, price) VALUES
('Crocin', 'Paracetamol', 'Paracetamol 500mg', 'GSK', 'Tablet', 2.50),
('Brufen', 'Ibuprofen', 'Ibuprofen 400mg', 'Abbott', 'Tablet', 5.00),
('Amoxycillin', 'Amoxicillin', 'Amoxicillin 500mg', 'Cipla', 'Capsule', 8.50),
('Pantoprazole', 'Pantoprazole', 'Pantoprazole 40mg', 'Sun Pharma', 'Tablet', 6.00),
('Azithromycin', 'Azithromycin', 'Azithromycin 500mg', 'Pfizer', 'Tablet', 12.00),
('Cetirizine', 'Cetirizine', 'Cetirizine 10mg', 'Dr Reddys', 'Tablet', 3.00),
('Metformin', 'Metformin', 'Metformin 500mg', 'USV', 'Tablet', 4.50),
('Atorvastatin', 'Atorvastatin', 'Atorvastatin 10mg', 'Ranbaxy', 'Tablet', 7.00),
('Levipil', 'Levetiracetam', 'Levetiracetam 500mg', 'Sun Pharma', 'Tablet', 15.00),
('Encorate', 'Sodium Valproate', 'Sodium Valproate 500mg', 'Sun Pharma', 'Tablet', 10.00);

COMMENT ON TABLE patients IS 'Stores patient demographic and medical history';
COMMENT ON TABLE vitals IS 'Records patient vital signs for each visit';
COMMENT ON TABLE prescriptions IS 'Stores doctor prescriptions';
COMMENT ON TABLE medicines IS 'Medicines prescribed in each prescription';
COMMENT ON TABLE appointments IS 'Patient appointment scheduling';
COMMENT ON TABLE users IS 'System users (doctors, staff, admin)';
COMMENT ON TABLE medicine_database IS 'Master list of available medicines';
