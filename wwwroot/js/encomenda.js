document.addEventListener('DOMContentLoaded', () => {
  const selecionarTrabalho = document.getElementById('selecionar-Tipo-Trabalho'); // container (deve existir)
  const checkboxTrabalho = document.getElementById('mostrarTipoTrabalho'); //* Conferir depois se continua com ele (checkbox opcional)
  const toggleTrabalho = document.getElementById('selecionarTrabalho-menu'); // área clicável
  const trabalhoSelecionado = document.getElementById('trabalhoSelecionado');

  const selecionarTamanho = document.getElementById('selecionar-Tipo-Tamanho');
  const checkboxTamanho = document.getElementById('mostrarTipoTamanho');
  const toggleTamanho = document.getElementById('selecionarTamanho-menu');
  const tamanhoSelecionado = document.getElementById('tamanhoSelecionado');

  const opcoes = document.getElementById('opcoes'); // UL de opções
  const radios = document.querySelectorAll('#opcoes .opcao input[type="radio"]');

  const opcoesTamanho = document.getElementById('opcoesTamanho'); // UL de opções de tamanho
  const radiosTamanho = document.querySelectorAll('#opcoesTamanho .opcao input[type="radio"]');



  //! Divs que seriam do droptable, ou seja, 
  //! começam em display none até que seja selecionada alguma


    const fioConduzidoOPT = document.getElementById('opt-fio-conduzido');
    const referenciaOpt = document.getElementById('opt-referencia');

    const optPequeno = document.getElementById('opt-Pequeno');
    const optMedio = document.getElementById('opt-Medio');
    const optGrande = document.getElementById('opt-Grande');

    // Seções de conteúdo
    const fioConduzidoSection = document.querySelector('.fio-conduzido');
    const referenciaSection = document.querySelector('.referencia');

  

  if (selecionarTrabalho && !selecionarTrabalho.classList.contains('dropdown')) {
    selecionarTrabalho.classList.add('dropdown');
  }

  if(selecionarTamanho && !selecionarTamanho.classList.contains('dropdown')){
    selecionarTamanho.classList.add('dropdown');
  }

  const textoInicial = 'Não selecionado';

  function estaAberto(open) {
    if (!selecionarTrabalho) return;
    if (open) {
      selecionarTrabalho.classList.add('open');
      if (checkboxTrabalho) checkboxTrabalho.checked = true;
      toggleTrabalho.setAttribute('aria-expanded', 'true');
      
     

      const checked = document.querySelector('.opcao input:checked') || radios[0];
      if (checked) checked.focus();
    } else {

      selecionarTrabalho.classList.remove('open');
      if (checkboxTrabalho) checkboxTrabalho.checked = false;
      toggleTrabalho.setAttribute('aria-expanded', 'false');


    }
  }

  function estaAbertoTamanho(open)
  {
    if(!selecionarTamanho) return;
    if(open){
      selecionarTamanho.classList.add('open');
      if (checkboxTamanho) checkboxTamanho.checked = true;
      toggleTamanho.setAttribute('aria-expanded', 'true');
    
      const checked = document.querySelector('#opcoesTamanho .opcao input:checked') || radiosTamanho[0];
      if (checked) checked.focus();
    
    }
    else{
      selecionarTamanho.classList.remove('open');
      if (checkboxTamanho) checkboxTamanho.checked = false;
      toggleTamanho.setAttribute('aria-expanded', 'false');
    }
  }

  // atualiza visibilidade das 3 divs com base no radio selecionado
  function atualizarSelecao() {
    const fioConduzidoOPT = document.getElementById('opt-fio-conduzido');
    const referenciaOpt = document.getElementById('opt-referencia');
    const isMobile = window.innerWidth < 426;

    if (fioConduzidoOPT && fioConduzidoOPT.checked) {
      if (fioConduzidoSection) {
        fioConduzidoSection.style.display = isMobile ? 'flex' : 'grid';
        if (isMobile) fioConduzidoSection.style.flexDirection = 'column';
      }
      if (referenciaSection) referenciaSection.style.display = 'none';
    } 
    else if (referenciaOpt && referenciaOpt.checked) 
    {
      if (referenciaSection) {
        referenciaSection.style.display = isMobile ? 'flex' : 'grid';
        if (isMobile) referenciaSection.style.flexDirection = 'column';
      }
      if (fioConduzidoSection) fioConduzidoSection.style.display = 'none';
    }
    else {
      // Se nenhum estiver selecionado, esconde ambos
      if (fioConduzidoSection) fioConduzidoSection.style.display = 'none';
      if (referenciaSection) referenciaSection.style.display = 'none';
    }
  }


  // function atualizarSelecaoTamanho()
{
   const optPequeno = document.getElementById('opt-Pequeno');
    const optMedio = document.getElementById('opt-Medio');
    const optGrande = document.getElementById('opt-Grande');

    if(optPequeno) optPequeno.style.display = 'none';
    if(optMedio) optMedio.style.display = 'none';
    if(optGrande) optGrande.style.display = 'none';

    if(optPequeno && optPequeno.checked){
      if(optPequeno) optPequeno.style.display = 'flex';
      if(optMedio) optMedio.style.display = 'none';
      if(optGrande) optGrande.style.display = 'none';
    }
    if(optMedio && optMedio.checked){
      if(optMedio) optMedio.style.display = 'flex';
      if(optPequeno) optPequeno.style.display = 'none';
      if(optGrande) optGrande.style.display = 'none';
    }
    if(optGrande && optGrande.checked){
      if(optGrande) optGrande.style.display = 'flex';
      if(optPequeno) optPequeno.style.display = 'none';
      if(optMedio) optMedio.style.display = 'none';
    }
}
  function trocarCorSelecionado(opcaoLi) {
    const todas = document.querySelectorAll('.opcao');
    todas.forEach(li => {
      const lbl = li.querySelector('label, .texto-complementar1');
      if (lbl) lbl.style.color = '';
      const img = li.querySelector('.img-svg');
      if (img) {
        img.style.filter = '';
        img.style.pointerEvents = '';
      }
    });
  }

  function limparSelecao() {
    radios.forEach(radio => { radio.checked = false; });
    trabalhoSelecionado.textContent = textoInicial;

    // pagamentoSelecionado.style.color = '#AFA8B6'; //cor basica 👌 //! Atencao
    trocarCorSelecionado(null);
    atualizarSelecao(); // Chamando para esconder todas as divs
  }

  function limparSelecaoTamanho() {
    radiosTamanho.forEach(radio => { radio.checked = false; });
    tamanhoSelecionado.textContent = textoInicial;
  }

  if (!selecionarTrabalho || !toggleTrabalho || !opcoes || !trabalhoSelecionado) {
    // console.error('Dropdown: elemento(s) faltando. IDs esperados: selecionar-Tipo-Pagamento, selecionarPagamento-menu, opcoes, pagamentoSelecionado.');
    return 'Dropdown: elemento(s) faltando. IDs esperados: selecionar-Tipo-Pagamento, selecionarPagamento-menu, opcoes, pagamentoSelecionado.';
  }

  estaAberto(false);
  estaAbertoTamanho(false);
  trabalhoSelecionado.textContent = textoInicial;
  tamanhoSelecionado.textContent = textoInicial;
  
//   pagamentoSelecionado.style.color = '#AFA8B6'; //! atencao
  atualizarSelecao(); // voltamos ao estado inicial

  // Aplica efeito visual de focus e desativa pointer events na imagem enquanto focado
  function aplicarEstiloFocus(li) {
    const label = li.querySelector('label, .texto-subtitulo');
    const img = li.querySelector('.img-svg');

    if (label) label.style.color = 'var(--cinza-claro-azulado)';
    if (img) {
      img.style.filter = 'brightness(0) invert(1)';
      img.style.pointerEvents = 'none';
    }
  }

  function removerEstiloFocus(li) {
    const label = li.querySelector('label, .texto-subtitulo');
    const img = li.querySelector('.img-svg');

    if (label) label.style.color = '';
    if (img) {
      img.style.filter = '';
      img.style.pointerEvents = '';
    }
  }


  
  // ============================================================
  //?                     EVENTOS DO DROPTABLE
  // ============================================================


  toggleTrabalho.addEventListener('click', (variavelAmbiente) => {
    variavelAmbiente.stopPropagation(); // evitar que o clique feche o dropdown imediatamente
    const estaAbertoTrabalho = selecionarTrabalho.classList.contains('open');
    if (estaAbertoTrabalho) {
      limparSelecao();
      estaAberto(false);
    } else {
      estaAberto(true);
    }
  });



  if (toggleTamanho) {
    toggleTamanho.addEventListener('click', (variavelAmbiente) => {
      variavelAmbiente.stopPropagation();
      const isOpenTamanho = selecionarTamanho.classList.contains('open');
      if (isOpenTamanho) {
        limparSelecaoTamanho();
        estaAbertoTamanho(false);
      }
      else {
        estaAbertoTamanho(true);
      }
    });
  }


  if (opcoes) {
    opcoes.addEventListener('click', (variavelAmbiente) => {
      variavelAmbiente.stopPropagation();
    });
  }

  if (opcoesTamanho) {
    opcoesTamanho.addEventListener('click', (variavelAmbiente) => {
      variavelAmbiente.stopPropagation();
    });
  }

  // teclado: Enter/Space abre/fecha; se fechar via toggle, limpa
  toggleTrabalho.addEventListener('keydown', (variavelAmbiente) => {
    if (variavelAmbiente.key === 'Enter' || variavelAmbiente.key === ' ') {
      variavelAmbiente.preventDefault();
      const isOpen = selecionarTrabalho.classList.contains('open');
      if (isOpen) {
        limparSelecao();
        estaAberto(false);
      } else {
        estaAberto(true);
      }
    } else if (variavelAmbiente.key === 'Escape') {
      estaAberto(false);
    }
  });

  // quando muda o radio, atualiza o texto e as divs (sem fechar o droptable)
  radios.forEach(radio => {
    const li = radio.closest('.opcao');

    radio.addEventListener('change', () => {
      const label = radio.dataset.label || radio.value || radio.nextElementSibling?.textContent?.trim();
      if (label) {
        trabalhoSelecionado.textContent = label;
        trabalhoSelecionado.style.color = 'var(--marrom';
      }
      atualizarSelecao();
    });

    if (li) {
      li.addEventListener('focusin', () => {
        li.classList.add('focus');
        aplicarEstiloFocus(li);
      });

      li.addEventListener('focusout', () => {
        li.classList.remove('focus');
        removerEstiloFocus(li);
      });
    }
  });

  // Event listeners para os radios de tamanho
  radiosTamanho.forEach(radio => {
    const li = radio.closest('.opcao');

    radio.addEventListener('change', () => {
      const label = radio.dataset.label || radio.value || radio.nextElementSibling?.textContent?.trim();
      if(label)
      {
        tamanhoSelecionado.textContent = label;
        tamanhoSelecionado.style.color = '#FBF9FE';
      }
    });

    if (li) {
      li.addEventListener('focusin', () => {
        li.classList.add('focus');
        aplicarEstiloFocus(li);
      });

      li.addEventListener('focusout', () => {
        li.classList.remove('focus');
        removerEstiloFocus(li);
      });
    }
  });

  // === Garantir via JS que clicar na imagem .img-svg NÃO altera nada ===
  //! PEDIR AJUDA DA KESSIA (TA DANDO BO)
  const imagens = document.querySelectorAll('.img-svg');
  imagens.forEach(img => {
    img.tabIndex = -1; // não focável por teclado
    ['pointerdown', 'mousedown', 'touchstart', 'click'].forEach(evtName => {
      img.addEventListener(evtName, (ev) => {
        ev.stopPropagation();
        ev.preventDefault();
      }, {capture: true, passive: false });
    });
  });


  // fechar ao clicar fora: se o clique NÃO estiver dentro do container e nem dentro do UL #opcoes
  document.addEventListener('click', () => {
    // quando clicar fora, apenas fechar (não limpar)
    if (selecionarTrabalho.classList.contains('open')) {
      estaAberto(false);
    }
    if (selecionarTamanho && selecionarTamanho.classList.contains('open')) {
      estaAbertoTamanho(false);
    }
  });

  // ESC global: fecha sem limpar
  document.addEventListener('keydown', (tecla) => {
    if ((tecla.key === 'Escape' || tecla.key === 'Esc')) {
      if (selecionarTrabalho.classList.contains('open')) {
        estaAberto(false);
      }
      if (selecionarTamanho && selecionarTamanho.classList.contains('open')) {
        estaAbertoTamanho(false);
      }
    }
  });
});
