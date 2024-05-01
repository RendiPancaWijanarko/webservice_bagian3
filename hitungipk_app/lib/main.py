from fastapi import FastAPI
from fastapi.responses import JSONResponse
from typing import List, Optional
from pydantic import BaseModel

app = FastAPI()

class MataKuliah(BaseModel):
    kode: str
    nama: str
    sks: int
    nilai: str

class Mahasiswa(BaseModel):
    nim: str
    nama: str
    prodi: str
    semester: int
    ip: float
    matkul: List[MataKuliah]

@app.get("/mahasiswa/", response_model=List[Mahasiswa])
async def get_mahasiswa():
    # Simulasi data dari file transkrip.json
    transkrip_data = [
        {
            "nim": "21082010016",
            "nama": "Rendi Panca Wijanarko",
            "prodi": "Sistem Informasi",
            "semester": 6,
            "ip": 3.9,
            "matkul": [
                {"kode": "SI123", "nama": "Pemrograman Berorientasi Objek", "sks": 3, "nilai": "A"},
                {"kode": "SI124", "nama": "Struktur Data", "sks": 3, "nilai": "B"}
            ]
        }
    ]
    mahasiswa_list = []
    for data in transkrip_data:
        mahasiswa_list.append(Mahasiswa(**data))
    return mahasiswa_list

@app.get("/mahasiswa/{nim}", response_model=Mahasiswa)
async def get_single_mahasiswa(nim: str):
    # Simulasi data dari file transkrip.json
    transkrip_data = {
        "21082010016": {
            "nim": "21082010016",
            "nama": "Rendi Panca Wijanarko",
            "prodi": "Sistem Informasi",
            "semester": 6,
            "ip": 3.9,
            "matkul": [
                {"kode": "SI123", "nama": "Pemrograman Berorientasi Objek", "sks": 3, "nilai": "A"},
                {"kode": "SI124", "nama": "Struktur Data", "sks": 3, "nilai": "B"}
            ]
        }
    }
    if nim in transkrip_data:
        return Mahasiswa(**transkrip_data[nim])
    else:
        return JSONResponse(status_code=404, content={"message": "Mahasiswa not found"})

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)