const apiUrl = "http://localhost:3000";
let todosLosJefes = [];
let mapaFases = {};

async function cargarJefes() {
  try {
    const [jRes, fRes] = await Promise.all([
      fetch(`${apiUrl}/jefes`),
      fetch(`${apiUrl}/fases`)
    ]);
    const jefes = await jRes.json();
    const fases = await fRes.json();

    mapaFases = {};
    fases.forEach(f => { mapaFases[f.ID_Fase] = f.Nombre_Fase; });

    todosLosJefes = jefes;
    pintarJefes(todosLosJefes);
  } catch (e) {
    console.error("Error al cargar jefes/fases:", e);
  }
}



function pintarJefes(lista) {
  const cont = document.getElementById("listaJefes");
  cont.innerHTML = "";

  if (lista.length === 0) {
    cont.innerHTML = `
      <div class="col-12">
        <p class="text-center text-white">No se encontraron jefes 😢</p>
      </div>`;
    return;
  }

  lista.forEach(j => {
    const col = document.createElement("div");
    col.className = "col-md-2 mb-4";

    const card = document.createElement("div");
    card.className = "card bg-dark text-white h-100 shadow";

    const nombreArchivo = j.Nombre_Jefe
      .toLowerCase()
      .replace(/\s+/g, "_") + ".jpg";

    let claseImagenPersonalizada = "";
    if (j.Nombre_Jefe === "Cronos") {
      claseImagenPersonalizada = "ajustar-cronos";
    } if (j.Nombre_Jefe === "Hephaestus") {
      claseImagenPersonalizada = "ajustar-hephaestus";
    } if (j.Nombre_Jefe === "Medusa") {
      claseImagenPersonalizada = "ajustar-medusa";
    } if (j.Nombre_Jefe === "Desert Syrens") {
      claseImagenPersonalizada = "ajustar-desertsyren";
    } if (j.Nombre_Jefe === "The Last Spartan") {
      claseImagenPersonalizada = "ajustar-desertsyren";
    } if (j.Nombre_Jefe === "Dark Raider and Dark Griffin") {
      claseImagenPersonalizada = "ajustar-desertsyren";
    } if (j.Nombre_Jefe === "Theseus") {
      claseImagenPersonalizada = "ajustar-desertsyren";
    } if (j.Nombre_Jefe === "Barbarian King") {
      claseImagenPersonalizada = "ajustar-barbarian";
    } if (j.Nombre_Jefe === "Pandoras Guardian") {
      claseImagenPersonalizada = "ajustar-desertsyren";
    } if (j.Nombre_Jefe === "Zeus") {
      claseImagenPersonalizada = "ajustar-desertsyren";
    } if (j.Nombre_Jefe === "Euryale") {
      claseImagenPersonalizada = "ajustar-euryale";
    }


    card.innerHTML = `
      <img src="${apiUrl}/images/${nombreArchivo}"
           class="card-img-top jefe-img ${claseImagenPersonalizada}"
           alt="${j.Nombre_Jefe}"
           onerror="this.src='https://via.placeholder.com/400x200?text=Sin+Imagen'">

      <div class="card-body">
        <h5 class="card-title">${j.Nombre_Jefe}</h5>
        <p><strong>Descripción:</strong> ${j.Descripcion_Jefe}</p>
        <p><strong>Vida:</strong> ${j.Vida_Jefe}</p>
        <p><strong>Recompensa:</strong> ${j.Recompensa_Jefe}</p>
        <hr class="border-secondary">
        <p><strong>Fase 1:</strong> ${mapaFases[j.ID_Fase] || "Desconocida"}</p>
        <p><strong>Fase 2:</strong> ${mapaFases[j.ID_Fase2] || "Desconocida"}</p>
      </div>`;

    col.appendChild(card);
    cont.appendChild(col);
  });
}

document.getElementById("btnBuscar").addEventListener("click", () => {
  const texto = document.getElementById("buscador")
    .value.toLowerCase().trim();
  const filtrados = todosLosJefes.filter(j =>
    j.Nombre_Jefe.toLowerCase().includes(texto)
  );
  pintarJefes(filtrados);
});

cargarJefes();