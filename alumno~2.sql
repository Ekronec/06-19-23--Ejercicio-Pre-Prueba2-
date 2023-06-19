
create or replace function fn_agencia(
    p_idagencia number
)return varchar2
as
    v_sql varchar2(400);
    v_nom varchar2(80);
begin
    begin
        v_sql := 'select NOM_AGENCIA
                  from agencia
                  where id_agencia = :1';
        EXECUTE IMMEDIATE v_sql into v_nom using p_idagencia;
    exception 
        when others then
        v_nom := 'NO TIENE AGENCIA';
    end;
    return v_nom;
end;
/








create or replace procedure sp_detalle_mensual(
    p_fecha varchar2,
    p_dolar number
)
as
    cursor c1 is
        select hu.*,
               ha.VALOR_HABITACION,
               ha.VALOR_MINIBAR
        from huesped hu join reserva re
        on hu.ID_HUESPED = re.ID_HUESPED
        join DETALLE_RESERVA dr on dr.ID_RESERVA = re.ID_RESERVA
        join habitacion ha on ha.ID_HABITACION = dr.ID_HABITACION
        where p_fecha = to_char(re.INGRESO, 'mmyyyy');
begin

    for r1 in c1 loop
    
    
    
        pl(r1.id_huesped
        ||' '||fn_agencia(r1.id_agencia)
        );
    end loop;

end sp_detalle_mensual;
/

exec sp_detalle_mensual('082021', 840);