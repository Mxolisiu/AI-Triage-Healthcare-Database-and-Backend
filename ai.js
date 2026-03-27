export function analyzeSymptoms(symptoms) {

    symptoms = symptoms.toLowerCase();

    if (symptoms.includes("chest pain")) {
        return { urgency: "HIGH", specialty: "Cardiologist" };
    } 
    else if (symptoms.includes("fever")) {
        return { urgency: "MEDIUM", specialty: "General Doctor" };
    } 
    else {
        return { urgency: "LOW", specialty: "General Doctor" };
    }
}