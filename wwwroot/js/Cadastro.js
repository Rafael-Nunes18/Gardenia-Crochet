document.addEventListener('DOMContentLoaded', () =>
{
    const img2 = document.getElementById('display-none');
    const img1 = document.getElementById('img1');

    const botaoTelefone = document.querySelector('.nao-sou-robo');
    
    botaoTelefone.addEventListener('click', () => {   
        if(botaoTelefone.checked)
        {
        img1.style.display = 'none';
        img2.style.display = 'flex';
        }
    })

})