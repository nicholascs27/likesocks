function validaSePossuiAlteracoesNoForm() {
	if ($('.error_explanation').text() != '') {
		$('form').data("changed", true);
	}

	$('form').change(function () {
		$('form').data("changed", true);
	});

	$('form').submit(function (event) {
		$('form').data("changed", false);
	});

	$(window).bind('beforeunload', function (e) {
		if ($('form').data("changed")) {
			return "Há alterações no formulário. Deseja continuar?"
		}
	});
}

function select2LimparCombo(elemento) {
	$(elemento).empty();
	$(elemento).select2({
		data: [{id: '', text: 'Selecione'}]
	});
	$(elemento+' option:first-child').val('');
}

function select2SetData(elemento, data) {
	data.unshift({id: '', text: 'Selecione'});
	$(elemento).empty();
	$(elemento).select2({
		data: data
	});
	$(elemento+' option:first-child').val('');
}

function selecionar_todos(seletor) {
	$(seletor).click(function(){
		var form = this.closest(".checkboxes");
		$('input[type="checkbox"]', form).prop('checked', $(this).is(':checked'));
	});

	$('input[type="checkbox"]').click(function () {
    if ($(this).is(':checked')) {
     } else {
        $('#selecionar_todos').prop('checked', false);
    }

});
}

function select2PesquisaPorTextoNaSequencia(elemento){
	function matchStart(term, text) {
		var texto_puro = text.replace(/\./g, '');
		var termo_puro = term.replace(/\./g, '');

		if (texto_puro.indexOf(termo_puro) == 0) {
			return true;
		}

		return false;
	}

	$.fn.select2.amd.require(['select2/compat/matcher'], function (oldMatcher) {
		$(elemento).select2({
			matcher: oldMatcher(matchStart)
		})
	});
}

function desabilitar_botao_no_submit() {
	$(this).find('input[type=submit]').prop('disabled', true);
}

$(function () {
	$('.moeda').autoNumeric('init', {
		'aSep': '.',
		'aDec': ',',
		'aPad': true,
		'vMin': 0,
		'aSign': 'R$ '
	});
	$('[data-toggle="tooltip"]').tooltip();
	// adiciona automaticamente ao form
	// ou adicione manualmente ao form data-blockui-message: "Mensagem personalizada..."
	$("form").each(function() {
		if($(this).data('blockui-message')) {
			$(this).attr("onsubmit", "bloqueiaInterface('" + $(this).data('blockui-message') + "')");
		} else {
			$(this).attr("onsubmit");
		}
	});

	// adicione ao link_to data-show-blockui: true para exibir a mensagem aguarde..."
	$("a[data-show-blockui]").each(function(){
		$(this).attr("onclick", "bloqueiaInterface('Aguarde...')");
	});

	$('form').submit(desabilitar_botao_no_submit);
});

function bloqueiaInterface(mensagem) {
	if (mensagem == undefined) {
		mensagem = "Aguarde...";
	}

	$('body').css('overflow', 'hidden');
	$.blockUI({
		message:  '<h4 class="show-header"><img src="' + root_url + 'loading.gif" /><br /><br />' + mensagem + '</h4>',
		baseZ: 9999,
		css: {
			border: 'none',
			padding: '15px',
			backgroundColor: '#000', '-webkit-border-radius': '10px', '-moz-border-radius': '10px',
			opacity: .6,
			color: '#fff'
		},
		onBlock: function() {
			$(window).bind('beforeunload', function (e) {
					return "O processo ainda não foi concluído. Deseja sair mesmo assim?"
			});
		}
	});
	$(document).ajaxStop($.unblockUI);
}

function formataDinheiro(n) {
	size_decimal = Number.isInteger(n) ? 2 : (n + "").split(".").pop().length;
	size_decimal = (size_decimal < 2) ? 2 : size_decimal;
	return "R$ " + n.toFixed(size_decimal).replace('.', ',').replace(/(\d)(?=(\d{3})+\,)/g, "$1.");
}

function formataQuantidade(n) {
	return n.toFixed(2).replace('.', ',').replace(/(\d)(?=(\d{3})+\,)/g, "$1.");
}

String.prototype.extenso = function(c){
    var ex = [
        ["zero", "um", "dois", "tr?s", "quatro", "cinco", "seis", "sete", "oito", "nove", "dez", "onze", "doze", "treze", "quatorze", "quinze", "dezesseis", "dezessete", "dezoito", "dezenove"],
        ["dez", "vinte", "trinta", "quarenta", "cinq?enta", "sessenta", "setenta", "oitenta", "noventa"],
        ["cem", "cento", "duzentos", "trezentos", "quatrocentos", "quinhentos", "seiscentos", "setecentos", "oitocentos", "novecentos"],
        ["mil", "milh?o", "bilh?o", "trilh?o", "quadrilh?o", "quintilh?o", "sextilh?o", "setilh?o", "octilh?o", "nonilh?o", "decilh?o", "undecilh?o", "dodecilh?o", "tredecilh?o", "quatrodecilh?o", "quindecilh?o", "sedecilh?o", "septendecilh?o", "octencilh?o", "nonencilh?o"]
    ];
    var a, n, v, i, n = this.replace(c ? /[^,\d]/g : /\D/g, "").split(","), e = " e ", $ = "real", d = "centavo", sl;
    for(var f = n.length - 1, l, j = -1, r = [], s = [], t = ""; ++j <= f; s = []){
        j && (n[j] = (("." + n[j]) * 1).toFixed(2).slice(2));
        if(!(a = (v = n[j]).slice((l = v.length) % 3).match(/\d{3}/g), v = l % 3 ? [v.slice(0, l % 3)] : [], v = a ? v.concat(a) : v).length) continue;
        for(a = -1, l = v.length; ++a < l; t = ""){
            if(!(i = v[a] * 1)) continue;
            i % 100 < 20 && (t += ex[0][i % 100]) ||
            i % 100 + 1 && (t += ex[1][(i % 100 / 10 >> 0) - 1] + (i % 10 ? e + ex[0][i % 10] : ""));
            s.push((i < 100 ? t : !(i % 100) ? ex[2][i == 100 ? 0 : i / 100 >> 0] : (ex[2][i / 100 >> 0] + e + t)) +
            ((t = l - a - 2) > -1 ? " " + (i > 1 && t > 0 ? ex[3][t].replace("?o", "?es") : ex[3][t]) : ""));
        }
        a = ((sl = s.length) > 1 ? (a = s.pop(), s.join(" ") + e + a) : s.join("") || ((!j && (n[j + 1] * 1 > 0) || r.length) ? "" : ex[0][0]));
        a && r.push(a + (c ? (" " + (v.join("") * 1 > 1 ? j ? d + "s" : (/0{6,}$/.test(n[0]) ? "de " : "") + $.replace("l", "is") : j ? d : $)) : ""));
    }
    return r.join(e);
}
