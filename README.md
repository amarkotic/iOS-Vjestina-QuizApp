# iOS-Vjestina-QuizApp

Ispričavam se na kašnjenju sa 4. domaćom zadaćom. Nisam htio nastaviti na 4. dz sve dok ne primjenim savjete koje sam dobio na pull requestu 3. domace zadace što mi je uz još neke privatne obaveze oduzelo dosta vremena.

4. dz
Pitanje: Prilikom kreiranja SearchViewControllera u AppRouteru i dodavanja istog u TabBarController kao sredisnji controller nailazim na problem.
Da bih iz SearchViewControllera mogao pokrenuti kviz, moram ga kreirati kao UINavigationController kako bi pushanje kviza na vrh stacka bilo moguće.
Iz nekog čudnog razloga kada to učinim, SearchViewController mi postane izrazito neresponzivan pri pokretanju na fizičkom uređaju, dok se čudno ponaša na simulatoru(ne želi pokrenuti kviz, ali je responzivan).
A čim SearchViewController predam TabControlleru kao običan UIViewController, a ne UINavigationController, on postaje responzivan na fizičkom uređaju samo što sada naravno nije moguće pokrenuti kviz jer je push nemoguć.

Nisam uspio sam ustanoviti zašto se to događa pa bih cijenio bilo kakav komentar i pomoć sa tim problemom.
