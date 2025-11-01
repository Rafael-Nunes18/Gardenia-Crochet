// script.js: cria UI custom a partir do select nativo e sincroniza valor
document.addEventListener('DOMContentLoaded', () => {
  const native = document.getElementById('nativeSelect');
  const custom = document.getElementById('customSelect');
  const selected = custom.querySelector('.custom-selected');
  const optionsContainer = custom.querySelector('.custom-options');

  // lê opções do select nativo e cria itens
  const optionElems = Array.from(native.options).map(opt => {
    return {
      value: opt.value,
      text: opt.text,
      icon: opt.dataset.icon || '', // caminho do ícone se existir
      selected: opt.selected
    };
  });

  function buildOptions() {
    optionsContainer.innerHTML = '';
    optionElems.forEach((o, idx) => {
      const li = document.createElement('li');
      li.className = 'custom-option';
      li.tabIndex = 0;
      li.role = 'option';
      li.dataset.value = o.value;

      const left = document.createElement('div');
      left.className = 'option-left';

      // ícone (se existir)
      if (o.icon) {
        const img = document.createElement('img');
        img.src = o.icon; // substitua por paths válidos
        img.alt = '';
        img.className = 'option-icon';
        left.appendChild(img);
      }

      const span = document.createElement('span');
      span.className = 'option-label';
      span.textContent = o.text;
      left.appendChild(span);

      li.appendChild(left);

      // marca visual de selecionado (opcional)
      const mark = document.createElement('span');
      mark.className = 'option-mark';
      mark.textContent = o.selected ? '✓' : '';
      li.appendChild(mark);

      // clique na opção
      li.addEventListener('click', (ev) => {
        ev.stopPropagation();
        selectByIndex(idx);
        close();
      });

      // teclado
      li.addEventListener('keydown', (ev) => {
        if (ev.key === 'Enter' || ev.key === ' ') {
          ev.preventDefault();
          selectByIndex(idx);
          close();
        } else if (ev.key === 'ArrowDown') {
          ev.preventDefault();
          const next = li.nextElementSibling || optionsContainer.firstElementChild;
          next.focus();
        } else if (ev.key === 'ArrowUp') {
          ev.preventDefault();
          const prev = li.previousElementSibling || optionsContainer.lastElementChild;
          prev.focus();
        } else if (ev.key === 'Escape') {
          close();
        }
      });

      optionsContainer.appendChild(li);
    });
  }

  function open() {
    custom.setAttribute('aria-expanded','true');
    optionsContainer.setAttribute('aria-hidden','false');
    // focus no primeiro item selecionável
    const sel = optionsContainer.querySelector('.custom-option');
    if (sel) sel.focus();
  }

  function close() {
    custom.setAttribute('aria-expanded','false');
    optionsContainer.setAttribute('aria-hidden','true');
    custom.focus();
  }

  function selectByIndex(idx) {
    // atualiza modelo
    optionElems.forEach((o,i) => o.selected = (i === idx));
    // atualiza select nativo (para submissão)
    native.selectedIndex = idx;
    // atualiza UI
    renderSelected();
    buildOptions(); // para atualizar marcações
  }

  function renderSelected() {
    const sel = optionElems.find(o => o.selected) || optionElems[0];
    // atualiza texto do trigger
    selected.textContent = sel ? sel.text : '';
  }

  // eventos do trigger
  custom.addEventListener('click', (e) => {
    const opened = custom.getAttribute('aria-expanded') === 'true';
    if (opened) close(); else open();
  });

  custom.addEventListener('keydown', (e) => {
    if (e.key === 'ArrowDown' || e.key === 'Enter' || e.key === ' ') {
      e.preventDefault();
      open();
    } else if (e.key === 'Escape') {
      close();
    }
  });

  // clique fora fecha
  document.addEventListener('click', (e) => {
    if (!custom.contains(e.target)) close();
  });

  // inicializa
  buildOptions();
  renderSelected();
});