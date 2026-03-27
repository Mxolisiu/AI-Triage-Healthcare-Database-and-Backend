import express from 'express'
import cors from 'cors'
import supabase from './supabaseClient.js'
import { analyzeSymptoms } from './ai.js'

const app = express()
app.use(cors())
app.use(express.json())

// TEST ROUTE
app.get('/', (req, res) => {
    res.send("Backend is working ")
})

// MAIN API
app.post('/symptom-check', async (req, res) => {

    const { patient_id, symptoms } = req.body

    try {
        // 1. Save symptom
        const { data: symptom, error: e1 } = await supabase
            .from('Symptom')
            .insert([{ patient_id, description: symptoms }])
            .select()

        if (e1) throw e1

        // 2. AI analysis
        const result = analyzeSymptoms(symptoms)

        // 3. Save triage
        const { data: triage, error: e2 } = await supabase
            .from('Triage')
            .insert([{
                symptom_id: symptom[0].symptom_id,
                urgency: result.urgency,
                specialty: result.specialty
            }])
            .select()

        if (e2) throw e2

        // 4. Find clinician
        const { data: clinicians, error: e3 } = await supabase
            .from('Clinician')
            .select('*')
            .eq('specialty', result.specialty)
            .eq('available', true)
            .limit(1)

        if (e3) throw e3

        if (!clinicians.length) {
            return res.send("No doctor available")
        }

        const clinician = clinicians[0]

        // 5. Create appointment
        const { data: appointment, error: e4 } = await supabase
            .from('Appointment')
            .insert([{
                patient_id,
                clinician_id: clinician.clinician_id,
                triage_id: triage[0].triage_id,
                status: "SCHEDULED"
            }])
            .select()

        if (e4) throw e4

        // 6. Create telehealth session
        const link = `https://telehealth.com/session/${appointment[0].appointment_id}`

        await supabase
            .from('TelehealthSession')
            .insert([{
                appointment_id: appointment[0].appointment_id,
                session_link: link
            }])

        // FINAL RESPONSE
        res.json({
            urgency: result.urgency,
            doctor: clinician.name,
            link: link
        })

    } catch (error) {
        console.error(error)
        res.status(500).send("Error occurred")
    }
})

app.listen(3000, () => {
    console.log(" Server running on http://localhost:3000")
})