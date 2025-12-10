document.addEventListener('DOMContentLoaded', () => {
  const selecionarPagamento = document.getElementById('selecionar-Tipo-Pagamento'); // container (deve existir)
  const checkbox = document.getElementById('mostrarTipoPagamento'); //* Conferir depois se continua com ele (checkbox opcional)
  const toggle = document.getElementById('selecionarPagamento-menu'); // área clicável
  const opcoes = document.getElementById('opcoes'); // UL (irmã do checkbox)
  const pagamentoSelecionado = document.getElementById('pagamentoSelecionado');
  const radios = document.querySelectorAll('.opcao input[type="radio"]');
  //? const que seria das selecoes do droptables



  //! Divs que seriam do droptable, ou seja, 
  //! começam em display none até que seja selecionada alguma
  const pixDiv = document.querySelector('.pix-selecionado');
  const cartaoDiv = document.querySelector('.cartao-selecionado');
  const boletoDiv = document.querySelector('.boleto-selecionado');

  if (selecionarPagamento && !selecionarPagamento.classList.contains('dropdown')) {
    selecionarPagamento.classList.add('dropdown');
  }

  const textoInicial = 'Não selecionado';

  function estaAberto(open) {
    if (!selecionarPagamento) return;
    if (open) {
      selecionarPagamento.classList.add('open');
      if (checkbox) checkbox.checked = true;
      toggle.setAttribute('aria-expanded', 'true');
      const checked = document.querySelector('.opcao input:checked') || radios[0];
      if (checked) checked.focus();
    } else {
      selecionarPagamento.classList.remove('open');
      if (checkbox) checkbox.checked = false;
      toggle.setAttribute('aria-expanded', 'false');
    }
  }

  // atualiza visibilidade das 3 divs com base no radio selecionado
  function atualizarSelecao() {
    const pixRadio = document.getElementById('opt-pix');
    const cartaoRadio = document.getElementById('opt-cartao');
    const boletoRadio = document.getElementById('opt-boleto');

    if (pixDiv) pixDiv.style.display = 'none';
    if (cartaoDiv) cartaoDiv.style.display = 'none';
    if (boletoDiv) boletoDiv.style.display = 'none';

    if (pixRadio && pixRadio.checked) {
      if (pixDiv) pixDiv.style.display = 'flex';
      if (cartaoDiv) cartaoDiv.style.display = 'none';
      if (boletoDiv) boletoDiv.style.display = 'none';
    } 
    else if (cartaoRadio && cartaoRadio.checked) 
    {
      if (cartaoDiv) cartaoDiv.style.display = 'grid';
      if (pixDiv) pixDiv.style.display = 'none';
      if (boletoDiv) boletoDiv.style.display = 'none';
    }
    else if (boletoRadio && boletoRadio.checked) 
    {
      if (boletoDiv) boletoDiv.style.display = 'flex';
      if (pixDiv) pixDiv.style.display = 'none';
      if (cartaoDiv) cartaoDiv.style.display = 'none';
    }
    else 
    {
      if (pixDiv) pixDiv.style.display = 'none';
      if (cartaoDiv) cartaoDiv.style.display = 'none';
      if (boletoDiv) boletoDiv.style.display = 'none';
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
    pagamentoSelecionado.textContent = textoInicial;
    pagamentoSelecionado.style.color = '#AFA8B6'; //cor basica 👌
    trocarCorSelecionado(null);
    atualizarSelecao(); // Chamando para esconder todas as divs
  }

  if (!selecionarPagamento || !toggle || !opcoes || !pagamentoSelecionado) {
    // console.error('Dropdown: elemento(s) faltando. IDs esperados: selecionar-Tipo-Pagamento, selecionarPagamento-menu, opcoes, pagamentoSelecionado.');
    return 'Dropdown: elemento(s) faltando. IDs esperados: selecionar-Tipo-Pagamento, selecionarPagamento-menu, opcoes, pagamentoSelecionado.';
  }

  estaAberto(false);
  pagamentoSelecionado.textContent = textoInicial;
  pagamentoSelecionado.style.color = '#AFA8B6';
  atualizarSelecao(); // voltamos ao estado inicial

  // Aplica efeito visual de focus e desativa pointer events na imagem enquanto focado
  function aplicarEstiloFocus(li) {
    const label = li.querySelector('label, .texto-complementar1');
    const img = li.querySelector('.img-svg');

    if (label) label.style.color = '#FFFFFF';
    if (img) {
      img.style.filter = 'brightness(0) invert(1)';
      img.style.pointerEvents = 'none';
    }
  }

  function removerEstiloFocus(li) {
    const label = li.querySelector('label, .texto-complementar1');
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


  toggle.addEventListener('click', (variavelAmbiente) => {
    variavelAmbiente.stopPropagation(); // evitar que o clique feche o dropdown imediatamente
    const isOpen = selecionarPagamento.classList.contains('open');
    if (isOpen) {
      limparSelecao();
      estaAberto(false);
    } else {
      estaAberto(true);
    }
  });


  opcoes.addEventListener('click', (variavelAmbiente) => {
    variavelAmbiente.stopPropagation();
  });

  // teclado: Enter/Space abre/fecha; se fechar via toggle, limpa
  toggle.addEventListener('keydown', (variavelAmbiente) => {
    if (variavelAmbiente.key === 'Enter' || variavelAmbiente.key === ' ') {
      variavelAmbiente.preventDefault();
      const isOpen = selecionarPagamento.classList.contains('open');
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
        pagamentoSelecionado.textContent = label;
        pagamentoSelecionado.style.color = '#FBF9FE';
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

  // === Garantir via JS que clicar na imagem .img-svg NÃO altera nada ===
  //! PEDIR AJUDA DA KESSIA (TA DANDO BO)
  const imagens = document.querySelectorAll('.img-svg');
  imagens.forEach(img => {
    img.tabIndex = -1; // não focável por teclado
    ['pointerdown', 'mousedown', 'touchstart', 'click'].forEach(evtName => {
      img.addEventListener(evtName, (ev) => {
        ev.stopPropagation();
        ev.preventDefault();
      }, { capture: true, passive: false });
    });
  });

  // === CONTROLE DE QUANTIDADE E ATUALIZAÇÃO DE PREÇO ===

  // Parse flexível de string de preço para número (BRL)
  function parsePriceToNumber(priceStr) {
    if (!priceStr || typeof priceStr !== 'string') return 0;
    let s = priceStr.replace(/[^\d.,-]/g, '').trim(); //ajuda basica do chat 👌
    //* detectar uso de separadores
    const hasDot = s.indexOf('.') !== -1;
    const hasComma = s.indexOf(',') !== -1;
    if (hasDot && hasComma) {
      //* pontos como milhares, vírgula como decimal
      s = s.replace(/\./g, '').replace(',', '.');
    } else if (hasComma && !hasDot) {
      // vírgula => decimal
      s = s.replace(',', '.');
    } else {
      // só ponto ou só números: manter
      s = s;
    }
    const v = parseFloat(s);
    return Number.isFinite(v) ? v : 0;
  }

  // Formata número para BRL (R$ 1.234,56)
  function formatNumberToBRL(value) {
    return value.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
  }

  // Atualiza os totais do carrinho (valor dos produtos e totalPagar = valorProdutos + frete)
  function atualizarValorCarrinho() {
    const priceEls = document.querySelectorAll('.produto-preco');
    let soma = 0;
    priceEls.forEach(el => {
      soma += parsePriceToNumber(el.textContent || el.innerText || '');
    });

    const valorTotalEl = document.getElementById('valorTotal');
    if (valorTotalEl) valorTotalEl.textContent = formatNumberToBRL(soma);

    const freteEl = document.getElementById('frete');
    const freteVal = freteEl ? parsePriceToNumber(freteEl.textContent || '') : 0;

    const totalPagarEl = document.getElementById('totalPagar');
    if (totalPagarEl) totalPagarEl.textContent = formatNumberToBRL(soma + freteVal);
  }

  // Inicializa preço unitário e atualiza exibição com base na quantidade atual
  function setarPrecos_Quantidades() {
    const itens = document.querySelectorAll('.produto-selecionado');
    itens.forEach(item => {
      const elPreco = item.querySelector('.produto-preco');
      const elQuantia = item.querySelector('.produto-quantia');

      if (!elPreco) return;

      //! se não tiver unit price salvo, transforme e salve
      if (!elPreco.dataset.unitPrice) {
        const parsed = parsePriceToNumber(elPreco.textContent || elPreco.innerText || '');
        let unit = parsed;
        if ((!unit || unit === 0) && elQuantia) {
          const q = parseInt(elQuantia.textContent || '1', 10) || 1;
          const displayed = parsePriceToNumber(elPreco.textContent || '');
          if (q > 0) unit = displayed / q;
        }
        if (!unit || !isFinite(unit)) unit = 0;
        elPreco.dataset.unitPrice = String(unit);
      }

      //! garantir que a exibição do preço corresponda ao unitPrice * quantia
      const unitPrice = parseFloat(elPreco.dataset.unitPrice);
      const qty = elQuantia ? (parseInt(elQuantia.textContent || '1', 10) || 1) : 1;
      const total = unitPrice * Math.max(1, qty);
      elPreco.textContent = formatNumberToBRL(total);
    });

  // atualizar tudo neh?
    atualizarValorCarrinho();
  }

  // Utilitário para atualizar preço de um item quando a quantidade muda
  function updateItemPriceByQuantity(item, quantity) {
    const elPreco = item.querySelector('.produto-preco');
    if (!elPreco) return;
    // se não tiver unitPrice (não inicializado) inicializa
    if (!elPreco.dataset.unitPrice) {
      // tenta inicializar a loja
      setarPrecos_Quantidades();
    }
    const unitPrice = parseFloat(elPreco.dataset.unitPrice) || 0;
    const novoTotal = unitPrice * Math.max(1, quantity);
    elPreco.textContent = formatNumberToBRL(novoTotal);

    // sempre que um preço de item muda, recalcular os totais do carrinho
    atualizarValorCarrinho();
  }

  // Configura controles de quantidade e integra com atualização de preço
  function controllerProdutos_Quantidades() {
    const itens = document.querySelectorAll('.produto-selecionado');

    itens.forEach(item => {
      const btnDiminuir = item.querySelector('.produto-diminuir');
      const btnAumentar = item.querySelector('.produto-aumentar');
      const elQuantia = item.querySelector('.produto-quantia');

      // Função utilitária para definir a quantidade (forçando número inteiro >= 1)
      function setQuantidade(n) {
        let valor = parseInt(String(n), 10);
        if (Number.isNaN(valor) || valor < 1) valor = 1;
        if (elQuantia) elQuantia.textContent = String(valor);
        // atualizar preço sempre que a quantidade muda
        updateItemPriceByQuantity(item, valor);
      }

      if (btnDiminuir) {
        btnDiminuir.addEventListener('click', (e) => {
          e.stopPropagation();
          if (!elQuantia) return;
          let atual = parseInt(elQuantia.textContent || '0', 10);
          if (Number.isNaN(atual)) atual = 1;
          const novo = Math.max(1, atual - 1); // evita ficar menor que 1
          setQuantidade(novo);
        });
      }

      if (btnAumentar) {
        btnAumentar.addEventListener('click', (e) => {
          e.stopPropagation();
          if (!elQuantia) return;
          let atual = parseInt(elQuantia.textContent || '0', 10);
          if (Number.isNaN(atual)) atual = 0;
          const novo = atual + 1;
          setQuantidade(novo);
        });
      }
    });
  }

  // Inicializa preços com base nas quantias e configura controles
  setarPrecos_Quantidades();
  controllerProdutos_Quantidades();

  // fechar ao clicar fora: se o clique NÃO estiver dentro do container e nem dentro do UL #opcoes
  document.addEventListener('click', () => {
    // quando clicar fora, apenas fechar (não limpar)
    if (selecionarPagamento.classList.contains('open')) {
      estaAberto(false);
    }
  });

  // ESC global: fecha sem limpar
  // bagulho besta inclusive.
  document.addEventListener('keydown', (tecla) => {
    if ((tecla.key === 'Escape' || tecla.key === 'Esc') && selecionarPagamento.classList.contains('open')) {
      estaAberto(false);
    }
  });
});

//Ultimo dia atualizado: 20/11 - 00:00 