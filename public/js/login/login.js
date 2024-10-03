document.getElementById("form-login").addEventListener("submit", function(e) {
    e.preventDefault();

    let usuario = document.getElementById("usuario").value;
    let passusuario = document.getElementById("passusuario").value;

    let form = new FormData()
    form.append("usuario", usuario)
    form.append("passusuario", passusuario)
    
    axios.post('/login', form)
    .then(response => {
        if (response.data.permitido) {
            let rolDefault = response.data.rol
            let rol = rolDefault.toLowerCase()
            window.location.href = "/" + rol + "/dashboard";
        } else {
            alert(response.data.status);
        }
       console.log(response)
    })
    .catch(error => {
        console.error("Error durante el login", error);
    });
});