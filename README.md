# 🏥 Somvanshi Neuro Clinic Management System

A complete, modern clinic management system built with React, Node.js, Express, and PostgreSQL.

## ✨ Features

### Core Modules
- **Reception Module**: Patient registration, vitals entry, search, queue management
- **Doctor Module**: Patient consultation, digital prescriptions, medical records
- **Admin Module**: Analytics, reports, user management (coming soon)

### Key Features
- ✅ Patient Registration with Unique ID Generation
- ✅ Multi-location Support (Jaipur, Delhi, Mumbai)
- ✅ Comprehensive Vitals Tracking (Weight, Height, BMI, BP, Pulse, Temperature, SpO2, Blood Sugar)
- ✅ Digital Prescription Management
- ✅ Medicine Database Search
- ✅ Appointment Scheduling
- ✅ Beautiful, Responsive UI with Framer Motion Animations
- ✅ Real-time Patient Search
- ✅ Visit History Tracking

## 🚀 Quick Start

### Prerequisites
- Node.js (v18 or higher)
- PostgreSQL (v14 or higher)
- Git

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/somvanshi-neuro-clinic.git
cd somvanshi-neuro-clinic
```

2. **Setup Database**
```bash
# Login to PostgreSQL
psql -U postgres

# Create database and user
CREATE DATABASE somvanshi_clinic;
CREATE USER clinic_admin WITH ENCRYPTED PASSWORD 'your_password';
GRANT ALL PRIVILEGES ON DATABASE somvanshi_clinic TO clinic_admin;
\q

# Run schema
psql -U clinic_admin -d somvanshi_clinic -f database/schema.sql
```

3. **Setup Backend**
```bash
cd backend
npm install

# Create .env file
cp .env.example .env

# Edit .env with your database credentials
nano .env

# Start backend server
npm run dev
```

4. **Setup Frontend**
```bash
cd ../frontend
npm install

# Start frontend development server
npm run dev
```

5. **Access the application**
- Frontend: http://localhost:3000
- Backend API: http://localhost:5000
- Health Check: http://localhost:5000/health

## 📁 Project Structure

```
somvanshi-neuro-clinic/
├── backend/
│   ├── src/
│   │   ├── config/          # Database configuration
│   │   ├── controllers/     # Request handlers
│   │   ├── routes/          # API routes
│   │   └── utils/           # Utility functions
│   ├── server.js           # Express server
│   └── package.json
├── frontend/
│   ├── src/
│   │   ├── components/     # React components
│   │   ├── pages/          # Page components
│   │   ├── services/       # API services
│   │   └── App.jsx         # Main app component
│   ├── index.html
│   └── package.json
├── database/
│   └── schema.sql          # Database schema
└── README.md
```

## 🔧 Configuration

### Backend Environment Variables (.env)
```env
PORT=5000
DATABASE_URL=postgresql://clinic_admin:your_password@localhost:5432/somvanshi_clinic
JWT_SECRET=your_super_secret_jwt_key
NODE_ENV=development
FRONTEND_URL=http://localhost:3000
```

### Frontend Configuration
The frontend automatically proxies API requests to `http://localhost:5000` during development.

## 📊 API Endpoints

### Patients
- `POST /api/patients/register` - Register new patient
- `GET /api/patients/search?search=query` - Search patients
- `GET /api/patients/:id` - Get patient details
- `PUT /api/patients/:id` - Update patient
- `POST /api/patients/vitals` - Add vital signs

### Prescriptions
- `POST /api/prescriptions` - Create prescription
- `GET /api/prescriptions/:id` - Get prescription
- `GET /api/prescriptions/patient/:patient_id` - Get patient prescriptions

### Medicines
- `GET /api/prescriptions/medicines/search?search=query` - Search medicines
- `POST /api/prescriptions/medicines` - Add medicine to database

### Appointments
- `POST /api/appointments` - Create appointment
- `GET /api/appointments?date=YYYY-MM-DD` - Get appointments by date
- `PUT /api/appointments/:id/status` - Update appointment status

## 🚀 Production Deployment

### Deploy to VPS (Hostinger/DigitalOcean/AWS)

1. **SSH into your VPS**
```bash
ssh root@your_vps_ip
```

2. **Install dependencies**
```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Install PostgreSQL
sudo apt install -y postgresql postgresql-contrib

# Install PM2
sudo npm install -g pm2

# Install NGINX
sudo apt install -y nginx
```

3. **Setup database**
```bash
sudo -u postgres psql
CREATE DATABASE somvanshi_clinic;
CREATE USER clinic_admin WITH ENCRYPTED PASSWORD 'strong_password_here';
GRANT ALL PRIVILEGES ON DATABASE somvanshi_clinic TO clinic_admin;
\q
```

4. **Deploy application**
```bash
cd /var/www
git clone your_repository_url somvanshi-clinic
cd somvanshi-clinic

# Setup backend
cd backend
npm install --production
cp .env.example .env
nano .env  # Edit with production values
pm2 start server.js --name clinic-api
pm2 save
pm2 startup

# Build frontend
cd ../frontend
npm install
npm run build
```

5. **Configure NGINX**
```bash
sudo nano /etc/nginx/sites-available/clinic
```

Add this configuration:
```nginx
server {
    listen 80;
    server_name your_domain.com;

    # Frontend
    location / {
        root /var/www/somvanshi-clinic/frontend/dist;
        try_files $uri $uri/ /index.html;
    }

    # Backend API
    location /api {
        proxy_pass http://localhost:5000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

```bash
sudo ln -s /etc/nginx/sites-available/clinic /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

## 🧪 Testing

### Test Backend API
```bash
# Health check
curl http://localhost:5000/health

# Register patient
curl -X POST http://localhost:5000/api/patients/register \
  -H "Content-Type: application/json" \
  -d '{"name":"Test Patient","mobile":"9876543210","age":30,"gender":"Male"}'
```

## 🛠️ Tech Stack

- **Frontend**: React 18, Vite, TailwindCSS, Framer Motion, React Router, Axios
- **Backend**: Node.js, Express.js, PostgreSQL
- **DevOps**: PM2, NGINX, Git

## 📝 License

MIT License - feel free to use this project for your clinic!

## 👨‍💻 Author

Developed by **Somvanshi Neuro**

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📞 Support

For support, email support@somvanshi.com or create an issue on GitHub.

---

Made with ❤️ for modern healthcare management
