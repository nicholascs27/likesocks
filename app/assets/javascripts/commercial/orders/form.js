var listaItens = [];

$(function(){

	setTimeout(() => {
		$.each($('.quantidade'), function(index, value) {
			var linha = $(this).closest("tr");
			$('.quantidade', linha).trigger('keyup');
		});
	}, 100);

	$(document).ready(() => {

		listaItens = ($('.itens-input-hidden').data('values'));

		$(".produto").change(atualizaValorUnitario);
		$(".produto").change(atualizarTotalDoItem);
		$('.quantidade').keyup(atualizarTotalDoItem);
		

		$('form').on('cocoon:after-insert', function(e, insertedItem) {
			
			$('[data-autonumeric=true]').autoNumeric('init');
			$('.total, .valor-unitario').autoNumeric('init', {
				'aSep': '.',
				'aDec': ',',
				'aPad': 2,
				'vMin': 0,
				'aSign': 'R$ ',
				'mDec': 4
			});
			$(document).trigger('refresh_autonumeric');
			$('.valor-unitario, .total', insertedItem).text(formataDinheiro(0));
			$(".produto").change(atualizaValorUnitario);
			$(".produto").change(atualizarTotalDoItem);
			$('.quantidade').keyup(atualizarTotalDoItem);
		});
	
		$('form').on('cocoon:before-remove', function(e, removedItem) {
			$('input[data-autonumeric]', removedItem).val('0');
			$('input[type="hidden"][id$="_val"]', removedItem).val('0');
		});

	});

});

function atualizarTotalDoItem() {
	var linha = $(this).closest("tr");
	var quantidade = parseFloat($('.quantidade', linha).autoNumeric('get') || 0 );
	var valor_unitario = parseFloat($('.valor-unitario', linha).autoNumeric('get') || 0 );
	var total = quantidade * valor_unitario;
	$('.total', linha).autoNumeric('set', total);
}

function atualizaValorUnitario() {
	var linha = $(this).closest("tr");
	var valor_unitario = parseFloat(getValorUnitario($(this).val()));
	
	$('input[type="hidden"][id$="_valor_unitario"]', linha).val(valor_unitario);
	$('.valor-unitario', linha).text(formataDinheiro(valor_unitario));
}

function getValorUnitario(itemId) {
	var i = 0;
	if (itemId == 0 || listaItens[0].length == 2) {
		return 0;
	} else {
		for(i = 0; i < listaItens.length; i++) {
			if (listaItens[i][1] == itemId && listaItens[i].length == 3) {
				return listaItens[i][2]["data-valor-unitario"];
			}
		}
	}
}