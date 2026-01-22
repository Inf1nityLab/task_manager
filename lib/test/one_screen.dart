import 'package:flutter/material.dart';

class OneScreen extends StatelessWidget {
  const OneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondScreen(person: people[index]),
                ),
              );
            },
            leading: CircleAvatar(child: Text('$index')),
            title: Text('${people[index].name} ${people[index].surname}'),
            subtitle: Text('${people[index].age}'),
            trailing: people[index].isMarried
                ? Icon(Icons.female)
                : Icon(Icons.male),
          );
        },
      ),
    );
  }
}

final List<Person> people = [
  Person(name: 'Алексей', age: 28, isMarried: false, surname: 'Смирнов'), // 0
  Person(name: 'Елена', age: 34, isMarried: true, surname: 'Соколова'), // 1
  Person(name: 'Дмитрий', age: 45, isMarried: true, surname: 'Козлов'), // 2
  Person(name: 'Ольга', age: 22, isMarried: false, surname: 'Морозова'), // 3
  Person(name: 'Сергей', age: 31, isMarried: true, surname: 'Волков'), // 4
  Person(name: 'Анна', age: 27, isMarried: false, surname: 'Лебедева'), // 5
  Person(name: 'Максим', age: 19, isMarried: false, surname: 'Новиков'), // 6
  Person(name: 'Виктория', age: 52, isMarried: true, surname: 'Попова'), // 7
];

class SecondScreen extends StatefulWidget {
  final Person person;

  const SecondScreen({super.key, required this.person});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  late TextEditingController nameController ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    nameController = TextEditingController(
      text: widget.person.name
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SecondScreen')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 20,
          children: [
            Text(widget.person.name),
            Text('${widget.person.age}'),
            widget.person.isMarried ? Text('Замужем') : Text('Не замужем'),
            Text(widget.person.surname),

            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),

              ),
            )
          ],
        ),
      ),
    );
  }
}

class Person {
  final String name;
  final int age;
  final bool isMarried;
  final String surname;

  Person({
    required this.name,
    required this.age,
    required this.isMarried,
    required this.surname,
  });
}
