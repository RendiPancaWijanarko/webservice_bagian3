import json
from fastapi import FastAPI, HTTPException
from typing import Dict, Any, List

app = FastAPI()

# Fungsi untuk mengonversi nilai huruf menjadi angka
def konversi_nilai(nilai: str) -> float:
    if nilai == "A":
        return 4.0
    elif nilai == "A-":
        return 3.7
    elif nilai == "B+":
        return 3.3
    elif nilai == "B":
        return 3.0
    elif nilai == "B-":
        return 2.7
    elif nilai == "C+":
        return 2.3
    elif nilai == "C":
        return 2.0
    elif nilai == "C-":
        return 1.7
    elif nilai == "D":
        return 1.0
    else:
        return 0.0

# Fungsi untuk menghitung IPK
def hitung_ipk(transkrip: Dict[str, Any]) -> float:
    total_sks = 0
    total_bobot = 0

    for mata_kuliah in transkrip["mahasiswa"]["mata_kuliah"]:
        sks = mata_kuliah["sks"]
        nilai = mata_kuliah["nilai"]
        bobot = konversi_nilai(nilai)

        total_sks += sks
        total_bobot += sks * bobot

    if total_sks == 0:
        return 0
    else:
        return total_bobot / total_sks

# Baca transkrip dari file JSON
def baca_transkrip(filename: str) -> Dict[str, Any]:
    try:
        with open(filename) as f:
            return json.load(f)
    except FileNotFoundError:
        print("File transkrip tidak ditemukan:", filename) 
        raise HTTPException(status_code=404, detail="File transkrip tidak ditemukan")

@app.get("/ipk")
def get_ipk() -> Dict[str, float]:
    transkrip = baca_transkrip('lib/transcript.json')
    ipk = hitung_ipk(transkrip)
    return {"IPK": ipk}
