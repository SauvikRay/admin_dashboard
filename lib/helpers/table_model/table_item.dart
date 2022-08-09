class Item {
  final String encomenda;
  final String itemo;
  final String rendimento;
  final String entrega;
  final String estado;
  final String criado;
  final String criadoacao;

  Item(
      {required this.encomenda,
      required this.itemo,
      required this.rendimento,
      required this.entrega,
      required this.estado,
      required this.criado,
      required this.criadoacao});

  static List<Item> getItem() {
    return <Item>[
      Item(
          encomenda: '#12345',
          itemo: '15,00 €',
          rendimento: '20',
          entrega: 'Lorem ipsum',
          estado: 'Lorem ipsum',
          criado: 'Lorem ipsum',
          criadoacao: 'Lorem ipsum'),
      Item(
          encomenda: '#12345',
          itemo: '15,00 €',
          rendimento: '20',
          entrega: 'Lorem ipsum',
          estado: 'Lorem ipsum',
          criado: 'Lorem ipsum',
          criadoacao: 'Lorem ipsum'),
      Item(
          encomenda: '#12345',
          itemo: '15,00 €',
          rendimento: '20',
          entrega: 'Lorem ipsum',
          estado: 'Lorem ipsum',
          criado: 'Lorem ipsum',
          criadoacao: 'Lorem ipsum'),
      Item(
          encomenda: '#12345',
          itemo: '15,00 €',
          rendimento: '20',
          entrega: 'Lorem ipsum',
          estado: 'Lorem ipsum',
          criado: 'Lorem ipsum',
          criadoacao: 'Lorem ipsum'),
      Item(
          encomenda: '#12345',
          itemo: '15,00 €',
          rendimento: '20',
          entrega: 'Lorem ipsum',
          estado: 'Lorem ipsum',
          criado: 'Lorem ipsum',
          criadoacao: 'Lorem ipsum'),
      Item(
          encomenda: '#12345',
          itemo: '15,00 €',
          rendimento: '20',
          entrega: 'Lorem ipsum',
          estado: 'Lorem ipsum',
          criado: 'Lorem ipsum',
          criadoacao: 'Lorem ipsum'),
    ];
  }
}
