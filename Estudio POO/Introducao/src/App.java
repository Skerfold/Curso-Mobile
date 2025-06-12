public class App {
    public static void main(String[] args) throws Exception {
        Pessoas pessoal = new Pessoas(
            nome:"Carlos",
            cpf:"123.456.789",
            contato:"19-9876-54321");
            System.out.println("Usuario Cadastrado");
            System.out.println("Nome: " +pessoal.getNome());
            System.out.println("Contato: " +pessoal.getContato());
            pessoal.setNome("Carlos da Silva");
            System.out.println(pessoal.getNome());

    }
}

