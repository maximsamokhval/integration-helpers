﻿
#Область ОбработчикиСобытийФормы


#КонецОбласти


#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВыбратьОбъект(Команда)
	
	ОткрытьФорму("Обработка.МаппингДанных.Форма.ВыборОбъектаМетаданных",,ЭтотОбъект,,,,
						Новый ОписаниеОповещения("ПослеВыбораОбъектаМетаданных",ЭтотОбъект),
						РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
						
КонецПроцедуры

&НаКлиенте
Процедура ПослеВыбораОбъектаМетаданных(РезультатЗакрытия,ДополнительныеПараметры) Экспорт 
	
	Если РезультатЗакрытия = Неопределено Тогда
		ОбъектКонфигурации = РезультатЗакрытия;
		РезультатВыбора = РезультатЗакрытия;
		Возврат;
	КонецЕсли;
	
	РезультатВыбора = РезультатЗакрытия;
	ОбъектКонфигурации = РезультатЗакрытия.Синоним;	
	
	заполнитьРеквизитыОбъекта();
	
	
КонецПроцедуры


#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура заполнитьРеквизитыОбъекта()
	
	ОбъектМетаданные = Метаданные.НайтиПоПолномуИмени(РезультатВыбора.Имя);
	РеквизитыОбъекта.Очистить();
	
	Если этоСсылочныйТип(РезультатВыбора.Тип) Тогда
		
		заполнитьРеквизитыОбъектаМетаданных(ОбъектМетаданные);
		
	Иначе
		
		заполнитьИзмеренияРесурсыОбъектаМетаданных(ОбъектМетаданные);
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура заполнитьИзмеренияРесурсыОбъектаМетаданных(ОбъектМетаданные)
	
	Измерения 	= ОбъектМетаданные.Измерения;
	Ресурсы		= ОбъектМетаданные.Ресурсы;
	Реквизиты	= ОбъектМетаданные.Реквизиты;
	
	Для каждого Измерение Из Измерения Цикл		
		НоваяЗапись = РеквизитыОбъекта.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяЗапись,Измерение);		
	КонецЦикла;
	
	Для каждого Ресурс Из Ресурсы Цикл
		НоваяЗапись = РеквизитыОбъекта.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяЗапись,Ресурс);	
	КонецЦикла;
	
	Для каждого Реквизит Из Реквизиты Цикл
		НоваяЗапись = РеквизитыОбъекта.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяЗапись,Реквизит);	
	КонецЦикла; 
	
КонецПроцедуры


&НаСервере
Процедура заполнитьРеквизитыОбъектаМетаданных(ОбъектМетаданные)
	
	Реквизиты = ОбъектМетаданные.Реквизиты;
	Для каждого РеквизитМетаданных Из Реквизиты Цикл		
		НоваяЗапись = РеквизитыОбъекта.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяЗапись,РеквизитМетаданных);		
	КонецЦикла; 
	
КонецПроцедуры


&НаСервереБезКонтекста
Функция этоСсылочныйТип(ТипМетаданныхСтрокой)
	
	Возврат ТипМетаданныхСтрокой = "Справочники"
			Или ТипМетаданныхСтрокой = "Документы";
	
КонецФункции
 

#КонецОбласти