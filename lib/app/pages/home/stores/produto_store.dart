import 'package:ProjetoConsumirApi/app/data/http/exceptions.dart';
import 'package:ProjetoConsumirApi/app/data/models/produto_model.dart';
import 'package:aul'
import 'package:ProjetoConsumirApi/app/data/repositories/produto_repository.dart';
import 'package:flutter/material.dart';

class ProdutoStore {
  final IProdutoReposity repository;

  // Variável reativa para o loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // Variável reativa para o state
  final ValueNotifier<List<ProdutoModel>> state =
      ValueNotifier<List<ProdutoModel>>([]);

  // Variável reativa para o erro
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  ProdutoStore({required this.repository});

  Future getProdutos() async {
    isLoading.value = true;

    try {
      final result = await repository.getProdutos();
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }
}
