//dios
//virgencita y san jose
//santos y angeles de dios
//  confesionesview.swift
//  diosvirgencita
//
//  Created by Havit on 31/07/26.
//

import SwiftUI
struct MandamientoItem: Identifiable {
    let id = UUID()
    let numero: String
    let titulo: String
    let preguntas: [String]
}
struct confesionesview: View {
    @State private var pecadoRevisado: Set<String> = []
        
        let mandamientos: [MandamientoItem] = [
            MandamientoItem(
                numero: "1º",
                titulo: "Amarás a Dios sobre todas las cosas",
                preguntas: [
                    "¿He dudado o renegado voluntariamente de la fe?",
                    "¿He practicado supersticiones o espiritismo?",
                    "¿He dejado de orar con frecuencia o he asistido a misa sin devoción?"
                ]
            ),
            MandamientoItem(
                numero: "2º",
                titulo: "No tomarás el nombre de Dios en vano",
                preguntas: [
                    "¿He usado el nombre de Dios con ira, irreverencia o en vano?",
                    "¿He blasfemado o jurado en falso?"
                ]
            ),
            MandamientoItem(
                numero: "3º",
                titulo: "Santificarás las fiestas",
                preguntas: [
                    "¿Falté a Misa los domingos o días de precepto sin causa grave?",
                    "¿He dejado de guardar el descanso dominical?"
                ]
            ),
            MandamientoItem(
                numero: "4º",
                titulo: "Honrarás a tu padre y a tu madre",
                preguntas: [
                    "¿He sido desobediente, desrespetuoso o faltado al amor a mis padres?",
                    "¿He desatendido a mi familia o mis responsabilidades en el hogar?"
                ]
            ),
            MandamientoItem(
                numero: "5º",
                titulo: "No matarás",
                preguntas: [
                    "¿He guardado rencor, odio o deseos de venganza?",
                    "¿He provocado peleas, herido a alguien con mis palabras o acciones?",
                    "¿He descuidado mi salud o promovido hábitos dañinos?"
                ]
            ),
            MandamientoItem(
                numero: "6º y 9º",
                titulo: "Pureza en obras, pensamientos y deseos",
                preguntas: [
                    "¿He consumido contenido impuro o pornográfico?",
                    "¿He consentido pensamientos, palabras o actos impuros?"
                ]
            ),
            MandamientoItem(
                numero: "7º y 10º",
                titulo: "No robarás ni codiciarás bienes ajenos",
                preguntas: [
                    "¿He tomado algo que no es mío sin permiso?",
                    "¿He tenido envidia de los bienes, logros o éxito de los demás?",
                    "¿He sido egoísta o poco generoso con los necesitados?"
                ]
            ),
            MandamientoItem(
                numero: "8º",
                titulo: "No dirás falso testimonio ni mentirás",
                preguntas: [
                    "¿He dicho mentiras para beneficiarme o dañar a otros?",
                    "¿He hablado mal de otras personas (chismes/maledicencia)?"
                ]
            )
        ]

        var body: some View {
            NavigationView {
                ScrollView {
                    VStack(spacing: 20) {
                        
                        // ✝️ Banner Superior
                        VStack(spacing: 8) {
                            Image(systemName: "cross.vessel.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.purple)
                                .padding(.top, 10)
                            
                            Text("Santo Sacramento de la Reconciliación")
                                .font(.title2.bold())
                                .multilineTextAlignment(.center)
                            
                            Text("«Si confesamos nuestros pecados, Él es fiel y justo para perdonarnos.» (1 Jn 1, 9)")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        
                        // 📋 Pasos para una buena confesión
                        VStack(alignment: .leading, spacing: 10) {
                            Text("5 Pasos para una Buena Confesión")
                                .font(.headline)
                                .foregroundColor(.purple)
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Text("1. Examen de conciencia.")
                                Text("2. Dolor de los pecados (arrepentimiento).")
                                Text("3. Propósito de enmienda (no volver a pecar).")
                                Text("4. Confesar los pecados al sacerdote.")
                                Text("5. Cumplir la penitencia.")
                            }
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.purple.opacity(0.1))
                        .cornerRadius(12)
                        .padding(.horizontal)

                        // 🔍 Examen de Conciencia
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Examen de Conciencia")
                                .font(.title3.bold())
                                .padding(.horizontal)

                            ForEach(mandamientos) { item in
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Text(item.numero)
                                            .font(.caption.bold())
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(Color.purple)
                                            .foregroundColor(.white)
                                            .cornerRadius(6)
                                        
                                        Text(item.titulo)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                    }
                                    
                                    ForEach(item.preguntas, id: \.self) { pregunta in
                                        HStack(alignment: .top) {
                                            Button(action: {
                                                if pecadoRevisado.contains(pregunta) {
                                                    pecadoRevisado.remove(pregunta)
                                                } else {
                                                    pecadoRevisado.insert(pregunta)
                                                }
                                            }) {
                                                Image(systemName: pecadoRevisado.contains(pregunta) ? "checkmark.square.fill" : "square")
                                                    .foregroundColor(pecadoRevisado.contains(pregunta) ? .purple : .gray)
                                                    .font(.title3)
                                            }
                                            
                                            Text(pregunta)
                                                .font(.subheadline)
                                                .foregroundColor(.primary)
                                        }
                                        .padding(.vertical, 2)
                                    }
                                }
                                .padding()
                                .background(Color(UIColor.secondarySystemGroupedBackground))
                                .cornerRadius(12)
                                .padding(.horizontal)
                            }
                        }

                        // 🤲 Acto de Contrición
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Acto de Contrición (Oración)")
                                .font(.headline)
                                .foregroundColor(.purple)
                            
                            Text("«Señor mío y Dios mío, me arrepiento de todo corazón de todos mis pecados, porque con ellos he merecido las penas del infierno y he perdido el cielo, pero sobre todo porque te ofendí a Ti, que eres infinitamente bueno y digno de ser amado sobre todas las cosas. Propongo firmemente, con la ayuda de tu gracia, no volver a pecar y huir de las ocasiones de pecado. Amén.»")
                                .font(.footnote)
                                .italic()
                                .foregroundColor(.primary)
                        }
                        .padding()
                        .background(Color(UIColor.systemBackground))
                        .cornerRadius(12)
                        .shadow(radius: 2)
                        .padding(.horizontal)
                        .padding(.bottom, 30)
                    }
                }
                .navigationTitle("Guía de Confesión")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
#Preview {
    confesionesview()
}
