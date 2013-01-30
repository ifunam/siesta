# encoding: utf-8
class LoadSeedsIntoDisabilities < ActiveRecord::Migration
  def up

    [
      ["DISCAPACIDADES SENSORIALES Y DE LA COMUNICACIÓN",
        [
          "DISCAPACIDADES PARA VER",
          "DISCAPACIDADES PARA OÍR",
          "DISCAPACIDADES PARA HABLAR (MUDEZ)",
          "DISCAPACIDADES DE LA COMUNICACIÓN Y COMPRENSIÓN DEL LENGUAJE",
          "INSUFICIENTEMENTE ESPECIFICADAS DEL GRUPO DISCAPACIDADES SENSORIALES Y DE LA COMUNICACIÓN"
        ]
      ],

      [ "DISCAPACIDADES MOTRICES",
        [
          "DISCAPACIDADES DE LAS EXTREMIDADES INFERIORES, TRONCO, CUELLO Y CABEZA",
          "DISCAPACIDADES DE LAS EXTREMIDADES SUPERIORES",
          "INSUFICIENTEMENTE ESPECIFICADAS DEL GRUPO DISCAPACIDADES MOTRICES"
        ]
      ],
      [ "DISCAPACIDADES MENTALES",
        [ 
          "DISCAPACIDADES INTELECTUALES (RETRASO MENTAL)",
          "DISCAPACIDADES CONDUCTUALES Y OTRAS MENTALES",
          "INSUFICIENTEMENTE ESPECIFICADAS DEL GRUPO DISCAPACIDADES MENTALES"
        ]
      ],
      [ "DISCAPACIDADES MÚLTIPLES Y OTRAS",
        [ 
          "DISCAPACIDADES MÚLTIPLES",
          "OTRO TIPO DE DISCAPACIDADES",
          "INSUFICIENTEMENTEESPECIFICADASDELGRUPODISCAPACIDADESMÚLTIPLESYOTRAS",
        ]
      ],
      [ "CLAVES ESPECIALES",
        [ 
          "TIPO DE DISCAPACIDAD NO ESPECIFICADA",
          "DESCRIPCIONES QUE NO CORRESPONDEN AL CONCEPTO DE DISCAPACIDAD",
          "NO SABE",
          "NO ESPECIFICADO GENERAL",
        ]
      ]
    ].each do |array|
      @disability_type = DisabilityType.new(:name => array[0])
      array[1].each do |name|
        @disability_type.disabilities.push(Disability.new(:name => name))
      end
      @disability_type.save

    end
  end

  def down
  end
end
