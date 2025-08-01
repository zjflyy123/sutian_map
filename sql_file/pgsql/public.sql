--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2 (Debian 11.2-1.pgdg90+1)
-- Dumped by pg_dump version 17.0

-- Started on 2025-07-30 12:00:41

--
-- TOC entry 8 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3 (class 3079 OID 16384)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 4525 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- TOC entry 2 (class 3079 OID 17962)
-- Name: postgis_sfcgal; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_sfcgal WITH SCHEMA public;


--
-- TOC entry 4526 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION postgis_sfcgal; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_sfcgal IS 'PostGIS SFCGAL functions';


--
-- TOC entry 1480 (class 1255 OID 17982)
-- Name: deletedatabytaskid(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.deletedatabytaskid(taskid integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    
delete from boundary where task_id=taskId;
delete from lane where task_id=taskId;
delete from lane_ref where task_id=taskId;
delete from connectivity_area where task_id=taskId;
delete from connectivity_area_ref where task_id=taskId;
delete from lane_group where task_id=taskId;
delete from lane_group_ref where task_id=taskId;
delete from obstacle where task_id=taskId;
delete from pole where task_id=taskId;
delete from road_mark where task_id=taskId;
delete from road_mark_ref where task_id=taskId;

DELETE from stop_line where task_id=taskId;
DELETE from traffic_sign where task_id=taskId;

DELETE from traffic_light where task_id=taskId;
DELETE from traffic_light_group where task_id=taskId;

RETURN taskId;
END;
$$;


ALTER FUNCTION public.deletedatabytaskid(taskid integer) OWNER TO postgres;

SET default_tablespace = '';

--
-- TOC entry 214 (class 1259 OID 17983)
-- Name: assignment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.assignment (
    id character varying(20) NOT NULL,
    code smallint,
    point_rating smallint,
    remark character varying(255),
    create_time timestamp(6) without time zone,
    update_time timestamp(6) without time zone
);


ALTER TABLE public.assignment OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 17986)
-- Name: boundary; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.boundary (
    boundary_id character varying(64) NOT NULL,
    task_id integer,
    geom public.geometry(GeometryZ),
    create_time timestamp(6) without time zone,
    update_time timestamp(6) without time zone,
    status smallint DEFAULT 0,
    line_type character varying(50),
    color character varying(50),
    isolation character varying(50),
    zlevel character varying(255) DEFAULT 0,
    lane_type character varying(255),
    object_type character varying(255),
    boundary_type character varying(50) DEFAULT 0,
    data_source smallint DEFAULT 0
);


ALTER TABLE public.boundary OWNER TO postgres;

--
-- TOC entry 4527 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE boundary; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.boundary IS '车道线';


--
-- TOC entry 4528 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN boundary.boundary_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.boundary.boundary_id IS '主键id';


--
-- TOC entry 4529 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN boundary.task_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.boundary.task_id IS '任务编号';


--
-- TOC entry 4530 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN boundary.geom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.boundary.geom IS '地理信息';


--
-- TOC entry 4531 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN boundary.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.boundary.create_time IS '创建时间';


--
-- TOC entry 4532 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN boundary.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.boundary.update_time IS '修改时间';


--
-- TOC entry 4533 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN boundary.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.boundary.status IS '删除状态';


--
-- TOC entry 4534 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN boundary.line_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.boundary.line_type IS '车道线、路沿类型';


--
-- TOC entry 4535 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN boundary.color; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.boundary.color IS '车道线、路沿线段颜色';


--
-- TOC entry 4536 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN boundary.isolation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.boundary.isolation IS '物理隔离类型';


--
-- TOC entry 4537 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN boundary.zlevel; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.boundary.zlevel IS '存储对应的z分层信息';


--
-- TOC entry 4538 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN boundary.lane_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.boundary.lane_type IS '标线左侧-车道类型';


--
-- TOC entry 4539 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN boundary.object_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.boundary.object_type IS ' 标线左侧-通行车辆类型';


--
-- TOC entry 4540 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN boundary.boundary_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.boundary.boundary_type IS 'boundary类型（0车道边界，1道路边界、2车道边界&道路边界）';


--
-- TOC entry 4541 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN boundary.data_source; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.boundary.data_source IS '数据来源0 表示工具绘制，1表示算法生成，2表示数据导入';


--
-- TOC entry 216 (class 1259 OID 17996)
-- Name: connectivity_area; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.connectivity_area (
    connectivity_area_id character varying(64) NOT NULL,
    task_id integer,
    geom public.geometry(GeometryZ),
    create_time timestamp(6) without time zone,
    update_time timestamp(6) without time zone,
    status smallint DEFAULT 0,
    type character varying(50),
    zlevel character varying(255) DEFAULT 0,
    data_source smallint
);


ALTER TABLE public.connectivity_area OWNER TO postgres;

--
-- TOC entry 4542 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE connectivity_area; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.connectivity_area IS '路口、交换区';


--
-- TOC entry 4543 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN connectivity_area.connectivity_area_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.connectivity_area.connectivity_area_id IS '主键id';


--
-- TOC entry 4544 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN connectivity_area.task_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.connectivity_area.task_id IS '任务编号';


--
-- TOC entry 4545 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN connectivity_area.geom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.connectivity_area.geom IS '地理信息';


--
-- TOC entry 4546 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN connectivity_area.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.connectivity_area.create_time IS '创建时间';


--
-- TOC entry 4547 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN connectivity_area.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.connectivity_area.update_time IS '修改时间';


--
-- TOC entry 4548 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN connectivity_area.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.connectivity_area.status IS '删除状态';


--
-- TOC entry 4549 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN connectivity_area.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.connectivity_area.type IS '路口，车道变化（两车道变三车道）区，收费站';


--
-- TOC entry 4550 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN connectivity_area.zlevel; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.connectivity_area.zlevel IS '存储对应的z分层信息';


--
-- TOC entry 4551 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN connectivity_area.data_source; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.connectivity_area.data_source IS '数据来源0 表示工具绘制，1表示算法生成，2表示数据导入';


--
-- TOC entry 217 (class 1259 OID 18004)
-- Name: connectivity_area_ref; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.connectivity_area_ref (
    connectivity_area_ref_id character varying(64) NOT NULL,
    feature_id character varying(64),
    type character varying(255),
    create_time timestamp(6) without time zone,
    update_time timestamp(6) without time zone,
    connectivity_area_id character varying(64),
    status smallint DEFAULT 0,
    data_source smallint DEFAULT 0,
    task_id integer
);


ALTER TABLE public.connectivity_area_ref OWNER TO postgres;

--
-- TOC entry 4552 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE connectivity_area_ref; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.connectivity_area_ref IS '道路连接区域关联';


--
-- TOC entry 4553 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN connectivity_area_ref.connectivity_area_ref_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.connectivity_area_ref.connectivity_area_ref_id IS '主键id';


--
-- TOC entry 4554 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN connectivity_area_ref.feature_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.connectivity_area_ref.feature_id IS '关联的要素id';


--
-- TOC entry 4555 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN connectivity_area_ref.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.connectivity_area_ref.type IS '关联的要素类型';


--
-- TOC entry 4556 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN connectivity_area_ref.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.connectivity_area_ref.create_time IS '创建时间';


--
-- TOC entry 4557 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN connectivity_area_ref.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.connectivity_area_ref.update_time IS '修改时间';


--
-- TOC entry 4558 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN connectivity_area_ref.connectivity_area_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.connectivity_area_ref.connectivity_area_id IS '关联connectivity_area的主键id';


--
-- TOC entry 4559 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN connectivity_area_ref.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.connectivity_area_ref.status IS '删除状态';


--
-- TOC entry 4560 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN connectivity_area_ref.data_source; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.connectivity_area_ref.data_source IS '数据来源0 表示工具绘制，1表示算法生成，2表示数据导入';


--
-- TOC entry 4561 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN connectivity_area_ref.task_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.connectivity_area_ref.task_id IS '主键id';


--
-- TOC entry 218 (class 1259 OID 18009)
-- Name: feature_flag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.feature_flag (
    feature_flag_id character varying(64) NOT NULL,
    task_id integer,
    geom public.geometry(Geometry,4326),
    create_time timestamp(6) without time zone,
    update_time timestamp(6) without time zone,
    describe character varying(255)
);


ALTER TABLE public.feature_flag OWNER TO postgres;

--
-- TOC entry 4562 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE feature_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.feature_flag IS '标记表';


--
-- TOC entry 4563 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN feature_flag.feature_flag_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.feature_flag.feature_flag_id IS '主键id';


--
-- TOC entry 4564 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN feature_flag.task_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.feature_flag.task_id IS '任务编号';


--
-- TOC entry 4565 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN feature_flag.geom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.feature_flag.geom IS '地理信息,几何点，方便定位到对应位置';


--
-- TOC entry 4566 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN feature_flag.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.feature_flag.create_time IS '创建时间';


--
-- TOC entry 4567 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN feature_flag.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.feature_flag.update_time IS '修改时间';


--
-- TOC entry 4568 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN feature_flag.describe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.feature_flag.describe IS '描述';


--
-- TOC entry 219 (class 1259 OID 18015)
-- Name: feature_operate_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.feature_operate_info (
    id character varying(20) NOT NULL,
    feature_id character varying(64),
    action character varying(50),
    data text,
    create_time timestamp(6) without time zone,
    type character varying(50)
);


ALTER TABLE public.feature_operate_info OWNER TO postgres;

--
-- TOC entry 4569 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE feature_operate_info; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.feature_operate_info IS '操作日志表';


--
-- TOC entry 4570 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN feature_operate_info.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.feature_operate_info.id IS '主键id';


--
-- TOC entry 4571 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN feature_operate_info.feature_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.feature_operate_info.feature_id IS '要素id';


--
-- TOC entry 4572 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN feature_operate_info.action; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.feature_operate_info.action IS '动作（添加、修改、删除）';


--
-- TOC entry 4573 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN feature_operate_info.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.feature_operate_info.data IS '操作的数据';


--
-- TOC entry 4574 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN feature_operate_info.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.feature_operate_info.create_time IS '操作时间';


--
-- TOC entry 4575 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN feature_operate_info.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.feature_operate_info.type IS '要素类型';


--
-- TOC entry 220 (class 1259 OID 18021)
-- Name: lane; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lane (
    lane_id character varying(64) NOT NULL,
    task_id integer,
    geom public.geometry(GeometryZ),
    create_time timestamp(6) without time zone,
    update_time timestamp(6) without time zone,
    lane_type character varying(50),
    object_type character varying(255),
    height numeric DEFAULT 0,
    type character varying(50),
    status smallint DEFAULT 0 NOT NULL,
    zlevel character varying(255),
    left_boundary_id character varying(64),
    right_boundary_id character varying(64),
    order_num integer,
    data_source smallint DEFAULT 0
);


ALTER TABLE public.lane OWNER TO postgres;

--
-- TOC entry 4576 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE lane; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.lane IS '车道中心线';


--
-- TOC entry 4577 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN lane.lane_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane.lane_id IS '主键id';


--
-- TOC entry 4578 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN lane.task_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane.task_id IS '任务编号';


--
-- TOC entry 4579 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN lane.geom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane.geom IS '地理信息';


--
-- TOC entry 4580 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN lane.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane.create_time IS '创建时间';


--
-- TOC entry 4581 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN lane.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane.update_time IS '修改时间';


--
-- TOC entry 4582 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN lane.lane_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane.lane_type IS '车道类型';


--
-- TOC entry 4583 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN lane.object_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane.object_type IS '车道运行行驶对象（多个值用，隔开）';


--
-- TOC entry 4584 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN lane.height; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane.height IS '该车道高（基于主车道高度差）';


--
-- TOC entry 4585 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN lane.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane.type IS '由boundary算出来的中心线："generate"，标注的路口中心线:"mark"';


--
-- TOC entry 4586 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN lane.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane.status IS '删除状态';


--
-- TOC entry 4587 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN lane.zlevel; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane.zlevel IS '存储对应的z分层信息';


--
-- TOC entry 4588 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN lane.left_boundary_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane.left_boundary_id IS '左边boundary_id（左边边线）';


--
-- TOC entry 4589 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN lane.right_boundary_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane.right_boundary_id IS '右边boundary_id（右边边线）';


--
-- TOC entry 4590 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN lane.order_num; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane.order_num IS '线的顺序';


--
-- TOC entry 4591 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN lane.data_source; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane.data_source IS '数据来源0 表示工具绘制，1表示算法生成，2表示数据导入';


--
-- TOC entry 221 (class 1259 OID 18032)
-- Name: lane_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lane_group (
    lane_group_id character varying(64) NOT NULL,
    task_id integer,
    geom public.geometry(GeometryZ),
    create_time timestamp(6) without time zone,
    update_time timestamp(6) without time zone,
    status smallint DEFAULT 0,
    zlevel character varying(16),
    situation_type character varying(255),
    data_source smallint DEFAULT 0
);


ALTER TABLE public.lane_group OWNER TO postgres;

--
-- TOC entry 4592 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE lane_group; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.lane_group IS '车道组表';


--
-- TOC entry 4593 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN lane_group.lane_group_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane_group.lane_group_id IS '主键id';


--
-- TOC entry 4594 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN lane_group.task_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane_group.task_id IS '任务编号';


--
-- TOC entry 4595 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN lane_group.geom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane_group.geom IS '地理信息';


--
-- TOC entry 4596 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN lane_group.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane_group.create_time IS '创建时间';


--
-- TOC entry 4597 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN lane_group.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane_group.update_time IS '修改时间';


--
-- TOC entry 4598 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN lane_group.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane_group.status IS '删除状态';


--
-- TOC entry 4599 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN lane_group.situation_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane_group.situation_type IS '道路类型';


--
-- TOC entry 4600 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN lane_group.data_source; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane_group.data_source IS '数据来源0 表示工具绘制，1表示算法生成，2表示数据导入';


--
-- TOC entry 222 (class 1259 OID 18040)
-- Name: lane_group_ref; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lane_group_ref (
    lane_group_ref_id character varying(64) NOT NULL,
    feature_id character varying(64),
    type character varying(50),
    create_time timestamp(6) without time zone,
    update_time timestamp(6) without time zone,
    lane_group_id character varying(64),
    status smallint DEFAULT 0 NOT NULL,
    data_source smallint DEFAULT 0,
    task_id integer
);


ALTER TABLE public.lane_group_ref OWNER TO postgres;

--
-- TOC entry 4601 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE lane_group_ref; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.lane_group_ref IS '车道组的关联关系表';


--
-- TOC entry 4602 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN lane_group_ref.lane_group_ref_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane_group_ref.lane_group_ref_id IS '主键id';


--
-- TOC entry 4603 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN lane_group_ref.feature_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane_group_ref.feature_id IS '要素id';


--
-- TOC entry 4604 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN lane_group_ref.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane_group_ref.type IS '关联类型（比如：1001,1002）';


--
-- TOC entry 4605 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN lane_group_ref.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane_group_ref.create_time IS '创建时间';


--
-- TOC entry 4606 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN lane_group_ref.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane_group_ref.update_time IS '修改时间';


--
-- TOC entry 4607 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN lane_group_ref.lane_group_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane_group_ref.lane_group_id IS '车道组的主键id';


--
-- TOC entry 4608 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN lane_group_ref.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane_group_ref.status IS '删除状态';


--
-- TOC entry 4609 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN lane_group_ref.data_source; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane_group_ref.data_source IS '数据来源0 表示工具绘制，1表示算法生成，2表示数据导入';


--
-- TOC entry 4610 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN lane_group_ref.task_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane_group_ref.task_id IS '任务id';


--
-- TOC entry 223 (class 1259 OID 18045)
-- Name: lane_ref; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lane_ref (
    lane_ref_id character varying(64) NOT NULL,
    feature_id character varying(64),
    type character varying(50),
    create_time timestamp(6) without time zone,
    update_time timestamp(6) without time zone,
    lane_id character varying(64),
    status smallint DEFAULT 0 NOT NULL,
    sequence character varying(255),
    data_source smallint DEFAULT 0,
    task_id integer
);


ALTER TABLE public.lane_ref OWNER TO postgres;

--
-- TOC entry 4611 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE lane_ref; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.lane_ref IS 'lane的关联关系表';


--
-- TOC entry 4612 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN lane_ref.lane_ref_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane_ref.lane_ref_id IS '主键id';


--
-- TOC entry 4613 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN lane_ref.feature_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane_ref.feature_id IS '要素id';


--
-- TOC entry 4614 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN lane_ref.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane_ref.type IS '关联类型（1001,1002）';


--
-- TOC entry 4615 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN lane_ref.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane_ref.create_time IS '创建时间';


--
-- TOC entry 4616 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN lane_ref.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane_ref.update_time IS '修改时间';


--
-- TOC entry 4617 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN lane_ref.lane_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane_ref.lane_id IS 'lane的主键id';


--
-- TOC entry 4618 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN lane_ref.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane_ref.status IS '删除状态';


--
-- TOC entry 4619 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN lane_ref.sequence; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane_ref.sequence IS '前后顺序（before当前线的前一根线、或者是after后一根线）';


--
-- TOC entry 4620 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN lane_ref.data_source; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane_ref.data_source IS '数据来源0 表示工具绘制，1表示算法生成，2表示数据导入';


--
-- TOC entry 4621 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN lane_ref.task_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.lane_ref.task_id IS '任务id';


--
-- TOC entry 224 (class 1259 OID 18053)
-- Name: obstacle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.obstacle (
    obstacle_id character varying(64) NOT NULL,
    task_id integer,
    geom public.geometry(GeometryZ),
    create_time timestamp(6) without time zone,
    update_time timestamp(6) without time zone,
    status smallint DEFAULT 0,
    type character varying(50),
    zlevel character varying(255) DEFAULT 0,
    data_source smallint DEFAULT 0
);


ALTER TABLE public.obstacle OWNER TO postgres;

--
-- TOC entry 4622 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE obstacle; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.obstacle IS '障碍物';


--
-- TOC entry 4623 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN obstacle.obstacle_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.obstacle.obstacle_id IS '主键id';


--
-- TOC entry 4624 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN obstacle.task_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.obstacle.task_id IS '任务编号';


--
-- TOC entry 4625 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN obstacle.geom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.obstacle.geom IS '地理信息';


--
-- TOC entry 4626 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN obstacle.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.obstacle.create_time IS '创建时间';


--
-- TOC entry 4627 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN obstacle.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.obstacle.update_time IS '修改时间';


--
-- TOC entry 4628 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN obstacle.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.obstacle.status IS '删除状态';


--
-- TOC entry 4629 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN obstacle.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.obstacle.type IS '类型（地⾯式交通灯、交警站⽴亭、安全岛）';


--
-- TOC entry 4630 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN obstacle.zlevel; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.obstacle.zlevel IS '存储对应的z分层信息';


--
-- TOC entry 4631 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN obstacle.data_source; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.obstacle.data_source IS '数据来源0 表示工具绘制，1表示算法生成，2表示数据导入';


--
-- TOC entry 225 (class 1259 OID 18062)
-- Name: point; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.point (
    id bigint NOT NULL,
    task_id integer,
    geom public.geometry(GeometryZ),
    create_time timestamp(6) without time zone,
    update_time timestamp(6) without time zone
);


ALTER TABLE public.point OWNER TO postgres;

--
-- TOC entry 4632 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN point.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.point.id IS '主键id';


--
-- TOC entry 4633 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN point.task_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.point.task_id IS '任务编号';


--
-- TOC entry 4634 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN point.geom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.point.geom IS '地理信息';


--
-- TOC entry 4635 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN point.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.point.create_time IS '创建时间';


--
-- TOC entry 4636 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN point.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.point.update_time IS '修改时间';


--
-- TOC entry 226 (class 1259 OID 18068)
-- Name: pole; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pole (
    pole_id character varying(64) NOT NULL,
    task_id integer,
    geom public.geometry(GeometryZ),
    create_time timestamp(6) without time zone,
    update_time timestamp(6) without time zone,
    status smallint DEFAULT 0,
    type character varying(50),
    zlevel character varying(255) DEFAULT 0,
    data_source smallint DEFAULT 0
);


ALTER TABLE public.pole OWNER TO postgres;

--
-- TOC entry 4637 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE pole; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.pole IS '杆';


--
-- TOC entry 4638 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN pole.pole_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.pole.pole_id IS '主键id';


--
-- TOC entry 4639 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN pole.task_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.pole.task_id IS '任务编号';


--
-- TOC entry 4640 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN pole.geom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.pole.geom IS '地理信息';


--
-- TOC entry 4641 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN pole.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.pole.create_time IS '创建时间';


--
-- TOC entry 4642 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN pole.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.pole.update_time IS '修改时间';


--
-- TOC entry 4643 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN pole.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.pole.status IS '删除状态';


--
-- TOC entry 4644 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN pole.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.pole.type IS '类型（灯杆、龙门架、L型杆、T型杆）';


--
-- TOC entry 4645 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN pole.zlevel; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.pole.zlevel IS '存储对应的z分层信息';


--
-- TOC entry 4646 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN pole.data_source; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.pole.data_source IS '数据来源0 表示工具绘制，1表示算法生成，2表示数据导入';


--
-- TOC entry 227 (class 1259 OID 18077)
-- Name: road_mark; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.road_mark (
    road_mark_id character varying(64) NOT NULL,
    task_id integer,
    geom public.geometry(GeometryZ),
    create_time timestamp(6) without time zone,
    update_time timestamp(6) without time zone,
    status smallint DEFAULT 0,
    content character varying(255),
    type character varying(50),
    zlevel character varying(255),
    data_source smallint DEFAULT 0
);


ALTER TABLE public.road_mark OWNER TO postgres;

--
-- TOC entry 4647 (class 0 OID 0)
-- Dependencies: 227
-- Name: TABLE road_mark; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.road_mark IS '路面标识：（地面标识、人行横道、等）';


--
-- TOC entry 4648 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN road_mark.road_mark_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.road_mark.road_mark_id IS '主键id';


--
-- TOC entry 4649 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN road_mark.task_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.road_mark.task_id IS '任务编号';


--
-- TOC entry 4650 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN road_mark.geom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.road_mark.geom IS '地理信息';


--
-- TOC entry 4651 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN road_mark.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.road_mark.create_time IS '创建时间';


--
-- TOC entry 4652 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN road_mark.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.road_mark.update_time IS '修改时间';


--
-- TOC entry 4653 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN road_mark.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.road_mark.status IS '删除状态';


--
-- TOC entry 4654 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN road_mark.content; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.road_mark.content IS '内容，根据类型内容不同';


--
-- TOC entry 4655 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN road_mark.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.road_mark.type IS '地面标识类型：转向箭头、减速标识等等';


--
-- TOC entry 4656 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN road_mark.zlevel; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.road_mark.zlevel IS '存储对应的z分层信息';


--
-- TOC entry 4657 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN road_mark.data_source; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.road_mark.data_source IS '数据来源0 表示工具绘制，1表示算法生成，2表示数据导入';


--
-- TOC entry 228 (class 1259 OID 18085)
-- Name: road_mark_ref; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.road_mark_ref (
    road_mark_ref_id character varying(64) NOT NULL,
    feature_id character varying(64),
    type character varying(255),
    create_time timestamp(6) without time zone,
    update_time timestamp(6) without time zone,
    road_mark_id character varying(64),
    status smallint DEFAULT 0 NOT NULL,
    data_source smallint DEFAULT 0,
    task_id integer
);


ALTER TABLE public.road_mark_ref OWNER TO postgres;

--
-- TOC entry 4658 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE road_mark_ref; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.road_mark_ref IS '地面关联关系表';


--
-- TOC entry 4659 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN road_mark_ref.road_mark_ref_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.road_mark_ref.road_mark_ref_id IS '主键id';


--
-- TOC entry 4660 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN road_mark_ref.feature_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.road_mark_ref.feature_id IS '关联的要素id';


--
-- TOC entry 4661 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN road_mark_ref.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.road_mark_ref.type IS '关联的要素类型';


--
-- TOC entry 4662 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN road_mark_ref.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.road_mark_ref.create_time IS '创建时间';


--
-- TOC entry 4663 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN road_mark_ref.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.road_mark_ref.update_time IS '修改时间';


--
-- TOC entry 4664 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN road_mark_ref.road_mark_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.road_mark_ref.road_mark_id IS 'roadMark要素id';


--
-- TOC entry 4665 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN road_mark_ref.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.road_mark_ref.status IS '删除状态';


--
-- TOC entry 4666 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN road_mark_ref.data_source; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.road_mark_ref.data_source IS '数据来源0 表示工具绘制，1表示算法生成，2表示数据导入';


--
-- TOC entry 4667 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN road_mark_ref.task_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.road_mark_ref.task_id IS '任务id';


--
-- TOC entry 229 (class 1259 OID 18090)
-- Name: stop_line; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stop_line (
    stop_line_id character varying(64) NOT NULL,
    task_id integer,
    geom public.geometry(GeometryZ),
    create_time timestamp(6) without time zone,
    update_time timestamp(6) without time zone,
    status smallint DEFAULT 0,
    line_type character varying(50),
    zlevel character varying(255),
    data_source smallint DEFAULT 0
);


ALTER TABLE public.stop_line OWNER TO postgres;

--
-- TOC entry 4668 (class 0 OID 0)
-- Dependencies: 229
-- Name: TABLE stop_line; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.stop_line IS '停止线';


--
-- TOC entry 4669 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN stop_line.stop_line_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.stop_line.stop_line_id IS '主键id';


--
-- TOC entry 4670 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN stop_line.task_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.stop_line.task_id IS '任务编号';


--
-- TOC entry 4671 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN stop_line.geom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.stop_line.geom IS '地理信息';


--
-- TOC entry 4672 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN stop_line.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.stop_line.create_time IS '创建时间';


--
-- TOC entry 4673 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN stop_line.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.stop_line.update_time IS '修改时间';


--
-- TOC entry 4674 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN stop_line.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.stop_line.status IS '删除状态';


--
-- TOC entry 4675 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN stop_line.line_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.stop_line.line_type IS '停止线类型';


--
-- TOC entry 4676 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN stop_line.zlevel; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.stop_line.zlevel IS '存储对应的z分层信息';


--
-- TOC entry 4677 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN stop_line.data_source; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.stop_line.data_source IS '数据来源0 表示工具绘制，1表示算法生成，2表示数据导入';


--
-- TOC entry 230 (class 1259 OID 18098)
-- Name: traffic_light; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.traffic_light (
    traffic_light_id character varying(64) NOT NULL,
    task_id integer,
    geom public.geometry(GeometryZ),
    create_time timestamp(6) without time zone,
    update_time timestamp(6) without time zone,
    status smallint DEFAULT 0,
    content character varying(255),
    zlevel character varying(255),
    data_source smallint DEFAULT 0
);


ALTER TABLE public.traffic_light OWNER TO postgres;

--
-- TOC entry 4678 (class 0 OID 0)
-- Dependencies: 230
-- Name: TABLE traffic_light; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.traffic_light IS '交通灯';


--
-- TOC entry 4679 (class 0 OID 0)
-- Dependencies: 230
-- Name: COLUMN traffic_light.traffic_light_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.traffic_light.traffic_light_id IS '主键id';


--
-- TOC entry 4680 (class 0 OID 0)
-- Dependencies: 230
-- Name: COLUMN traffic_light.task_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.traffic_light.task_id IS '任务编号';


--
-- TOC entry 4681 (class 0 OID 0)
-- Dependencies: 230
-- Name: COLUMN traffic_light.geom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.traffic_light.geom IS '地理信息';


--
-- TOC entry 4682 (class 0 OID 0)
-- Dependencies: 230
-- Name: COLUMN traffic_light.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.traffic_light.create_time IS '创建时间';


--
-- TOC entry 4683 (class 0 OID 0)
-- Dependencies: 230
-- Name: COLUMN traffic_light.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.traffic_light.update_time IS '修改时间';


--
-- TOC entry 4684 (class 0 OID 0)
-- Dependencies: 230
-- Name: COLUMN traffic_light.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.traffic_light.status IS '删除状态';


--
-- TOC entry 4685 (class 0 OID 0)
-- Dependencies: 230
-- Name: COLUMN traffic_light.content; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.traffic_light.content IS '内容（左转灯、右转灯、直行灯、掉头灯、非机动车道灯）';


--
-- TOC entry 4686 (class 0 OID 0)
-- Dependencies: 230
-- Name: COLUMN traffic_light.zlevel; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.traffic_light.zlevel IS '存储对应的z分层信息';


--
-- TOC entry 4687 (class 0 OID 0)
-- Dependencies: 230
-- Name: COLUMN traffic_light.data_source; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.traffic_light.data_source IS '数据来源0 表示工具绘制，1表示算法生成，2表示数据导入';


--
-- TOC entry 231 (class 1259 OID 18106)
-- Name: traffic_light_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.traffic_light_group (
    traffic_light_group_id character varying(64) NOT NULL,
    task_id integer,
    geom public.geometry(Geometry,4326),
    create_time timestamp(6) without time zone,
    update_time timestamp(6) without time zone,
    name character varying(255),
    describe character varying(255),
    traffic_light_ids character varying(255),
    data_source smallint DEFAULT 0
);


ALTER TABLE public.traffic_light_group OWNER TO postgres;

--
-- TOC entry 4688 (class 0 OID 0)
-- Dependencies: 231
-- Name: TABLE traffic_light_group; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.traffic_light_group IS '交通灯组表';


--
-- TOC entry 4689 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN traffic_light_group.traffic_light_group_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.traffic_light_group.traffic_light_group_id IS '主键id';


--
-- TOC entry 4690 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN traffic_light_group.task_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.traffic_light_group.task_id IS '任务编号';


--
-- TOC entry 4691 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN traffic_light_group.geom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.traffic_light_group.geom IS '地理信息,几何点，方便定位到对应位置';


--
-- TOC entry 4692 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN traffic_light_group.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.traffic_light_group.create_time IS '创建时间';


--
-- TOC entry 4693 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN traffic_light_group.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.traffic_light_group.update_time IS '修改时间';


--
-- TOC entry 4694 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN traffic_light_group.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.traffic_light_group.name IS '灯组名称';


--
-- TOC entry 4695 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN traffic_light_group.describe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.traffic_light_group.describe IS '描述';


--
-- TOC entry 4696 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN traffic_light_group.traffic_light_ids; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.traffic_light_group.traffic_light_ids IS '灯组（灯ids）';


--
-- TOC entry 4697 (class 0 OID 0)
-- Dependencies: 231
-- Name: COLUMN traffic_light_group.data_source; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.traffic_light_group.data_source IS '数据来源0 表示工具绘制，1表示算法生成，2表示数据导入';


--
-- TOC entry 232 (class 1259 OID 18113)
-- Name: traffic_sign; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.traffic_sign (
    traffic_sign_id character varying(64) NOT NULL,
    task_id integer,
    geom public.geometry(GeometryZ),
    create_time timestamp(6) without time zone,
    update_time timestamp(6) without time zone,
    status smallint DEFAULT 0,
    num numeric(32,0),
    type character varying(255),
    zlevel character varying(255),
    data_source smallint DEFAULT 0
);


ALTER TABLE public.traffic_sign OWNER TO postgres;

--
-- TOC entry 4698 (class 0 OID 0)
-- Dependencies: 232
-- Name: TABLE traffic_sign; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.traffic_sign IS '交通牌';


--
-- TOC entry 4699 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN traffic_sign.traffic_sign_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.traffic_sign.traffic_sign_id IS '主键id';


--
-- TOC entry 4700 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN traffic_sign.task_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.traffic_sign.task_id IS '任务编号';


--
-- TOC entry 4701 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN traffic_sign.geom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.traffic_sign.geom IS '地理信息';


--
-- TOC entry 4702 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN traffic_sign.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.traffic_sign.create_time IS '创建时间';


--
-- TOC entry 4703 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN traffic_sign.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.traffic_sign.update_time IS '修改时间';


--
-- TOC entry 4704 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN traffic_sign.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.traffic_sign.status IS '删除状态';


--
-- TOC entry 4705 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN traffic_sign.num; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.traffic_sign.num IS '限速值';


--
-- TOC entry 4706 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN traffic_sign.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.traffic_sign.type IS '类型';


--
-- TOC entry 4707 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN traffic_sign.zlevel; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.traffic_sign.zlevel IS '存储对应的z分层信息';


--
-- TOC entry 4708 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN traffic_sign.data_source; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.traffic_sign.data_source IS '数据来源0 表示工具绘制，1表示算法生成，2表示数据导入';


--
-- TOC entry 213 (class 1259 OID 17980)
-- Name: worker_node_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.worker_node_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.worker_node_id_seq OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 18121)
-- Name: worker_node; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.worker_node (
    host_name character varying(255),
    port character varying(255),
    type smallint,
    launch_date date,
    modified timestamp(6) without time zone,
    created timestamp(6) without time zone,
    id integer DEFAULT nextval('public.worker_node_id_seq'::regclass)
);


ALTER TABLE public.worker_node OWNER TO postgres;

--
-- TOC entry 4499 (class 0 OID 17983)
-- Dependencies: 214
-- Data for Name: assignment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4500 (class 0 OID 17986)
-- Dependencies: 215
-- Data for Name: boundary; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.boundary VALUES ('8645924713383591819', 100001, '01020000A0E6100000070000002689D956E9535E40887A15A7C7363F405397F9FF52CDFA3F01A06253E9535E405462AE77C5363F407E06E87F3856F83F38D97843E9535E40B80F0B78C3363F40B5F9E2FF4C04F83F49281AF7E8535E40A0716378C1363F40933F15C05FAFF73F5904BA87E8535E40A49A2711C0363F40933F15C05FAFF73FA2197008E8535E40E0D11558BF363F40E069F57F55D8F73F0DC3A27DE7535E40E014351CBF363F40A2F8E29FDA27F83F', '2025-06-03 10:28:30.403096', '2025-06-03 12:03:12.705425', 0, 'solid', 'white', 'curb', '0', 'virtual', '["non_motor_vehicle","walker"]', '2', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271660', 100001, '01020000A0E61000000C0000008C14FFB4E7535E40DC2E69C9B9363F4000000000BD13FA3F188DF16BE8535E403CF039C9B9363F400000002042E3F93F385A1F20E9535E407032B535BA363F4000000060235EFA3F632D0ECCE9535E40A870950BBB363F40000000205ED7FA3F9537856AEA535E40EC835C44BC363F40000000205ED7FA3FFDD0B3F6EA535E40A0E182D6BD363F4000000020A930FB3F8620586CEB535E4054CDD1B5BF363F40000000A0BDDEFA3F732CDDC7EB535E40E83EB9D3C1363F4000000060B307FB3F7B367D06EC535E40FC24C81FC4363F40000000C00002FA3F28B14F26EC535E40A0C41788C6363F40000000E03335F93F1469552AEC535E40BCAB1CC2C7363F400000000026E2F83FB81D3B24EC535E40349AB544C9363F40000000C0C952FA3F', '2025-06-03 12:06:48.278266', '2025-06-04 11:12:38.443563', 0, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271662', 100001, '01020000A0E610000002000000534DC2E5EE535E408834CFB6BF363F40000000C03BEBF93FF930F59FE7535E40D0D252CFBB363F40000000C0DB98F93F', '2025-06-03 12:04:17.555563', '2025-06-04 11:12:38.8958', 0, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271663', 100001, '01020000A0E6100000020000004095D2E7EE535E409839CAB2C1363F400000008083CCF83F57771F8CE7535E40A8AA8EB7BD363F40000000A0DA27F83F', '2025-06-03 12:04:17.555563', '2025-06-04 11:12:39.258391', 0, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271659', 100001, '01020000A0E6100000020000008C14FFB4E7535E40DC2E69C9B9363F4000000000BD13FA3F4618B3E3EE535E40C0E76DBDBD363F40000000405099F93F', '2025-06-03 12:06:48.279264', '2025-06-04 11:12:38.26255', 0, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271658', 100001, '01020000A0E610000002000000DB2EBDC8E7535E40089268E3B7363F40000000203703F93F5EB2C6E0EE535E400C6EF7B4BB363F40000000C09911F83F', '2025-06-03 12:06:48.279264', '2025-06-04 11:12:38.534322', 0, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271635', 100001, '01020000A0E610000002000000FA062637EA535E40DC3474BBB0363F4095D121A05DFEF93FF816C762EA535E402C7B407DA4363F4096601880ABBCFB3F', '2025-06-03 12:15:40.155501', '2025-06-03 12:21:42.151246', 0, 'solid', 'white', 'curb', '0', 'curb', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271639', 100001, '01020000A0E610000002000000FCA797EFEB535E4010F750F6A4363F4000000000E9F0FA3F40BD0FC3EB535E40B8638784B1363F4000000060BC91FA3F', '2025-06-03 12:15:40.155501', '2025-06-04 11:02:36.590868', 0, 'solid', 'white', 'none', '0', 'driving', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271634', 100001, '01020000A0E6100000020000007C2C4085EA535E4058821DE3B0363F40000000605327FE3FEC3465B6EA535E405020C596A4363F40000000201CFAFD3F', '2025-06-03 12:15:40.155501', '2025-06-04 11:02:37.296489', 0, 'solid', 'white', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271633', 100001, '01020000A0E610000002000000C8FD7427EB535E40F0178235B1363F4000000020DB16FA3F53C1FF5BEB535E40D44549C9A4363F4000000000E9F0FA3F', '2025-06-03 12:16:07.169898', '2025-06-04 11:12:37.89737', 0, 'solid', 'white', 'none', '0', 'border', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271640', 100001, '01020000A0E61000000200000053C1FF5BEB535E40D44549C9A4363F4000000000E9F0FA3FC8FD7427EB535E40F0178235B1363F4000000020DB16FA3F', '2025-06-03 12:15:40.154503', '2025-06-04 11:12:37.99009', 0, 'solid', 'white', 'none', '0', 'border', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271637', 100001, '01020000A0E610000002000000C1022D97EC535E40F8BA6F29A5363F40C922E01FD5A1FA3F3E956E73EC535E4050381ADEB1363F4047681A00E9D4FB3F', '2025-06-03 12:15:40.155501', '2025-06-03 12:19:57.39803', 0, 'solid', 'white', 'none', '0', 'driving', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271638', 100001, '01020000A0E610000002000000E5BB70F4EC535E40B0FEE345A5363F407CF8FF5FDF78FA3F37ECA3C5EC535E40C064DC07B2363F40009714E03A8DFA3F', '2025-06-03 12:15:40.155501', '2025-06-03 12:19:57.480973', 0, 'solid', 'white', 'curb', '0', 'curb', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271636', 100001, '01020000A0E6100000020000000F416393ED535E404C736076A5363F405E07F2DFC843FE3F1576B166ED535E40E85BA659B2363F40AAC9DFFFBF78FC3F', '2025-06-03 14:25:43.327561', '2025-06-03 14:25:43.327561', 99, 'solid', 'white', 'curb', '0', 'sidewalk', '["non_motor_vehicle","walker"]', '2', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271618', 100001, '01020000A0E61000000A0000008C14FFB4E7535E40DC2E69C9B9363F4000000000BD13FA3F34248E3FE8535E4064D737DCB9363F40000000604CBAF93F50FFF6C8E8535E40B0146A9CB9363F40000000E0370CFA3F7A330C4DE9535E409069F60BB9363F40000000A02D35FA3F6E41CBC7E9535E4098D23D2FB8363F40000000C0E18CFA3FD1877835EA535E40644CF60CB7363F4000000000EC63FA3FB666BE92EA535E409CB2EEADB5363F4000000080D7B5FA3F662AC9DCEA535E40A09ED21CB4363F40000000A03A5DFA3F93265711EB535E406081D465B2363F40000000A0C668FA3FC8FD7427EB535E40F0178235B1363F4000000020DB16FA3F', '2025-06-03 14:10:23.307169', '2025-06-04 11:12:38.352854', 0, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271616', 100001, '01020000A0E61000000B00000040BD0FC3EB535E40B8638784B1363F4000000060BC91FA3FD32A37A7EB535E40EC0ABDCBB3363F4000000060BC91FA3FCE92306EEB535E4004D287F9B5363F40000000A01101FB3FC369B719EB535E404465FEFCB7363F40000000A01101FB3FF8D05CACEA535E40CCAD6CC6B9363F40000000E05300FB3FBD2F7329EA535E40FC06F747BB363F40000000205ED7FA3F516EF494E9535E40BCF6DE75BC363F40000000A07285FA3F38F864F3E8535E402C24F746BD363F40000000A05691F93FB601AC49E8535E40585BECB4BD363F40000000E00DF7F83F5AC683B6E7535E40DC0462B6BD363F4000000060D050F83F57771F8CE7535E40A8AA8EB7BD363F40000000A0DA27F83F', '2025-06-03 14:10:23.307169', '2025-06-04 11:12:39.349023', 0, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8577085527319117819', 100001, '01020000A0E610000002000000FBEF9333EC535E40688B9A6BF5363F40000000C015E5FB3F44135932EC535E408C997CAFF5363F40000000800B0EFC3F', '2025-06-26 15:12:49.775869', '2025-07-15 14:13:10.366549', 0, 'solid', 'white', 'curb', '0', 'curb', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271612', 100001, '01020000A0E6100000020000003E956E73EC535E4050381ADEB1363F4000000000E9D4FB3F93993324EC535E40B04EB144C9363F40000000C0C952FA3F', '2025-06-03 14:10:23.307169', '2025-06-03 14:10:23.307169', 0, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271613', 100001, '01020000A0E61000000200000040BD0FC3EB535E40B8638784B1363F4000000060BC91FA3F6D4C0682EB535E40D84B63E6C8363F4000000040DE00FA3F', '2025-06-03 14:10:23.307169', '2025-06-04 11:02:36.679997', 0, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271591', 100001, '01020000A0E61000000A000000534DC2E5EE535E408834CFB6BF363F40000000C03BEBF93FA5B5A116EE535E409029F149BF363F40000000C03BEBF93F7B9D2D50ED535E4078BCAC63BE363F400000006074C7FA3F5FFC6C98EC535E401C39050BBD363F40000000A0B823FB3FB50BF6F4EB535E40BCAE724ABB363F4000000000088AFB3F0C08BF6AEB535E4040EC982FB9363F40000000801C38FB3FEAE7FCFDEA535E40183ECFCAB6363F40000000A01101FB3F5DA1FBB1EA535E408C59B92EB4363F4000000000EC63FA3FFDE80B89EA535E404073A86FB1363F4000000000EDC0FB3F7C2C4085EA535E4058821DE3B0363F40000000605327FE3F', '2025-06-03 14:14:51.20812', '2025-06-04 11:02:37.386414', 0, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271581', 100001, '01020000A0E61000000200000041E793E7EA535E40ACC4238EC8363F40000000C0C952FA3FC8FD7427EB535E40F0178235B1363F4000000020DB16FA3F', '2025-06-03 14:17:17.777586', '2025-06-04 11:02:36.942994', 0, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271582', 100001, '01020000A0E6100000020000009011AE52EA535E40B06B4A38C8363F40000000E04CE1F83F7C2C4085EA535E4058821DE3B0363F40000000605327FE3F', '2025-06-03 14:17:17.777586', '2025-06-04 11:02:37.472631', 0, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271583', 100001, '01020000A0E61000000B00000041E793E7EA535E40ACC4238EC8363F40000000C0C952FA3F66CF38E9EA535E40A038F2D3C7363F40000000C0C952FA3F070B87DBEA535E40045780BCC5363F4000000040EC53FA3FB91DDDB2EA535E40B09354B5C3363F40000000A06287FA3F93B57670EA535E40983334CEC1363F40000000A069F4F93FDE4A5816EA535E40F45FEB15C0363F40000000605F1DFA3FDF043FA7E9535E40107BDD99BE363F40000000A069F4F93F2D538C26E9535E4060299165BD363F40000000604CBAF93F3DCA2698E8535E4070996B82BC363F40000000604CBAF93FED966300E8535E400CBB4DF7BB363F40000000604CBAF93FF930F59FE7535E40D0D252CFBB363F40000000C0DB98F93F', '2025-06-03 14:17:17.777586', '2025-06-04 11:12:39.167072', 0, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8520688827151417339', 100001, '01020000A0E6100000020000009C547984EC535E400CF813E2F4363F400000000019D0FB3FA5BD6D7AEC535E40B8B74550F8363F4000000000BFD4FB3F', '2025-07-15 14:37:30.557678', '2025-07-15 14:37:30.558132', 0, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8520688827151417341', 100001, '01020000A0E6100000030000007C164E49EB535E40B0BAFCF1D8363F40000000E045DFF83F986E9102EB535E40B4A178EEED363F400000000075B5F83FFF06CEE0EA535E4004C8A248F8363F40000000402619F83F', '2025-07-15 14:16:27.499135', '2025-07-15 14:37:30.618808', 0, 'solid', 'white', 'none', '0', 'border', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271291', 100001, '01020000A0E610000002000000B9517B19EA535E4098B67CBFD8363F40000000C062F8F73F9511AE52EA535E40B46B4A38C8363F40000000E04CE1F83F', '2025-06-03 14:42:06.324187', '2025-06-03 14:42:06.324187', 0, 'solid', 'white', 'curb', '0', 'driving', 'all_motor_vehicle', '2', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271290', 100001, '01020000A0E61000000300000066CAFD8AEC535E40D821F37FC9363F40000000E0CEB0F83FD4331D5DEC535E403C7CC6CAD7363F40000000A0EC3BF83F3E23C558EC535E40FCC61E1FD9363F4000000060E264F83F', '2025-06-03 14:42:06.324187', '2025-06-03 14:42:06.324187', 0, 'solid', 'white', 'curb', '0', 'curb', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271287', 100001, '01020000A0E61000000200000045E905B1E9535E402C961FAED8363F40000000805821FC3FD2ACD7E8E9535E4038F3E82AC8363F4000000040DCA3FA3F', '2025-06-03 14:42:06.325184', '2025-06-19 15:02:18.995785', 0, 'solid', 'white', 'curb', '0', NULL, 'null', NULL, 2);
INSERT INTO public.boundary VALUES ('8645782395347271292', 100001, '01020000A0E610000003000000005F7DAEE9535E4084A9412EF7363F40000000E043D0F63FDAF378EAE9535E4048A2F354E6363F40000000400037F73FB9517B19EA535E4098B67CBFD8363F40000000C062F8F73F', '2025-06-03 15:41:15.540726', '2025-06-03 15:41:15.540726', 99, 'solid', 'white', 'curb', '0', 'driving', 'all_motor_vehicle', '2', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271286', 100001, '01020000A0E610000004000000F1E2F346EA535E406CDAF24DF7363F4000000080B86BF83F75E5AB5EEA535E40047A0DEAF0363F400000000069EAF83FBA1DDB6AEA535E40E00EB341ED363F40000000206D0EF93FFB7428B1EA535E40D079B3D8D8363F40000000201B17F93F', '2025-06-03 15:41:49.850589', '2025-06-03 15:41:49.850589', 99, 'broken', 'white', 'none', '0', 'driving', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271289', 100001, '01020000A0E6100000020000003E23C558EC535E40FCC61E1FD9363F4000000060E264F83F41DB01F5EB535E40A87056A7F7363F400000002078D1FA3F', '2025-06-03 16:24:28.15157', '2025-06-03 16:24:28.15157', 99, 'solid', 'white', 'curb', '0', 'curb', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271288', 100001, '01020000A0E6100000020000005174C94AE9535E40F493871DF7363F40000000606A76F83F7E8B05B1E9535E40EC4A1FAED8363F40000000805821FC3F', '2025-06-03 16:24:28.778146', '2025-06-03 16:24:28.778146', 99, 'solid', 'white', 'curb', '0', 'curb', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271280', 100001, '01020000A0E610000003000000B81D3B24EC535E40349AB544C9363F40000000C0C952FA3F71CB4C0BEC535E40A8BCB8B5CE363F40000000400A5EF83FB2C951E8EB535E4004996D0CD9363F400000004083E9F73F', '2025-06-03 14:42:06.325184', '2025-06-04 10:38:51.332948', 0, 'solid', 'white', 'curb', '0', 'driving', 'null', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271283', 100001, '01020000A0E6100000020000007C164E49EB535E40B0BAFCF1D8363F40000000E045DFF83F6D4C0682EB535E40D84B63E6C8363F4000000040DE00FA3F', '2025-06-03 14:42:06.325184', '2025-06-04 10:46:16.158493', 0, 'solid', 'white', 'none', '0', 'border', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271282', 100001, '01020000A0E6100000020000006D4C0682EB535E40D84B63E6C8363F4000000040DE00FA3F7C164E49EB535E40B0BAFCF1D8363F40000000E045DFF83F', '2025-06-03 14:42:06.325184', '2025-06-04 10:46:16.246929', 0, 'solid', 'white', 'none', '0', 'border', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591914', 100001, '01020000A0E6100000020000004A74C94AE9535E401C94871DF7363F40B2EF09606A76F83F284820E9E9535E40381B55FAC7363F4018851840DCA3FA3F', '2025-06-03 14:42:10.117982', '2025-06-03 14:42:10.117982', 99, 'solid', 'white', 'curb', '0', 'curb', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271279', 100001, '01020000A0E61000000400000082DB51E8EB535E4088536D0CD9363F400000004083E9F73F90F176DDEB535E40F0B8C141DC363F40000000A0B1EFF73F964AB8A4EB535E40E8173EF2EC363F40000000A0A973F73FABFA9685EB535E40C4162B90F7363F40000000800794F83F', '2025-06-03 16:24:30.65822', '2025-06-03 16:24:30.65822', 99, 'solid', 'white', 'curb', '0', 'driving', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271285', 100001, '01020000A0E6100000040000006A1A28B1EA535E40B036B4D8D8363F40B75F0E201B17F93F8433FFB5EA535E40684B1171D7363F40B75F0E201B17F93F81BEB0D9EA535E40505B47DBCC363F40B2EE10E0A3F7F93F41E793E7EA535E40ACC4238EC8363F40A505FDBFC952FA3F', '2025-06-03 14:42:06.325184', '2025-06-03 16:02:44.804797', 0, 'solid', 'white', 'none', '0', 'driving', 'all_motor_vehicle', '0', NULL);
INSERT INTO public.boundary VALUES ('8645275692285558778', 100001, '01020000A0E610000002000000D7771B84ED535E40EC78225BDC363F40000000603FF6FB3F46F37A8BED535E400832F5F4D8363F40000000405D79FA3F', '2025-06-03 15:35:09.2973', '2025-06-03 15:35:09.2973', 99, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645275692285558776', 100001, '01020000A0E61000000200000035F6BA85ED535E403024AB9BDB363F40000000A049CDFB3F2A407B8BED535E40F4EFF4F4D8363F40000000405D79FA3F', '2025-06-03 15:38:00.843243', '2025-06-03 15:38:00.843243', 99, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645275692285558777', 100001, '01020000A0E610000002000000F69C1B84ED535E40EC01245BDC363F40000000603FF6FB3F35F6BA85ED535E403024AB9BDB363F40000000A049CDFB3F', '2025-06-03 16:54:21.239946', '2025-06-03 16:54:21.240941', 99, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8576944583672332279', 100001, '01020000A0E610000006000000402D0C93EB535E4030D9E916F5363F40000000207C4BFA3F5991F68FEB535E400C94F3D6F5363F40000000C03E41FB3F7F31078BEB535E40080D9068F6363F40000000608622FA3F6B332B8CEB535E406400EE9CF6363F40000000805DC6FA3F0FCA1589EB535E402C83B2BBF6363F40000000E09AD0F93F974C4987EB535E40DCD72AEBF6363F40000000A0B955F93F', '2025-07-15 14:16:27.612055', '2025-07-15 14:16:27.612091', 99, 'solid', 'white', 'curb', '0', 'driving', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645275692285558708', 100001, '01020000A0E6100000030000007C164E49EB535E40B0BAFCF1D8363F40000000E045DFF83F986E9102EB535E40B4A178EEED363F400000000075B5F83F0DDC63E4EA535E40F8EF5787F7363F40000000402619F83F', '2025-07-15 14:16:29.55292', '2025-07-15 14:16:29.552973', 99, 'solid', 'white', 'none', '0', 'border', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645275692285558709', 100001, '01020000A0E61000000300000079B8EFE1EA535E400431296EF7363F400000008030F0F73F034B1D00EB535E40B8E249D5ED363F400000000075B5F83F7C164E49EB535E40B0BAFCF1D8363F40000000E045DFF83F', '2025-07-15 14:16:30.199843', '2025-07-15 14:16:30.199889', 99, 'solid', 'white', 'none', '0', 'border', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645275692285558710', 100001, '01020000A0E6100000020000004A74C94AE9535E401C94871DF7363F40000000606A76F83F45E905B1E9535E402C961FAED8363F40000000805821FC3F', '2025-07-15 14:16:31.451494', '2025-07-15 14:16:31.451525', 99, 'solid', 'white', 'curb', '0', 'curb', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645275692285558775', 100001, '01020000A0E6100000020000009B26BB85ED535E40508BA99BDB363F40000000A049CDFB3FDF2CB188ED535E405CB02D3EDA363F40000000C048CBFA3F', '2025-06-03 16:54:21.852', '2025-06-03 16:54:21.852', 99, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645275692285558774', 100001, '01020000A0E610000002000000DF2CB188ED535E405CB02D3EDA363F40000000C048CBFA3F2A407B8BED535E40F4EFF4F4D8363F40000000405D79FA3F', '2025-06-03 16:54:22.464714', '2025-06-03 16:54:22.464714', 99, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8520688827151417340', 100001, '01020000A0E610000003000000B53D69D3EA535E406CA573A4F7363F40000000C03AC7F73F034B1D00EB535E40B8E249D5ED363F400000000075B5F83F7C164E49EB535E40B0BAFCF1D8363F40000000E045DFF83F', '2025-07-15 14:16:27.499397', '2025-07-15 14:37:30.716764', 0, 'solid', 'white', 'none', '0', 'border', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8520688827151417343', 100001, '01020000A0E61000000400000002533241EA535E402CDE457AF8363F4000000040AE94F83F7FE5AB5EEA535E40687A0DEAF0363F400000000069EAF83FD01DDB6AEA535E40F00EB341ED363F40000000206D0EF93F6A1A28B1EA535E40B036B4D8D8363F40000000201B17F93F', '2025-07-15 14:16:27.497536', '2025-07-15 14:37:30.811268', 0, 'broken', 'white', 'none', '0', 'driving', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8520688827151417342', 100001, '01020000A0E6100000030000008B7A84AAE9535E40ECB274CAF8363F40000000C0EB9EF73FF7F378EAE9535E4050A2F354E6363F40000000400037F73F8B737B19EA535E40ACE07CBFD8363F40000000C062F8F73F', '2025-07-15 14:16:27.49862', '2025-07-15 14:37:30.905623', 0, 'solid', 'white', 'curb', '0', 'driving', 'all_motor_vehicle', '2', NULL);
INSERT INTO public.boundary VALUES ('8645275692285558773', 100001, '01020000A0E610000003000000005F7DAEE9535E4084A9412EF7363F40000000E043D0F63FDAF378EAE9535E4048A2F354E6363F40000000400037F73F8B737B19EA535E40ACE07CBFD8363F40000000C062F8F73F', '2025-06-03 16:24:31.285664', '2025-06-03 16:24:31.285664', 99, 'solid', 'white', 'curb', '0', 'driving', 'all_motor_vehicle', '2', NULL);
INSERT INTO public.boundary VALUES ('8645275692285558772', 100001, '01020000A0E610000004000000F0E2F346EA535E40B4DAF24DF7363F4019AE0E80B86BF83F7FE5AB5EEA535E40687A0DEAF0363F40B257FCFF68EAF83FD01DDB6AEA535E40F00EB341ED363F408167E01F6D0EF93F6A1A28B1EA535E40B036B4D8D8363F40B75F0E201B17F93F', '2025-06-03 16:24:31.910868', '2025-06-03 16:24:31.910868', 99, 'broken', 'white', 'none', '0', 'driving', 'null', '0', NULL);
INSERT INTO public.boundary VALUES ('8645275692285558706', 100001, '01020000A0E610000003000000045F7DAEE9535E4038A9412EF7363F40000000E043D0F63FF7F378EAE9535E4050A2F354E6363F40000000400037F73F8B737B19EA535E40ACE07CBFD8363F40000000C062F8F73F', '2025-07-15 14:16:28.284679', '2025-07-15 14:16:28.284734', 99, 'solid', 'white', 'curb', '0', 'driving', 'all_motor_vehicle', '2', NULL);
INSERT INTO public.boundary VALUES ('8645275692285558705', 100001, '01020000A0E610000004000000F0E2F346EA535E40B4DAF24DF7363F4000000080B86BF83F7FE5AB5EEA535E40687A0DEAF0363F400000000069EAF83FD01DDB6AEA535E40F00EB341ED363F40000000206D0EF93F6A1A28B1EA535E40B036B4D8D8363F40000000201B17F93F', '2025-07-15 14:16:28.919057', '2025-07-15 14:16:28.919192', 99, 'broken', 'white', 'none', '0', 'driving', 'null', '0', NULL);
INSERT INTO public.boundary VALUES ('8645275692285558707', 100001, '01020000A0E610000004000000B2C951E8EB535E4004996D0CD9363F400000004083E9F73FADF176DDEB535E40C0B8C141DC363F40000000A0B1EFF73F7A4AB8A4EB535E40E4173EF2EC363F40000000A0A973F73FA6FA9685EB535E4018172B90F7363F40000000800794F83F', '2025-06-26 15:12:17.402938', '2025-06-26 15:12:17.402981', 99, 'solid', 'white', 'curb', '0', 'driving', 'null', '0', NULL);
INSERT INTO public.boundary VALUES ('8645275692285558711', 100001, '01020000A0E61000000200000062CEC458EC535E40F8301E1FD9363F4000000060E264F83F5EDB01F5EB535E40A47056A7F7363F400000002078D1FA3F', '2025-06-26 15:12:18.076937', '2025-06-26 15:12:18.076975', 99, 'solid', 'white', 'curb', '0', 'curb', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271284', 100001, '01020000A0E61000000400000079B8EFE1EA535E405C31296EF7363F400000008030F0F73FEB4A1D00EB535E40A0E249D5ED363F400000000075B5F83F4B348045EB535E4054FD763AD9363F40000000E045DFF83F82628246EB535E40184B87F1D8363F40000000E045DFF83F', '2025-06-03 16:24:29.403649', '2025-06-03 16:24:29.403649', 99, 'solid', 'white', 'none', '0', 'border', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271281', 100001, '01020000A0E6100000040000008A8F4D49EB535E40782EFEF1D8363F40000000E045DFF83FDD57F447EB535E40B4BBA553D9363F400000002050B6F83F7F6E9102EB535E4074A178EEED363F400000000075B5F83F0BDC63E4EA535E402CF05787F7363F40000000402619F83F', '2025-06-03 16:24:30.030835', '2025-06-03 16:24:30.030835', 99, 'solid', 'white', 'none', '0', 'border', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645275692285558704', 100001, '01020000A0E6100000020000008EBE2324EF535E406816B0B3DE363F40000000E0A31BFA3F8EBE2324EF535E400073BEE1D7363F40000000A09743FA3F', '2025-06-03 16:54:19.380985', '2025-06-03 16:54:19.380985', 99, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645275692285558703', 100001, '01020000A0E6100000020000008EBE2324EF535E400073BEE1D7363F40000000A09743FA3FEBFB122AEF535E4070E5FC95D0363F40000000C0C12CFE3F', '2025-06-03 16:54:20.010326', '2025-06-03 16:54:20.010326', 99, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645275692285558702', 100001, '01020000A0E61000000200000080616B65EF535E40D82D0FF3E6363F40000000807F18FB3F8EBE2324EF535E406816B0B3DE363F40000000E0A31BFA3F', '2025-06-03 16:54:20.625832', '2025-06-03 16:54:20.625832', 99, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271615', 100001, '01020000A0E61000000C0000003E956E73EC535E4050381ADEB1363F4000000000E9D4FB3FE481196AEC535E408CB77A53B3363F40000000A0826EF93FA82DDD73EC535E404426BDC8B4363F40000000A01598F93F355C6D90EC535E4008D38532B6363F40000000E01F6FF93FCEC9EBBEEC535E40B089D785B7363F40000000A01598F93F9A9CEEFDEC535E40A0E260B8B8363F40000000201F8AF93F65218B4BED535E407074D6C0B9363F40000000803338F93FADF966A5ED535E4078A92A97BA363F40000000405C07F93F0C11C608EE535E40C45ADF34BB363F40000000C070B5F83F4962A472EE535E407CE02395BB363F40000000007B8CF83F4C1E2FA6EE535E4054DDD9A8BB363F40000000408563F83F5EB2C6E0EE535E400C6EF7B4BB363F40000000C09911F83F', '2025-06-03 14:10:23.307169', '2025-06-04 10:54:53.403665', 0, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271614', 100001, '01020000A0E61000000B00000040BD0FC3EB535E40B8638784B1363F4000000060BC91FA3FC47DF8BAEB535E405C1F2160B3363F4000000060BC91FA3F18C423CBEB535E40CCAC5439B5363F40000000603086FA3F491516F3EB535E409CABB801B7363F40000000A03A5DFA3FDBFB9631EC535E40A4C275ABB8363F400000002026AFFA3FDF35C284EC535E4084EF9329BA363F4000000020CDD1FA3F33260EEAEC535E4094F68370BB363F4000000020F62DFA3F18E5695EED535E4088564A76BC363F40000000600005FA3FD80F49DEED535E404C8AF732BD363F40000000E01EFDF93F2496CC65EE535E4070FCD2A0BD363F40000000405099F93F4618B3E3EE535E40C0E76DBDBD363F40000000405099F93F', '2025-06-03 14:10:23.307169', '2025-06-04 11:02:36.767727', 0, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271590', 100001, '01020000A0E6100000090000004618B3E3EE535E40C0E76DBDBD363F40000000405099F93F301B252EEE535E40F0AAE04DBD363F400000000029D4F93FF3300381ED535E408CE02874BC363F40000000201F8AF93F90BF8EE1EC535E403857EB36BB363F4000000020F62DFA3FC418A254EC535E400013C59FB9363F40000000A0E17FFA3F266183DEEB535E40147813BBB7363F400000002026AFFA3F14CBCA82EB535E40A0189A97B5363F40000000E01BD8FA3F7D4D4144EB535E40B0ADF045B3363F40000000A0C668FA3FC8FD7427EB535E40F0178235B1363F4000000020DB16FA3F', '2025-06-03 14:14:51.20812', '2025-06-04 11:02:37.210215', 0, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271584', 100001, '01020000A0E61000000B0000009011AE52EA535E40B06B4A38C8363F40000000E04CE1F83F791AFB55EA535E40E4E0684DC7363F40000000402E5CF93F30D1194BEA535E408864FDA3C5363F4000000000A091F93FAAC8CA2AEA535E4024087D07C4363F4000000040AA68F93F5B4209F6E9535E40E8B97884C2363F4000000040AA68F93F9A696FAEE9535E40FC5CA626C1363F40000000E09C27F93F0D842A56E9535E40B48AB1F8BF363F400000002018CEF83FAEB0E8EFE8535E40F004BF03BF363F400000002018CEF83F96A93D7DE8535E4030555A60BE363F400000002018CEF83F22514C04E8535E40E05D3B0CBE363F40000000E03653F83F57771F8CE7535E40A8AA8EB7BD363F40000000A0DA27F83F', '2025-06-03 14:17:17.777586', '2025-06-04 11:12:38.07985', 0, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271661', 100001, '01020000A0E61000000C000000F930F59FE7535E40D0D252CFBB363F40000000C0DB98F93F32A27F45E8535E409CD93CE8BB363F40000000604CBAF93F51B543E7E8535E40BC991463BC363F40000000E0370CFA3F87EA5580E9535E4028E3243CBD363F40000000208733FA3F3E7A0F0CEA535E405815DA6CBE363F40000000E04A6FFA3FE4D63286EA535E405C12EDEBBF363F400000006036C1FA3F89BD09EBEA535E409870BDADC1363F40000000A0BDDEFA3F88338237EB535E4020CA9EA4C3363F4000000080CDCEFA3F49844B69EB535E40D86748C1C5363F4000000000E27CFA3FFFFDE07EEB535E40E0834DF3C7363F4000000000D429FA3FFDB2C57FEB535E4014204880C8363F4000000040DE00FA3F6D4C0682EB535E40D84B63E6C8363F4000000040DE00FA3F', '2025-06-03 12:06:48.278266', '2025-06-04 11:12:38.985558', 0, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271617', 100001, '01020000A0E61000000A000000C8FD7427EB535E40F0178235B1363F4000000020DB16FA3FF0379D0EEB535E40705DA630B3363F4000000060BC91FA3FC14E65DCEA535E405C614F15B5363F40000000E01BD8FA3F6F525792EA535E4078BFCAD4B6363F4000000080D7B5FA3FA4B6B132EA535E4068F47861B8363F4000000080D7B5FA3F88BB5EC0E9535E40C0364EAFB9363F400000006068AEFA3F414AD53EE9535E4010A92CB4BA363F40000000201987FA3F29A105B2E8535E40482F1C68BB363F40000000A02D35FA3F9B0A381EE8535E401CECA8C5BB363F40000000604CBAF93FF930F59FE7535E40D0D252CFBB363F40000000C0DB98F93F', '2025-06-03 14:10:23.307169', '2025-06-04 11:12:39.077314', 0, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645782395347271619', 100001, '01020000A0E61000000B000000DB2EBDC8E7535E40089268E3B7363F40000000203703F93FE95BE92CE8535E40AC6BE90EB8363F40000000A047FEF83FF0A0C591E8535E40A88440FEB7363F40000000E02879F93F311641F4E8535E403CB6EEB1B7363F40000000200AF4F93FDA145D51E9535E4014B5442CB7363F40000000200AF4F93F12FC46A6E9535E4008E35171B6363F4000000040F63AFA3F145F69F0E9535E40F8F2C186B5363F40000000800012FA3F8D91822DEA535E405CD8BE73B4363F40000000800012FA3F530EB95BEA535E4000E19A40B3363F400000002072ACF93F700EA479EA535E40500DAAF6B1363F40000000E09031F93F7C2C4085EA535E4058821DE3B0363F40000000605327FE3F', '2025-06-03 14:10:23.306142', '2025-06-04 11:12:38.626076', 0, 'virtual', 'none', 'none', '0', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8642101470935646120', 100001, '01020000A0E6100000080000002A9DE511F1535E4050CDDC69AB363F4000000040E17AF4BF2A9DE511F1535E400CB75590B3363F4000000040E17AF4BFEDA08904F3535E40B843188EB4363F4000000040E17AF4BF2D52F3DEF3535E40742CCD63B4363F4000000040E17AF4BF049B7556F4535E400CB75590B3363F4000000040E17AF4BFBF81F166F4535E40E0D69805B2363F4000000040E17AF4BF6F7B106BF4535E4078ECFD2CAD363F4000000040E17AF4BF394FE987F4535E40D8A87831AB363F4000000040E17AF4BF', '2025-06-04 16:55:45.247103', '2025-06-04 16:55:45.247103', 99, 'virtual', 'none', 'none', '1', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8642101470935646121', 100001, '01020000A0E61000000700000012B3925CF0535E4088C906C3AB363F4000000040E17AF4BF1FA0EF68F0535E40F46CF149B5363F4000000040E17AF4BFFC059AC2F2535E40DC46C7E2B6363F4000000040E17AF4BF453C4694F4535E40143895C6B6363F4000000040E17AF4BF0E986BFFF4535E40A8D2FC2FB4363F4000000040E17AF4BF365F8224F5535E4068AE4ECAAC363F4000000040E17AF4BF87656320F5535E4014BBAA4DAB363F4000000040E17AF4BF', '2025-06-04 16:55:45.887651', '2025-06-04 16:55:45.887651', 99, 'virtual', 'none', 'none', '1', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8642101470935646117', 100001, '01020000A0E610000003000000394FE987F4535E40D8A87831AB363F4000000040E17AF4BF5160F49BF4535E4010F2CC04A3363F4000000040E17AF4BFA266D597F4535E4014F3C10D9F363F4000000040E17AF4BF', '2025-06-04 17:28:42.043396', '2025-06-04 17:28:42.043396', 99, 'virtual', 'none', 'none', '1', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8642101470935646118', 100001, '01020000A0E610000006000000AAA12E2EF1535E4008F3C10D9F363F4000000040E17AF4BFC57BE846F1535E4068F23E65A4363F4000000040E17AF4BFC57BE846F1535E40B050AB52A6363F4000000040E17AF4BF9CB4D121F1535E40AC6168DDA7363F4000000040E17AF4BF3FC19319F1535E40F80ACF57AA363F4000000040E17AF4BF2A9DE511F1535E4050CDDC69AB363F4000000040E17AF4BF', '2025-06-04 17:28:42.619862', '2025-06-04 17:28:42.619862', 99, 'virtual', 'none', 'none', '1', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8642101470935646093', 100001, '01020000A0E6100000030000007906E611F1535E406C8BDD69AB363F4000000040E17AF4BF7906E611F1535E4050905490B3363F4000000040E17AF4BFCDFBD122F2535E4024613A1BB4363F4000000040E17AF4BF', '2025-06-04 16:59:42.020499', '2025-06-04 16:59:42.020499', 99, 'virtual', 'none', 'none', '1', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8642101470935646092', 100001, '01020000A0E610000007000000CDFBD122F2535E4024613A1BB4363F4000000040E17AF4BF88D28904F3535E40543D1A8EB4363F4000000040E17AF4BFBEDAF3DEF3535E4044A0CE63B4363F4000000040E17AF4BFD2FA7556F4535E4050905490B3363F4000000040E17AF4BFFFC8F166F4535E40BC929805B2363F4000000040E17AF4BF0033106BF4535E4004ECFC2CAD363F4000000040E17AF4BF5965E987F4535E40BC287A31AB363F4000000040E17AF4BF', '2025-06-04 17:28:44.34989', '2025-06-04 17:28:44.34989', 99, 'virtual', 'none', 'none', '1', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8642101470935646076', 100001, '01020000A0E6100000040000008506E611F1535E4060E3876BB1363F4000000040E17AF4BF2971F151F1535E4004ADC092B2363F4000000040E17AF4BF98507E72F1535E408CABD41CB3363F4000000040E17AF4BFEC67D222F2535E4004993A1BB4363F4000000040E17AF4BF', '2025-06-04 17:28:40.888305', '2025-06-04 17:28:40.888305', 99, 'virtual', 'none', 'none', '1', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8642101470935646074', 100001, '01020000A0E610000005000000EB486F64F0535E40F00517D2B1363F4000000040E17AF4BF8E4C919FF0535E40180F868EB4363F4000000040E17AF4BFE27C16C4F0535E40F06029D5B4363F4000000040E17AF4BF1B4DC61EF1535E4008BD3641B5363F4000000040E17AF4BF46342921F2535E40A8F51375B6363F4000000040E17AF4BF', '2025-06-04 17:28:41.466427', '2025-06-04 17:28:41.466427', 99, 'virtual', 'none', 'none', '1', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8642101470935646077', 100001, '01020000A0E6100000020000007906E611F1535E406C8BDD69AB363F4000000040E17AF4BF7906E611F1535E40CC49886BB1363F4000000040E17AF4BF', '2025-06-04 17:28:39.737733', '2025-06-04 17:28:39.737733', 99, 'virtual', 'none', 'none', '1', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8642101470935646075', 100001, '01020000A0E610000002000000B017935CF0535E40200005C3AB363F4000000040E17AF4BFE37F6F64F0535E4064DF18D2B1363F4000000040E17AF4BF', '2025-06-04 17:28:40.313132', '2025-06-04 17:28:40.313132', 99, 'virtual', 'none', 'none', '1', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8642101470935646091', 100001, '01020000A0E610000003000000B017935CF0535E40200005C3AB363F4000000040E17AF4BF0869EF68F0535E4068B1F049B5363F4000000040E17AF4BFB5172921F2535E40C8311575B6363F4000000040E17AF4BF', '2025-06-04 16:59:42.616895', '2025-06-04 16:59:42.616895', 99, 'virtual', 'none', 'none', '1', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8642101470935646116', 100001, '01020000A0E61000000400000087656320F5535E4014BBAA4DAB363F4000000040E17AF4BF694A4751F5535E40644307D6A4363F4000000040E17AF4BF694A4751F5535E40E4774709A1363F4000000040E17AF4BF694A4751F5535E40F008F4299F363F4000000040E17AF4BF', '2025-06-04 17:28:43.196038', '2025-06-04 17:28:43.196038', 99, 'virtual', 'none', 'none', '1', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8642101470935646090', 100001, '01020000A0E610000006000000B5172921F2535E40C8311575B6363F4000000040E17AF4BFFE8699C2F2535E4060C0C8E2B6363F4000000040E17AF4BF71B64594F4535E4034E994C6B6363F4000000040E17AF4BF6D856BFFF4535E408878FB2FB4363F4000000040E17AF4BFDE9E8224F5535E4074EC4DCAAC363F4000000040E17AF4BFC7216320F5535E4008B5A94DAB363F4000000040E17AF4BF', '2025-06-04 17:28:43.773534', '2025-06-04 17:28:43.773534', 99, 'virtual', 'none', 'none', '1', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8642101470935646119', 100001, '01020000A0E6100000040000006AF0C453F0535E4018E8A8FF9E363F4000000040E17AF4BF0CFD864BF0535E4068F23E65A4363F4000000040E17AF4BFAC094943F0535E40F4749AF9A7363F4000000040E17AF4BF12B3925CF0535E4088C906C3AB363F4000000040E17AF4BF', '2025-06-04 17:28:44.925963', '2025-06-04 17:28:44.925963', 99, 'virtual', 'none', 'none', '1', 'virtual', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8577085527319117822', 100001, '01020000A0E61000000200000062CEC458EC535E40F8301E1FD9363F4000000060E264F83F1C0E9433EC535E4060539A6BF5363F40000000C015E5FB3F', '2025-06-26 15:12:17.263917', '2025-06-26 15:12:49.864527', 0, 'solid', 'white', 'curb', '0', 'curb', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8577085527319117821', 100001, '01020000A0E610000002000000F8156F14EC535E40AC80D859F5363F40000000207C4BFA3F41DB01F5EB535E40A87056A7F7363F400000002078D1FA3F', '2025-06-26 15:12:49.956095', '2025-06-26 15:12:49.956128', 99, 'solid', 'white', 'curb', '0', 'curb', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8577085527319117823', 100001, '01020000A0E610000002000000E682138CEB535E405880D859F5363F40000000C0EC88F83FABFA9685EB535E40C4162B90F7363F40000000800794F83F', '2025-06-26 15:12:50.566285', '2025-06-26 15:12:50.566536', 99, 'solid', 'white', 'curb', '0', 'driving', 'null', '0', NULL);
INSERT INTO public.boundary VALUES ('8577085527319117824', 100001, '01020000A0E610000004000000B2C951E8EB535E4004996D0CD9363F400000004083E9F73FADF176DDEB535E40C0B8C141DC363F40000000A0B1EFF73F7A4AB8A4EB535E40E4173EF2EC363F40000000A0A973F73F402D0C93EB535E4030D9E916F5363F40000000207C4BFA3F', '2025-06-26 15:12:17.256772', '2025-06-26 16:14:39.791686', 0, 'solid', 'white', 'curb', '0', 'driving', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8577085527319117820', 100001, '01020000A0E610000003000000D3FB128CEB535E40D077DA59F5363F40000000C0EC88F83F6D090C9DEB535E409C2B4E6BF6363F40000000004918FB3FABFA9685EB535E40C4162B90F7363F40000000800794F83F', '2025-06-26 15:14:06.400392', '2025-06-26 15:14:06.400421', 99, 'solid', 'white', 'curb', '0', 'driving', 'null', '0', NULL);
INSERT INTO public.boundary VALUES ('8577085527319117818', 100001, '01020000A0E6100000020000001676592DEC535E403883195DF6363F40000000C015E5FB3F41DB01F5EB535E40A87056A7F7363F400000002078D1FA3F', '2025-06-26 15:14:06.998034', '2025-06-26 15:14:06.99807', 99, 'solid', 'white', 'curb', '0', 'curb', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8577085527319117816', 100001, '01020000A0E610000003000000580D6FD1EB535E403C79786EF6363F4000000080346AFB3F580D57BCEB535E40C8B18B44F7363F40000000404F75FB3FA6FA9685EB535E4018172B90F7363F40000000800794F83F', '2025-06-26 15:24:57.511545', '2025-06-26 15:24:57.51158', 99, 'solid', 'white', 'curb', '0', 'driving', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8577085527319117815', 100001, '01020000A0E61000000200000069AF5B48EC535E4094E2DCFAF5363F4000000000F073FC3F4BC75D2DEC535E406430D62FF7363F40000000E07174FA3F', '2025-06-26 15:24:58.116715', '2025-06-26 15:24:58.116754', 99, 'solid', 'white', 'curb', '0', 'curb', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8577085527319117814', 100001, '01020000A0E6100000020000004BC75D2DEC535E406430D62FF7363F40000000E07174FA3F41DB01F5EB535E40A87056A7F7363F400000002078D1FA3F', '2025-06-26 15:24:58.711293', '2025-06-26 15:24:58.711327', 99, 'solid', 'white', 'curb', '0', 'curb', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8577085527319117817', 100001, '01020000A0E61000000300000065BC27BBEB535E404459EA19F5363F40000000C015E5FB3F15C632D7EB535E40809871DEF5363F40000000800B0EFC3F580D6FD1EB535E403C79786EF6363F4000000080346AFB3F', '2025-06-26 16:14:40.556612', '2025-06-26 16:14:40.556642', 99, 'solid', 'white', 'curb', '0', 'driving', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8576944583672332288', 100001, '01020000A0E610000002000000BB736FD1EB535E406CE3796EF6363F4000000080346AFB3FEE2B13C6EB535E400C8FC0E1F6363F40000000C03E41FB3F', '2025-06-26 16:14:41.148513', '2025-06-26 16:14:41.148545', 99, 'solid', 'white', 'curb', '0', 'driving', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8576944583672332287', 100001, '01020000A0E610000003000000EE2B13C6EB535E400C8FC0E1F6363F40000000C03E41FB3FF48756BCEB535E40E8AB8D44F7363F40000000404F75FB3F4B47C8ABEB535E4020496B5BF7363F40000000404F75FB3F', '2025-06-26 16:14:41.73633', '2025-06-26 16:14:41.736361', 99, 'solid', 'white', 'curb', '0', 'driving', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8576944583672332286', 100001, '01020000A0E6100000020000004B47C8ABEB535E4020496B5BF7363F40000000404F75FB3FABFA9685EB535E40C4162B90F7363F40000000800794F83F', '2025-06-26 16:14:42.323986', '2025-06-26 16:14:42.324014', 99, 'solid', 'white', 'curb', '0', 'driving', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8576944583672332284', 100001, '01020000A0E610000003000000570D974EEC535E4094342590F6363F40000000C00EF9FB3F580D431BEC535E4034886908F7363F40000000A0679DFA3F5EDB01F5EB535E40A47056A7F7363F400000002078D1FA3F', '2025-06-26 16:14:42.912866', '2025-06-26 16:14:42.912892', 99, 'solid', 'white', 'curb', '0', 'curb', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8576944583672332285', 100001, '01020000A0E61000000500000044135932EC535E408C997CAFF5363F40000000800B0EFC3FEAB81F31EC535E4078FA33ECF5363F40000000C03E41FB3FBC0B8330EC535E406024DB3DF6363F40000000402A93FB3FEAB81F31EC535E40783DCA95F6363F4000000000F75FFC3F8F5EE62FEC535E401809090BF7363F40000000A0679DFA3F', '2025-07-15 14:16:30.831373', '2025-07-15 14:16:30.831403', 99, 'solid', 'white', 'curb', '0', 'curb', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8576944583672332281', 100001, '01020000A0E610000002000000B8D59261EC535E40680D48CCF6363F40000000A03755FB3F580DFB62EC535E4088D3C957F7363F4000000080D382FB3F', '2025-06-26 15:27:31.635415', '2025-06-26 15:27:31.635444', 99, 'solid', 'white', 'curb', '0', 'curb', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8576944583672332282', 100001, '01020000A0E610000004000000580DFB62EC535E4088D3C957F7363F4000000080D382FB3F570D6B3EEC535E4048F5076BF7363F40000000C0DD59FB3F590D3B41EC535E4028260ED0F7363F400000002044C0F93F57DBFD07EC535E40EC9978E3F7363F40000000C03AC7F73F', '2025-06-26 15:27:32.244683', '2025-06-26 15:27:32.244716', 99, 'solid', 'white', 'curb', '0', 'curb', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8576944583672332283', 100001, '01020000A0E610000003000000B5D5964EEC535E40A4E32590F6363F40000000C00EF9FB3FE2C3F924EC535E4000503A2AF7363F40000000207C4BFA3F5EDB01F5EB535E40A47056A7F7363F400000002078D1FA3F', '2025-06-26 15:43:19.862863', '2025-06-26 16:14:39.877368', 99, 'solid', 'white', 'curb', '0', 'curb', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8576944583672332280', 100001, '01020000A0E6100000050000001C979261EC535E40540D47CCF6363F40000000A03755FB3F580DF14EEC535E40E8BA4625F7363F40000000A060B1FA3F5F8F6B3EEC535E405808066BF7363F40000000C0DD59FB3F580D4528EC535E40E8FCEB93F7363F40000000E06DFAFA3FC59CFD07EC535E40509A77E3F7363F40000000C03AC7F73F', '2025-06-26 16:14:39.962914', '2025-06-26 16:14:39.96294', 99, 'solid', 'white', 'curb', '0', 'curb', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591870', 100001, '01020000A0E6100000040000001737084FF5535E4078EBE33EC5363F40A5D91B009A1EF73F0FB661DFF1535E406C382D57C3363F409130DE1F87BAF73FF419717DEF535E40900B10FDC1363F40BABDF0BF9F3EF83F4095D2E7EE535E409839CAB2C1363F408D7F168083CCF83F', '2025-06-03 09:59:54.162489', '2025-06-03 11:57:14.233766', 0, 'solid', 'white', 'none', '0', 'driving', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645926637528940542', 100001, '01020000A0E610000004000000181531DEEA535E404CA7119FF8363F4000000040E17AF4BFBBFE1C00EB535E4074914BD5ED363F4000000040E17AF4BF1C028045EB535E407073753AD9363F4000000040E17AF4BFD0002D85EB535E40102C813DC7363F4000000040E17AF4BF', '2025-06-03 09:45:00.800508', '2025-06-03 09:45:00.800508', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645926637528940541', 100001, '01020000A0E610000003000000B182F38FE9535E40687C4DF8F7363F4000000040E17AF4BF2FFD48AFE9535E403C815A8EEE363F4000000040E17AF4BFF029483BEA535E402046E802C5363F4000000040E17AF4BF', '2025-06-03 09:45:01.411734', '2025-06-03 09:45:01.411734', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645926637528940540', 100001, '01020000A0E610000003000000D51BAEB0E8535E406457B67EF8363F4000000040E17AF4BF933B2E03E9535E4070614FD4DD363F4000000040E17AF4BF46612665E9535E400488BFDCC3363F4000000040E17AF4BF', '2025-06-03 09:45:02.613952', '2025-06-03 09:45:02.613952', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591930', 100001, '01020000A0E610000003000000C63FA792E9535E401CFD7928F7363F40000000602F22FB3FCC6149AFE9535E4048AB5B8EEE363F4000000020C579FB3FFADBB930EA535E40141AB524C8363F40000000A0420AFD3F', '2025-06-03 09:48:57.988993', '2025-06-03 09:48:57.988993', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591876', 100001, '01020000A0E610000004000000C57D3266F5535E40E039284FC3363F40841D06C066EBF73F248000F1F1535E404404256AC1363F4003E014609C23F83F4154AF95EF535E405C69211AC0363F40620EE0FF575DF93F534DC2E5EE535E408834CFB6BF363F4035D005C03BEBF93F', '2025-06-03 09:59:54.161491', '2025-06-03 11:57:29.668691', 0, 'solid', 'white', 'none', '0', 'driving', 'all_motor_vehicle', '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591872', 100001, '01020000A0E6100000040000004D8EE7A5F5535E408C11E4FBBD363F4016E20D40D5F6F83F7CEB3017F2535E4094C723F0BB363F409F6C02C03CF2FA3F9B6BB7AEEF535E4094ED9C96BA363F408E90E91F3096FB3F4618B3E3EE535E40A019B224BA363F40DCCCEBFF5130F93F', '2025-06-03 14:25:42.143113', '2025-06-03 14:25:42.143113', 99, 'solid', 'white', 'curb', '0', 'sidewalk', '["non_motor_vehicle","walker"]', '2', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591868', 100001, '01020000A0E610000004000000FA7D1B3CF5535E402040D3D3C6363F40CCEE0BE01433F93F6D53FFCAF1535E401418A2D8C4363F40C5C61A003ACCF83FEEBCA66AEF535E405C003E6BC3363F4017C7FF1F52CCF73F2F3456E9EE535E40C8959F26C3363F40A90DE45F1F2BF83F', '2025-06-03 14:25:42.736584', '2025-06-03 14:25:42.736584', 99, 'solid', 'white', 'curb', '0', 'curb', '["non_motor_vehicle","walker"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591929', 100001, '01020000A0E6100000030000009C8C5FB5E8535E4058647BFAF6363F40F9C00F8018BEF53FAA882E03E9535E40C02A4FD4DD363F403C4C00A0B8E3F83F2689D956E9535E40887A15A7C7363F405397F9FF52CDFA3F', '2025-06-03 14:25:45.690543', '2025-06-03 14:25:45.690543', 99, 'solid', 'white', 'curb', '0', 'biking', '["non_motor_vehicle","walker"]', '2', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591933', 100001, '01020000A0E610000003000000045F7DAEE9535E4038A9412EF7363F40D77218E043D0F63FF7F378EAE9535E4050A2F354E6363F40652F0E400037F73F9011AE52EA535E40B06B4A38C8363F408BC4E8DF4CE1F83F', '2025-06-03 14:42:06.499407', '2025-06-03 14:42:06.499407', 99, 'solid', 'white', 'curb', '0', 'driving', 'all_motor_vehicle', '2', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591934', 100001, '01020000A0E610000002000000A736031FED535E4060A14BD5C9363F408640FB7F3FEEFA3F29D33581EC535E4058CC7AC4F7363F408AB31540A04FFC3F', '2025-06-03 14:25:46.281826', '2025-06-03 14:25:46.281826', 99, 'solid', 'white', 'curb', '0', 'biking', '["walker","non_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591873', 100001, '01020000A0E6100000040000005EB2C6E0EE535E40100500B5BB363F40000000C09911F83FB505CBABEF535E4004D9EA26BC363F40000000601111F83F96854414F2535E4080FE7580BD363F400000008009BFF73FDFE49B93F5535E40DCD55E83BF363F40000000001DD8F73F', '2025-06-03 10:44:35.933611', '2025-06-03 10:44:35.934609', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8690215481291833344', 100001, '01020000A0E61000000500000017DE96F6E8535E405426446028373F4000000080FC08FB3F8BE79B13E9535E40F465B55D21373F40000000403C2EFB3FDB731D37E9535E401063187C16373F4000000040A66EFB3F4EF6B85BE9535E401001531C0C373F40000000E0B018FA3F7836596BE9535E40EC0E7E5607373F40000000007EB8F73F', '2025-06-03 09:10:07.028894', '2025-06-03 09:10:07.028929', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8690215481291833343', 100001, '01020000A0E610000006000000D69CFBA0E9535E402814BD3229373F40000000A042AEF83F7B3D69E7E9535E40D43CC42116373F400000002014B0F83F60C0BE44EA535E406013DA5B0F373F4000000000A484F83F4A389866EA535E40F85DB3980D373F40000000E0FA69F83F14C2DDA2EA535E4090386AF108373F40000000405F33F83F7B1407AEEA535E4048A1229606373F4000000000555CF83F', '2025-06-03 09:10:07.620641', '2025-06-03 09:10:07.620676', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8690215481291833342', 100001, '01020000A0E610000002000000DACA353CEA535E405CB015A329373F40000000606133F83F649018A3EA535E40F40BC0660A373F40000000405F33F83F', '2025-06-03 09:10:08.197852', '2025-06-03 09:10:08.197895', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591932', 100001, '01020000A0E610000006000000F0E2F346EA535E40B4DAF24DF7363F4019AE0E80B86BF83F7FE5AB5EEA535E40687A0DEAF0363F40B257FCFF68EAF83FD01DDB6AEA535E40F00EB341ED363F408167E01F6D0EF93F8433FFB5EA535E40684B1171D7363F40B75F0E201B17F93F81BEB0D9EA535E40505B47DBCC363F40B2EE10E0A3F7F93F41E793E7EA535E40ACC4238EC8363F40A505FDBFC952FA3F', '2025-06-03 14:42:07.103051', '2025-06-03 14:42:07.103051', 99, 'broken', 'white', 'none', '0', 'driving', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8678550728073019391', 100001, '01020000A0E61000000200000035D0A0EBEA535E40C8E03BD529373F4000000040DD07FA3F83F0B653EB535E4028C51ECC06373F40000000E05810F93F', '2025-06-03 09:10:08.774319', '2025-06-03 09:10:08.774555', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591931', 100001, '01020000A0E61000000400000079B8EFE1EA535E400431296EF7363F401DF5F17F30F0F73F034B1D00EB535E40B8E249D5ED363F40D09FFEFF74B5F83F3A348045EB535E40E8FC763AD9363F408FB8E6DF45DFF83F6C964F7FEB535E4054BA9DE5C8363F40DCF8F73FDE00FA3F', '2025-06-03 14:42:07.701801', '2025-06-03 14:42:07.701801', 99, 'solid', 'white', 'none', '0', 'border', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591924', 100001, '01020000A0E6100000040000006D4C0682EB535E40D84B63E6C8363F40DCF8F73FDE00FA3FCE57F447EB535E40E4BBA553D9363F40428E062050B6F83F986E9102EB535E40B4A178EEED363F40D09FFEFF74B5F83F0DDC63E4EA535E40F8EF5787F7363F4099D716402619F83F', '2025-06-03 14:42:08.306559', '2025-06-03 14:42:08.306559', 99, 'solid', 'white', 'none', '0', 'border', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591936', 100001, '01020000A0E610000005000000B81D3B24EC535E40349AB544C9363F40A505FDBFC952FA3F71CB4C0BEC535E40A8BCB8B5CE363F40A11006400A5EF83FADF176DDEB535E40C0B8C141DC363F404C6E0FA0B1EFF73F7A4AB8A4EB535E40E4173EF2EC363F40DF2E08A0A973F73FA6FA9685EB535E4018172B90F7363F40AF0EFC7F0794F83F', '2025-06-03 14:42:08.905105', '2025-06-03 14:42:08.905105', 99, 'solid', 'white', 'curb', '0', 'driving', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645926637528940544', 100001, '01020000A0E610000003000000439181ABE9535E407854CD04F8363F4000000040E17AF4BF44FF78EAE9535E4004B7F154E6363F4000000040E17AF4BF8C924C59EA535E405088974EC6363F4000000040E17AF4BF', '2025-06-03 09:44:59.580909', '2025-06-03 09:44:59.580909', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645926637528940543', 100001, '01020000A0E610000006000000C60F1C43EA535E406C6FCC56F8363F4000000040E17AF4BFA870AB5EEA535E40B41D0CEAF0363F4000000040E17AF4BFBC03DB6AEA535E40D412B241ED363F4000000040E17AF4BFBF12FFB5EA535E40DC031071D7363F4000000040E17AF4BF9786B0D9EA535E40647E45DBCC363F4000000040E17AF4BF07DF6FECEA535E40A8317E0CC7363F4000000040E17AF4BF', '2025-06-03 09:45:00.195525', '2025-06-03 09:45:00.195525', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645926637528940539', 100001, '01020000A0E6100000050000004360092CEC535E40F4707590C7363F4000000040E17AF4BF93604C0BEC535E4018FBB9B5CE363F4000000040E17AF4BF9CFA76DDEB535E405821C241DC363F4000000040E17AF4BF14EAB7A4EB535E40E4733EF2EC363F4000000040E17AF4BF9900A27FEB535E40F816F697F9363F4000000040E17AF4BF', '2025-06-03 09:45:02.015753', '2025-06-03 09:45:02.015753', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591935', 100001, '01020000A0E61000000300000070CAFD8AEC535E40C421F37FC9363F40E448E6DFCEB0F83FE5331D5DEC535E40187CC6CAD7363F405DDEFB9FEC3BF83F5EDB01F5EB535E40A47056A7F7363F405106112078D1FA3F', '2025-06-03 14:42:09.50826', '2025-06-03 14:42:09.50826', 99, 'solid', 'white', 'curb', '0', 'curb', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591866', 100001, '01020000A0E610000004000000CCF4007CF5535E40849A857CC1363F4000000080082AF83F0F423117F2535E40A0D5DC88BF363F40000000E08775F83FE2B8B7AEEF535E4010CC542FBE363F4000000000585DF93F4F54B3E3EE535E40C0726ABDBD363F40000000405099F93F', '2025-06-03 10:31:11.358117', '2025-06-03 10:31:11.358117', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591855', 100001, '01020000A0E61000000A0000006D4C0682EB535E40D84B63E6C8363F4000000040DE00FA3F9FB18A92EB535E40C8073AE3C6363F4000000080F62AFA3F39C197BFEB535E4020A914F4C4363F4000000040EC53FA3F05BB1805EC535E40B4E83527C3363F4000000080F62AFA3FAA61EF60EC535E40445EA48AC1363F40000000A07E9EFA3F5DAB51D0EC535E407415E42AC0363F400000006074C7FA3F8328DE4FED535E4040F3A412BF363F400000006074C7FA3F0EA3B3DBED535E40001B714ABE363F400000008008B8FA3F8A7A936FEE535E406C0857D8BD363F40000000405099F93F4618B3E3EE535E40C0E76DBDBD363F40000000405099F93F', '2025-06-03 10:18:24.906053', '2025-06-04 10:54:53.320924', 0, 'virtual', 'none', 'none', '0', 'virtual', 'null', '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591853', 100001, '01020000A0E61000000B0000004095D2E7EE535E409839CAB2C1363F400000008083CCF83FE66DAA7AEE535E40588BAFA1C1363F400000008083CCF83F2C8C4C0EEE535E40A866AFD1C1363F400000004079F5F83F60DC03A6ED535E40E46E5441C2363F40000000006F1EF93FD288FB44ED535E40B0373AEDC2363F40000000E0A4E9F83F435426EEEC535E40C4A727D0C3363F40000000A09A12F93F08AB27A4EC535E400C9A37E3C4363F40000000208664F93F4D1D3F69EC535E40787F0E1EC6363F40000000A09A12F93F1BE2363FEC535E40BC611B77C7363F4000000020B02BF93F28EB5527EC535E40A04CE2E3C8363F4000000000ABCDFA3F7B583324EC535E407444B344C9363F40000000C0C952FA3F', '2025-06-03 10:18:24.906053', '2025-06-03 10:18:24.906053', 0, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591842', 100001, '01020000A0E61000000F0000002F3456E9EE535E40C8959F26C3363F40A90DE45F1F2BF83F528FE370EE535E409844056DC3363F4035CE13C0AEEDF93F6B724232EE535E4068701FAFC3363F4025F008201554F83F1C34510AEE535E40CCCB9AEBC3363F40A90DE45F1F2BF83F8F79D3E3ED535E40CC853035C4363F405CE303A02902F83FD2C81FC0ED535E40A8CAF78CC4363F406CC10E40C39BF93FEFF2A79FED535E4094174FF3C4363F40B71DFCBF485AFA3FEEF76B82ED535E4018213268C5363F404E90E05F67DFF93FC8D76B68ED535E40347EA9EBC5363F40CD54E1FF29D5FA3FE9AA8048ED535E40186E8EADC6363F40DB5010C0F6A1F73F846C6531ED535E40EC4A5D62C7363F409C77E0BF2069F73FD1C2DA22ED535E40400D8409C8363F40032320403517F73FFB5E271BED535E4068180D9FC8363F40AD55EB5FBA02F93FD91F0F1AED535E4070B06A22C9363F40AA730F80ED35F83FA736031FED535E4060A14BD5C9363F408640FB7F3FEEFA3F', '2025-06-03 10:18:32.936373', '2025-06-03 12:03:12.624473', 0, 'solid', 'white', 'curb', '0', 'virtual', '["non_motor_vehicle","walker"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591852', 100001, '01020000A0E61000000C0000004095D2E7EE535E409839CAB2C1363F400000008083CCF83F61437988EE535E40BC57E6ABC1363F400000004079F5F83FAA3D392AEE535E40786EC1DDC1363F400000008083CCF83F3EA2EFCFED535E4098B0D746C2363F40000000006F1EF93FB7BC5A7CED535E4014B4F7E3C2363F40000000E0A4E9F83F57AF0432ED535E4050485BB0C3363F40000000A09A12F93F10B22FF3EC535E40D498CCA5C4363F40000000A09A12F93FD980C4C1EC535E40F47BD6BCC5363F40000000E0A4E9F83F1F82439FEC535E402075FEECC6363F4000000060B997F83FB818B98CEC535E401CA8062DC8363F4000000000D987F83F467CB58AEC535E40B0BB3573C9363F40000000E0CEB0F83FF8EFF78AEC535E408498F47FC9363F40000000E0CEB0F83F', '2025-06-03 10:21:36.215282', '2025-06-03 10:21:36.215282', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591863', 100001, '01020000A0E610000004000000CCF4007CF5535E40849A857CC1363F4000000080082AF83F0F423117F2535E40A0D5DC88BF363F40000000E08775F83FE2B8B7AEEF535E4010CC542FBE363F4000000000585DF93F4F54B3E3EE535E40C0726ABDBD363F40000000405099F93F', '2025-06-03 10:31:00.737951', '2025-06-03 10:31:00.737951', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591864', 100001, '01020000A0E610000004000000CCF4007CF5535E40849A857CC1363F4000000080082AF83F0F423117F2535E40A0D5DC88BF363F40000000E08775F83FE2B8B7AEEF535E4010CC542FBE363F4000000000585DF93F4F54B3E3EE535E40C0726ABDBD363F40000000405099F93F', '2025-06-03 10:31:10.755431', '2025-06-03 10:31:10.755431', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591865', 100001, '01020000A0E6100000040000004618B3E3EE535E40409C69BDBD363F40000000405099F93F9B6BB7AEEF535E403C70542FBE363F4000000000585DF93F7CEB3017F2535E402C4ADB88BF363F40000000E08775F83F02E0007CF5535E407801847CC1363F4000000080082AF83F', '2025-06-03 10:44:37.126304', '2025-06-03 10:44:37.126304', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591856', 100001, '01020000A0E61000000B00000041E793E7EA535E40ACC4238EC8363F40000000C0C952FA3FB6333AEDEA535E4058A7696AC6363F4000000040EC53FA3F2407980EEB535E40ECE15C52C4363F4000000000E27CFA3F8AD7A94AEB535E4034164756C2363F4000000080A472FB3FA8659C9FEB535E4038619885C0363F40000000E09E59FB3F6DEFDA0AEC535E40F0456FEEBE363F40000000E0C7B5FA3FA0432389EC535E407CD92A9DBD363F40000000A05542FB3F9A1A9F16ED535E40E4870A9CBC363F4000000020CDD1FA3FD9EE01AFED535E40C45DDEF2BB363F400000004033ABF93F596DAA4DEE535E408042CAA6BB363F40000000007B8CF83F8B01C7E0EE535E40F449F6B4BB363F40000000C09911F83F', '2025-06-03 11:15:18.096994', '2025-06-03 11:15:18.096994', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591846', 100001, '01020000A0E61000000A0000006C964F7FEB535E4054BA9DE5C8363F4000000040DE00FA3FA1338B92EB535E4098993AE3C6363F4000000080F62AFA3F0D4798BFEB535E40DCD314F4C4363F4000000040EC53FA3F7A631805EC535E4044E33727C3363F4000000080F62AFA3F2FEEEE60EC535E40A894A48AC1363F40000000A07E9EFA3F148C51D0EC535E40441BE42AC0363F400000006074C7FA3F2DD6DD4FED535E40B48DA612BF363F400000006074C7FA3FEFACB3DBED535E4050C36F4ABE363F400000008008B8FA3F575D936FEE535E40E81755D8BD363F40000000405099F93F8418B3E3EE535E40B8876EBDBD363F40000000405099F93F', '2025-06-03 17:25:24.903515', '2025-06-03 17:25:24.903515', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591847', 100001, '01020000A0E61000000B00000041E793E7EA535E40ACC4238EC8363F40000000C0C952FA3FCC3B3AEDEA535E4090F8696AC6363F4000000040EC53FA3F8CD9970EEB535E4088785D52C4363F4000000000E27CFA3FEDFAA94AEB535E4064AE4856C2363F4000000080A472FB3F2E799C9FEB535E4058AD9685C0363F40000000E09E59FB3F62FADA0AEC535E40286970EEBE363F40000000E0C7B5FA3F69322389EC535E40E8AE2A9DBD363F40000000A05542FB3FF6A79E16ED535E40B4030A9CBC363F4000000020CDD1FA3F14D801AFED535E40F8DBDFF2BB363F400000004033ABF93FA946AA4DEE535E40BC2ECAA6BB363F40000000007B8CF83F5EB2C6E0EE535E400C6EF7B4BB363F40000000C09911F83F', '2025-06-03 10:18:32.936373', '2025-06-04 10:54:53.568117', 0, 'virtual', 'none', 'none', '0', 'virtual', 'null', '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591858', 100001, '01020000A0E61000000A0000009011AE52EA535E40B06B4A38C8363F40000000E04CE1F83F4FD5D06FEA535E40A8407BA1C5363F4000000000A091F93F003B27AEEA535E4030A50C26C3363F40000000A06287FA3F5D5FCC0BEB535E402C464DD9C0363F4000000060B307FB3FF8D8E785EB535E40CCAF20CDBE363F4000000020A930FB3F2BDAC318EC535E4054277411BD363F40000000801C38FB3F0E0DEABFEC535E40BCC7C2B3BB363F4000000060D7A8FA3F0A494676ED535E401CA5ACBEBA363F40000000803338F93F10144E36EE535E400826A439BA363F40000000C09911F83FDA11B3E3EE535E40DC24B424BA363F40000000005230F93F', '2025-06-03 10:09:52.529401', '2025-06-03 10:09:52.529401', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591857', 100001, '01020000A0E61000000A00000041E793E7EA535E40ACC4238EC8363F40000000C0C952FA3FE645BF08EB535E404CAFD41FC6363F4000000000E27CFA3F624D0049EB535E400811AECEC3363F40000000C0D7A5FA3F163263A6EB535E4000B5B5ACC1363F40000000E09E59FB3FE28D111EEC535E40646982CABF363F4000000060B307FB3F727268ACEC535E406CF5BA36BE363F40000000E05F19FB3F60B2144DED535E40E821A4FDBC363F4000000020CDD1FA3F558534FBED535E40204AC128BC363F40000000005230F93F5D817DB1EE535E40345C8ABEBB363F40000000808F3AF83F079BC6E0EE535E407C8BF7B4BB363F40000000C09911F83F', '2025-06-03 10:09:53.127641', '2025-06-03 10:09:53.127641', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591801', 100001, '01020000A0E610000004000000C9417B88F5535E407801847CC1363F4000000080082AF83F434DAB23F2535E402C4ADB88BF363F40000000A07D9EF83F60CD31BBEF535E403C70542FBE363F40000000406234F93F0D7A2DF0EE535E40409C69BDBD363F400000000046C2F93F', '2025-06-03 10:44:36.52333', '2025-06-03 10:44:36.52333', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591843', 100001, '01020000A0E61000000C0000004095D2E7EE535E409839CAB2C1363F400000008083CCF83F61437988EE535E40BC57E6ABC1363F400000004079F5F83FAA3D392AEE535E40786EC1DDC1363F400000008083CCF83F3EA2EFCFED535E4098B0D746C2363F40000000006F1EF93FB7BC5A7CED535E4014B4F7E3C2363F40000000E0A4E9F83F57AF0432ED535E4050485BB0C3363F40000000A09A12F93F10B22FF3EC535E40D498CCA5C4363F40000000A09A12F93FD980C4C1EC535E40F47BD6BCC5363F40000000E0A4E9F83F1F82439FEC535E402075FEECC6363F4000000060B997F83FB818B98CEC535E401CA8062DC8363F4000000000D987F83F467CB58AEC535E40B0BB3573C9363F40000000E0CEB0F83FF8EFF78AEC535E408498F47FC9363F40000000E0CEB0F83F', '2025-06-03 10:18:32.936373', '2025-06-03 10:18:32.936373', 0, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591854', 100001, '01020000A0E61000000B000000534DC2E5EE535E408834CFB6BF363F40000000C03BEBF93F8924F761EE535E407C104299BF363F400000000046C2F93FA88CACDEED535E40505B72CABF363F40000000803114FA3F5AC3DF5FED535E404478E148C0363F4000000020934CFA3F97166BE9EC535E40D0F0B710C1363F40000000E0B1D1F93FBCECE77EEC535E40A856E31BC2363F4000000020934CFA3F8AC59223EC535E40D47E4562C3363F4000000080F62AFA3FAC0D32DAEB535E4008A7F3D9C4363F4000000080F62AFA3FBF8800A5EB535E402C998377C6363F4000000080F62AFA3FB3F99B85EB535E402876642EC8363F4000000000D429FA3F20B54E7FEB535E40587B9DE5C8363F4000000040DE00FA3F', '2025-06-03 10:20:20.60128', '2025-06-03 10:20:20.60128', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591845', 100001, '01020000A0E61000000B000000534DC2E5EE535E408834CFB6BF363F40000000C03BEBF93F8924F761EE535E407C104299BF363F400000000046C2F93FA88CACDEED535E40505B72CABF363F40000000803114FA3F5AC3DF5FED535E404478E148C0363F4000000020934CFA3F97166BE9EC535E40D0F0B710C1363F40000000E0B1D1F93FBCECE77EEC535E40A856E31BC2363F4000000020934CFA3F8AC59223EC535E40D47E4562C3363F4000000080F62AFA3FAC0D32DAEB535E4008A7F3D9C4363F4000000080F62AFA3FBF8800A5EB535E402C998377C6363F4000000080F62AFA3FB3F99B85EB535E402876642EC8363F4000000000D429FA3F20B54E7FEB535E40587B9DE5C8363F4000000040DE00FA3F', '2025-06-03 10:20:21.200751', '2025-06-03 10:20:21.200751', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591851', 100001, '01020000A0E61000000F0000002F3456E9EE535E40C8959F26C3363F40000000601F2BF83F2402E470EE535E40F86E036DC3363F40000000C0AEEDF93F5D354232EE535E400CD020AFC3363F40000000201554F83F1A2B510AEE535E405C2D99EBC3363F40000000601F2BF83FC974D3E3ED535E40B8F62E35C4363F40000000A02902F83F5A861FC0ED535E405427F78CC4363F4000000040C39BF93F7786A79FED535E40C0124EF3C4363F40000000C0485AFA3F21756B82ED535E40C8B83368C5363F400000006067DFF93F53526B68ED535E403C19A8EBC5363F40000000002AD5FA3F22F18048ED535E40EC2490ADC6363F40000000C0F6A1F73F48966531ED535E40A0205E62C7363F40000000C02069F73F8A71DA22ED535E40A4F58109C8363F40000000403517F73F29D1271BED535E4008040B9FC8363F4000000060BA02F93FE9E40E1AED535E4030356922C9363F4000000080ED35F83FA736031FED535E4060A14BD5C9363F40000000803FEEFA3F', '2025-06-03 10:21:35.628803', '2025-06-03 10:21:35.628803', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591820', 100001, '01020000A0E6100000080000009C64CAD8E7535E40B0CB4958B6363F409033F41F3703F93FB346DA19E8535E4088A96669B6363F4079C21A80705AF83FC240C692E8535E4014EA8CFCB5363F40B297F1DF51D5F83FEE103E15E9535E40C014F7B5B4363F40F8861B203350F93F86B2FA67E9535E4054619A59B3363F407E5B1580FD02F93FA5FB8794E9535E40943B0EB1B1363F400811F23FCE3BF83FAA85FCADE9535E40F4EEE765AB363F40FA2A1FA000FCF93FE73114C1E9535E40F446ED4BA4363F40152519206EB2F83F', '2025-06-03 14:25:43.919347', '2025-06-03 14:25:43.919347', 99, 'solid', 'white', 'curb', '0', 'sidewalk', '["walker","non_motor_vehicle"]', '2', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591800', 100001, '01020000A0E6100000020000005EB2C6E0EE535E400C6EF7B4BB363F40000000C09911F83F2CADAA8AF5535E4074031C7ABF363F40000000001DD8F73F', '2025-06-03 10:45:54.595028', '2025-06-04 10:54:53.237874', 0, 'solid', 'white', 'none', '0', 'driving', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591821', 100001, '01020000A0E61000000400000053F301F3E3535E40D878FC53B4363F40A5D9F07F3DCAF83F77029C09E6535E4070FF4159B5363F4041911C20003FF93F4F54BF9DE7535E40ECA7C048B6363F404409146041DAF83F9C64CAD8E7535E40B0CB4958B6363F409033F41F3703F93F', '2025-06-03 14:25:44.511603', '2025-06-03 14:25:44.511603', 99, 'solid', 'white', 'none', '0', 'sidewalk', '["non_motor_vehicle","walker"]', '2', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591814', 100001, '01020000A0E6100000030000002D1021D4E3535E40B08E1DC6B7363F4021BC154033F3F83FA29D54ADE5535E40780542B5B8363F40965FF47F8869F93F8C14FFB4E7535E40DC2E69C9B9363F406AF4E9FFBC13FA3F', '2025-06-03 10:28:30.404093', '2025-06-03 12:01:45.080721', 0, 'solid', 'white', 'none', '0', 'driving', 'all_motor_vehicle', '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591813', 100001, '01020000A0E610000004000000B7B2C3E6E3535E40CC3EC6B1B5363F40A5D9F07F3DCAF83F3A5684F6E5535E4080B444D6B6363F40AF771220299BF83F9F66EB5AE7535E40CCA0359AB7363F40C726EF9F4BB1F83FDB2EBDC8E7535E40089268E3B7363F409033F41F3703F93F', '2025-06-03 10:28:30.404093', '2025-06-03 12:01:45.164119', 0, 'solid', 'white', 'none', '0', 'driving', 'all_motor_vehicle', '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591817', 100001, '01020000A0E6100000030000000DC3A27DE7535E40E014351CBF363F40A2F8E29FDA27F83F930138A7E6535E404056AEBFBE363F403412ED9FB1CBFC3F318FB8A4E3535E4090A0AC10BD363F40B0F41160A7FCF93F', '2025-06-03 14:25:45.101151', '2025-06-03 14:25:45.101151', 99, 'solid', 'white', 'curb', '0', 'sidewalk', '["non_motor_vehicle","walker"]', '2', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591867', 100001, '01020000A0E6100000040000001AB81B3CF5535E40DCA0D4D3C6363F40000000E01433F93F757FFFCAF1535E40D09DA0D8C4363F40000000003ACCF83F6F6BA66AEF535E40D0F93C6BC3363F400000002052CCF73F393456E9EE535E4074959F26C3363F40000000601F2BF83F', '2025-06-03 10:30:58.934102', '2025-06-03 10:30:58.934102', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591869', 100001, '01020000A0E61000000400000052FC074FF5535E404C77E53EC5363F40000000009A1EF73F40D061DFF1535E4018402D57C3363F400000002087BAF73F7465717DEF535E40E08A11FDC1363F40000000C09F3EF83FA3E5D2E7EE535E4038C6CBB2C1363F400000008083CCF83F', '2025-06-03 10:30:59.539536', '2025-06-03 10:30:59.539536', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591875', 100001, '01020000A0E610000004000000788C3266F5535E40D46B284FC3363F40000000C066EBF73FC63E00F1F1535E40E099236AC1363F40000000609C23F83F5BC8AF95EF535E4060AA211AC0363F4000000000585DF93FE0C4C1E5EE535E4024B7D0B6BF363F40000000C03BEBF93F', '2025-06-03 10:31:00.141425', '2025-06-03 10:31:00.141425', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591874', 100001, '01020000A0E6100000040000003B1D9C93F5535E40AC0F5F83BF363F40000000001DD8F73F08574414F2535E4084147480BD363F400000008009BFF73F19CECAABEF535E408803EC26BC363F40000000601111F83F8469C6E0EE535E40C8A701B5BB363F40000000C09911F83F', '2025-06-03 10:31:01.334053', '2025-06-03 10:31:01.334053', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591871', 100001, '01020000A0E610000004000000E55FE7A5F5535E400827E5FBBD363F4000000040D5F6F83F0F423117F2535E40D07823F0BB363F40000000C03CF2FA3FE2B8B7AEEF535E4048619B96BA363F40000000203096FB3F4F54B3E3EE535E40A803B124BA363F40000000005230F93F', '2025-06-03 10:31:01.932769', '2025-06-03 10:31:01.932769', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591836', 100001, '01020000A0E61000000B000000534DC2E5EE535E408834CFB6BF363F40000000C03BEBF93FBCF2D766EE535E403057058BBF363F40000000C03BEBF93FB36EA2E7ED535E40089048ABBF363F40000000C03BEBF93FC2ABFE6BED535E406CC39F16C0363F40000000E08875FA3F85BCAEF7EC535E40A06CC5C9C0363F40000000A0A7FAF93F10CB3B8EEC535E4044454EBFC1363F4000000020934CFA3F3A1BD932EC535E4048BFBEEFC2363F4000000000E27CFA3F2F7E4DE8EB535E40AC53D851C4363F4000000080F62AFA3FE5D8DDB0EB535E408CEFD9DAC5363F4000000080F62AFA3F61BD388EEB535E40A48ED17EC7363F4000000000D429FA3F6D4C0682EB535E40D84B63E6C8363F4000000040DE00FA3F', '2025-06-03 10:22:00.117617', '2025-06-04 10:46:16.59389', 0, 'virtual', 'none', 'none', '0', 'virtual', 'null', '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591798', 100001, '01020000A0E6100000030000004618B3E3EE535E40C0E76DBDBD363F40000000405099F93F926DBA47F1535E4070C53D17BF363F40000000A064ABF83F07129A78F5535E40D42E976EC1363F4000000080082AF83F', '2025-06-03 10:45:54.595028', '2025-06-04 10:54:53.650439', 0, 'solid', 'white', 'curb', '0', 'border', '["walker"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591799', 100001, '01020000A0E61000000300000007129A78F5535E40D42E976EC1363F4000000080082AF83F926DBA47F1535E4070C53D17BF363F40000000A064ABF83F4618B3E3EE535E40C0E76DBDBD363F40000000405099F93F', '2025-06-03 10:45:54.595028', '2025-06-04 10:54:53.732959', 0, 'solid', 'white', 'none', '0', 'virtual', 'all_motor_vehicle', '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591818', 100001, '01020000A0E61000000300000057771F8CE7535E40A8AA8EB7BD363F40000000A0DA27F83F66776285E4535E4098E90827BC363F400000006072F9F73F997A7DB0E3535E40F40160C0BB363F40000000402211F83F', '2025-06-03 10:28:30.403096', '2025-06-04 11:12:38.171916', 0, 'solid', 'white', 'none', '0', 'driving', '["all_motor_vehicle"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591816', 100001, '01020000A0E610000003000000F930F59FE7535E40D0D252CFBB363F40000000C0DB98F93F06A7E21FE6535E404C8356EBBA363F40000000C069E4F93FF94C2BC2E3535E4058D63AC7B9363F4000000000EFDDF83F', '2025-06-03 10:28:30.403096', '2025-06-04 11:12:38.71647', 0, 'solid', 'white', 'none', '0', 'border', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591815', 100001, '01020000A0E610000003000000F94C2BC2E3535E4058D63AC7B9363F4000000000EFDDF83F06A7E21FE6535E404C8356EBBA363F40000000C069E4F93FF930F59FE7535E40D0D252CFBB363F40000000C0DB98F93F', '2025-06-03 10:28:30.403096', '2025-06-04 11:12:38.806038', 0, 'solid', 'white', 'none', '0', 'border', '["other"]', '0', NULL);
INSERT INTO public.boundary VALUES ('8645924713383591844', 100001, '01020000A0E61000000B0000004095D2E7EE535E409839CAB2C1363F400000008083CCF83FE66DAA7AEE535E40588BAFA1C1363F400000008083CCF83F2C8C4C0EEE535E40A866AFD1C1363F400000004079F5F83F60DC03A6ED535E40E46E5441C2363F40000000006F1EF93FD288FB44ED535E40B0373AEDC2363F40000000E0A4E9F83F435426EEEC535E40C4A727D0C3363F40000000A09A12F93F08AB27A4EC535E400C9A37E3C4363F40000000208664F93F4D1D3F69EC535E40787F0E1EC6363F40000000A09A12F93F1BE2363FEC535E40BC611B77C7363F4000000020B02BF93F28EB5527EC535E40A04CE2E3C8363F4000000000ABCDFA3F7B583324EC535E407444B344C9363F40000000C0C952FA3F', '2025-06-03 10:21:36.808927', '2025-06-03 10:21:36.808927', 99, 'virtual', 'none', 'none', '0', 'virtual', NULL, '0', NULL);
INSERT INTO public.boundary VALUES ('8520688827151417344', 100001, '01020000A0E610000004000000D99D0C93EB535E40B48CE916F5363F40000000207C4BFA3F10DA0391EB535E40B091319FF5363F40000000A090F9F93F272F288FEB535E4034CE152EF6363F40000000402A93FB3FE85BB788EB535E40346CC2CAF7363F40000000E06DFAFA3F', '2025-07-15 14:16:27.489697', '2025-07-15 14:18:41.480996', 0, 'solid', 'white', 'curb', '0', 'driving', '["all_motor_vehicle"]', '0', NULL);


--
-- TOC entry 4501 (class 0 OID 17996)
-- Dependencies: 216
-- Data for Name: connectivity_area; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.connectivity_area VALUES ('8645924713383591892', 100001, '01030000A0E610000001000000270000002689D956E9535E40887A15A7C7363F400000000053CDFA3F284820E9E9535E40381B55FAC7363F4000000040DCA3FA3F9011AE52EA535E40B06B4A38C8363F40000000E04CE1F83F41E793E7EA535E40ACC4238EC8363F40000000C0C952FA3F6D4C0682EB535E40D84B63E6C8363F4000000040DE00FA3FB81D3B24EC535E40349AB544C9363F40000000C0C952FA3F70CAFD8AEC535E40C421F37FC9363F40000000E0CEB0F83FA736031FED535E4060A14BD5C9363F40000000803FEEFA3F04791017ED535E40BC524A93C8363F40000000002B40F73FF359CE40ED535E4024D9288DC6363F40000000000179F73FF5BF3B7DED535E4050F96051C5363F4000000060B997F83FBA94E3E3ED535E40B0DA1413C4363F40000000E033D9F73F6BEA0738EE535E40CC83DD78C3363F40000000203EB0F73FE8FA2780EE535E406C66E830C3363F4000000080525EF73F2F3456E9EE535E40C8959F26C3363F40000000601F2BF83F72C2FBDFEE535E40A058E02BBA363F40000000C070B5F83FA251C667EE535E40FC9959CFB9363F40000000808F3AF83F86C8A216EE535E4054ED9420B9363F4000000000A4E8F73F894387D7ED535E402079683EB8363F40000000C0D974F83F0C33678FED535E4018B88F1EB7363F400000002001EAF93FC47E5465ED535E40541302C1B5363F4000000000A55AF73FC47E5465ED535E4014D51BE8B3363F400000008090ACFB3FB8D2515FED535E4030BD0B2EB2363F4000000040CA4FF83F0E331591EA535E4008F2A7B1B0363F40000000605327FA3FD0D8A697E9535E402C928F40B0363F40000000E09031FD3FBC80A18BE9535E409CF5A3FAB1363F40000000209B08F93F54C8864FE9535E40D43C6BAAB3363F4000000080FD02F93FA25B59E9E8535E4098D81731B5363F40000000E02879F93FEE24E4A0E8535E409CB79EC5B5363F40000000005CACF83FD6DE0863E8535E4054C6C01CB6363F4000000080705AF83F6C1E1D1FE8535E4004FF774CB6363F40000000A047FEF83FA484DFD4E7535E40346A395BB6363F40000000E02C2CF93F7D4FB97DE7535E4064C53E3BBF363F40000000E0E4FEFB3F74F5144DE8535E40BCD071D5BF363F4000000060F948F93FA25B59E9E8535E409C032514C1363F400000008055D8F73F899F782EE9535E4028F55EAFC2363F40000000803856F83FBEFB854CE9535E40A8013CCFC3363F400000008061B2F73F4E3B5D5FE9535E409C18532FC6363F40000000E0F074F93F2689D956E9535E40887A15A7C7363F400000000053CDFA3F', '2025-06-03 09:54:25.779422', '2025-06-03 14:23:58.066576', 0, 'intersection', '0', NULL);


--
-- TOC entry 4502 (class 0 OID 18004)
-- Dependencies: 217
-- Data for Name: connectivity_area_ref; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.connectivity_area_ref VALUES ('8645924713383591861', '8645924713383591862', '1005', '2025-06-03 10:04:19.053446', '2025-06-03 10:04:19.053446', '8645924713383591892', 0, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645924713383591859', '8645924713383591860', '1004', '2025-06-03 10:04:19.387977', '2025-06-03 10:04:19.387977', '8645924713383591892', 0, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271331', '8645924713383591832', '1008', '2025-06-03 14:27:31.295509', '2025-06-03 14:27:31.295509', '8645924713383591892', 0, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271330', '8645924713383591809', '1008', '2025-06-03 14:27:31.430326', '2025-06-03 14:27:31.430326', '8645924713383591892', 0, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271329', '8645782395347271668', '1008', '2025-06-03 14:27:31.566091', '2025-06-03 14:27:31.566091', '8645924713383591892', 0, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271328', '8645924713383591797', '1008', '2025-06-03 14:27:31.700736', '2025-06-03 14:27:31.700736', '8645924713383591892', 0, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271327', '8645924713383591794', '1008', '2025-06-03 14:27:31.83421', '2025-06-03 14:27:31.83421', '8645924713383591892', 0, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271326', '8645782395347271654', '1008', '2025-06-03 14:27:31.969294', '2025-06-03 14:27:31.969294', '8645924713383591892', 0, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271325', '8645782395347271651', '1008', '2025-06-03 14:27:32.103206', '2025-06-03 14:27:32.103206', '8645924713383591892', 0, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271555', '8645782395347271570', '1004', '2025-06-03 14:20:51.929767', '2025-06-03 14:20:51.929767', '8645924713383591892', 0, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271544', '8645782395347271569', '1004', '2025-06-03 14:20:53.464784', '2025-06-03 14:20:53.464784', '8645924713383591892', 0, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271324', '8645782395347271632', '1008', '2025-06-03 14:27:32.236674', '2025-06-03 14:27:32.236674', '8645924713383591892', 0, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271323', '8645782395347271628', '1008', '2025-06-03 14:27:32.371393', '2025-06-03 14:27:32.371393', '8645924713383591892', 0, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271322', '8645782395347271611', '1008', '2025-06-03 14:27:32.506634', '2025-06-03 14:27:32.506634', '8645924713383591892', 0, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645924713383591886', '8645924713383591900', '1004', '2025-06-03 09:54:26.643375', '2025-06-03 09:54:26.643375', '8645924713383591892', 0, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645924713383591885', '8645924713383591893', '1005', '2025-06-03 09:54:26.814918', '2025-06-03 09:54:26.814918', '8645924713383591892', 0, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271517', '8645782395347271531', '1005', '2025-06-03 14:23:02.265973', '2025-06-03 14:23:02.265973', '8645924713383591892', 0, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271504', '8645782395347271530', '1005', '2025-06-03 14:23:04.020895', '2025-06-03 14:23:04.020895', '8645924713383591892', 0, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645924713383591889', '8645924713383591920', '1008', '2025-06-03 09:54:26.173089', '2025-06-03 14:25:39.852862', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645924713383591888', '8645924713383591913', '1008', '2025-06-03 09:54:26.300294', '2025-06-03 14:25:40.452037', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645924713383591887', '8645924713383591904', '1002', '2025-06-03 09:54:26.471836', '2025-06-03 14:25:41.046434', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271321', '8645782395347271606', '1008', '2025-06-03 14:27:32.639552', '2025-06-03 14:27:32.639552', '8645924713383591892', 0, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271320', '8645782395347271601', '1008', '2025-06-03 14:27:32.77391', '2025-06-03 14:27:32.77391', '8645924713383591892', 0, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271318', '8645782395347271589', '1008', '2025-06-03 14:27:33.039722', '2025-06-03 14:27:33.039722', '8645924713383591892', 0, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271317', '8645782395347271580', '1008', '2025-06-03 14:27:33.172711', '2025-06-03 14:27:33.172711', '8645924713383591892', 0, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271316', '8645782395347271577', '1008', '2025-06-03 14:27:33.30812', '2025-06-03 14:27:33.30812', '8645924713383591892', 0, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645924713383591891', '8645924713383591928', '1008', '2025-06-03 09:54:25.914103', '2025-06-03 14:43:46.100108', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645924713383591890', '8645924713383591923', '1008', '2025-06-03 09:54:26.045431', '2025-06-03 14:44:15.920157', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271308', '8645782395347271648', '1002', '2025-06-03 14:27:34.424351', '2025-06-03 17:18:46.452064', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271299', '8645782395347271593', '1002', '2025-06-03 14:27:35.626173', '2025-06-03 17:20:38.555614', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271319', '8645782395347271598', '1008', '2025-06-03 14:27:32.906581', '2025-06-03 17:46:16.183605', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271312', '8645924713383591829', '1002', '2025-06-03 14:27:33.887992', '2025-06-03 14:40:02.233193', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271315', '8645782395347271671', '1002', '2025-06-03 14:27:33.487941', '2025-06-03 17:20:39.146225', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271309', '8645782395347271672', '1002', '2025-06-03 14:27:34.289166', '2025-06-03 17:20:39.737597', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271305', '8645782395347271642', '1002', '2025-06-03 14:27:34.826348', '2025-06-03 17:20:40.340462', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271307', '8645782395347271665', '1002', '2025-06-03 14:27:34.558095', '2025-06-03 17:20:40.929668', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271301', '8645782395347271586', '1002', '2025-06-03 14:27:35.359581', '2025-06-03 17:20:41.518918', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271296', '8645782395347271623', '1002', '2025-06-03 14:27:36.025796', '2025-06-03 17:20:42.108635', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271297', '8645782395347271625', '1002', '2025-06-03 14:27:35.89302', '2025-06-03 17:20:42.696751', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271303', '8645782395347271622', '1002', '2025-06-03 14:27:35.094074', '2025-06-03 17:20:43.287603', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271302', '8645782395347271608', '1002', '2025-06-03 14:27:35.226813', '2025-06-03 17:20:43.875863', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271295', '8645782395347271603', '1002', '2025-06-03 14:27:36.158348', '2025-06-03 17:20:44.460387', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271314', '8645924713383591825', '1002', '2025-06-03 14:27:33.620914', '2025-06-03 17:20:45.046441', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271304', '8645924713383591828', '1002', '2025-06-03 14:27:34.960064', '2025-06-03 17:20:45.636151', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271313', '8645924713383591823', '1002', '2025-06-03 14:27:33.754704', '2025-06-03 17:20:46.223657', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271300', '8645782395347271595', '1002', '2025-06-03 14:27:35.491291', '2025-06-03 17:20:46.812119', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271294', '8645782395347271572', '1002', '2025-06-03 14:27:36.291828', '2025-06-03 17:20:47.40024', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271298', '8645782395347271574', '1002', '2025-06-03 14:27:35.760598', '2025-06-03 17:20:47.986318', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271310', '8645782395347271676', '1002', '2025-06-03 14:27:34.156099', '2025-06-03 17:20:48.572559', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271311', '8645782395347271680', '1002', '2025-06-03 14:27:34.022172', '2025-06-03 17:20:49.15994', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271306', '8645782395347271644', '1002', '2025-06-03 14:27:34.691709', '2025-06-03 17:20:49.745434', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271333', '8645924713383591841', '1008', '2025-06-03 14:27:31.024179', '2025-06-03 17:46:14.327109', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271334', '8645782395347271657', '1008', '2025-06-03 14:27:30.800437', '2025-06-03 17:46:14.951149', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8645782395347271332', '8645924713383591835', '1008', '2025-06-03 14:27:31.159741', '2025-06-03 17:46:15.568951', '8645924713383591892', 99, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8552983717042192378', '80174', '1006', '2025-07-04 17:12:50.959844', '2025-07-04 17:12:50.959844', '8645924713383591892', 0, 0, 100001);
INSERT INTO public.connectivity_area_ref VALUES ('8553036184362679990', '80191', '1007', '2025-07-04 16:49:23.526609', '2025-07-04 17:05:36.888069', '8645924713383591892', 99, 0, NULL);
INSERT INTO public.connectivity_area_ref VALUES ('8553705065389490175', '80192', '1010', '2025-07-04 11:17:21.876377', '2025-07-04 17:08:57.420595', '8645924713383591892', 99, 0, NULL);


--
-- TOC entry 4503 (class 0 OID 18009)
-- Dependencies: 218
-- Data for Name: feature_flag; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4504 (class 0 OID 18015)
-- Dependencies: 219
-- Data for Name: feature_operate_info; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4505 (class 0 OID 18021)
-- Dependencies: 220
-- Data for Name: lane; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.lane VALUES ('8645275692285558754', 100001, '01020000A0E610000006000000F9A0B8FAE9535E40341C183EF7363F40000000C0EB9EF73F3661F811EA535E40B4BD2CD9F0363F40000000009246F83FB0C08F1EEA535E403F018B31ED363F4000000020966AF83FD03C5D36EA535E40D83D9865E6363F40000000E0C22CF83F05E13A61EA535E4090574DFBD9363F40000000C0399CF83FFBC65165EA535E406DB11ACCD8363F40000000802FC5F83F', '2025-06-03 15:52:26.249789', '2025-06-03 15:52:26.249789', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645275692285558772', '8645275692285558773', 2, 1);
INSERT INTO public.lane VALUES ('8645275692285558746', 100001, '01020000A0E610000004000000A22B20D3EB535E4004738C15C9363F40000000801134F93F9035A9BCEB535E40968224A2CE363F4000000060E101F93F31601A9DEB535E40D3CABFC1D7363F40000000605A8DF83F18F0CF98EB535E40D82935FFD8363F40000000A06464F83F', '2025-06-03 15:52:26.831156', '2025-06-03 15:52:26.831156', 'driving', NULL, 0, 'generate', 99, '0', '8645782395347271282', '8645782395347271280', 1, 1);
INSERT INTO public.lane VALUES ('8645275692285558748', 100001, '01020000A0E610000005000000FBC65165EA535E406DB11ACCD8363F40000000802FC5F83F4C982E99EA535E400A403990C9363F40000000002485F93FEF8F5F8EEA535E409137BECBCC363F4000000040F573F93F4C982E99EA535E400A403990C9363F40000000002485F93F69FC209DEA535E40ED3D3963C8363F40000000C019AEF93F', '2025-06-03 15:52:27.992131', '2025-06-03 15:52:27.992131', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271285', '8645782395347271291', 2, 1);
INSERT INTO public.lane VALUES ('8642875801999507332', 100001, '01020000A0E610000005000000E4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F52BDB630EB535E40B64625F1C9363F4000000000D429FA3F58C2A526EB535E40566526EBCC363F40000000A09920FA3F52BDB630EB535E40B64625F1C9363F4000000000D429FA3F28B6CE34EB535E40408843BAC8363F4000000080BF7BFA3F', '2025-06-04 10:47:21.475318', '2025-06-04 10:47:21.475318', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271283', '8645782395347271285', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507349', 100001, '01020000A0E6100000150000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F908E8212EC535E4021E04854B3363F4000000020DB16FA3F6512B61EEC535E40036CD5E8B4363F40000000E04434FA3FF592C920EC535E402C6ADC0DB5363F40000000204F0BFA3FB4CBB73EEC535E40F6378C75B6363F400000002001EAF93F66F67E45EC535E40BA6C88B2B6363F40000000C0EC3BFA3FA8D59772EC535E4007E064F0B7363F400000002001EAF93FDD14707EEC535E409C325334B8363F40000000E0F612FA3FA97CD7B9EC535E40BFA7284DB9363F40000000E014B3F93F5938E6C8EC535E409BDAD588B9363F4000000020F62DFA3F79880713ED535E40004EB07EBA363F40000000A00ADCF93F81740A22ED535E40068B90A8BA363F40000000A00ADCF93F4C92BE7BED535E4011996678BB363F40000000602961F93F3CB70387ED535E407C0AED8DBB363F40000000602961F93F1AA4B0F0ED535E40A0B4B92FBC363F40000000005230F93F6B57F0F4ED535E40A07DC634BC363F40000000005230F93F2B35D1A0EE535E4064A696A8BC363F40000000405C07F93F341DF568EE535E40C35D8898BC363F400000008066DEF83F9CE13B6EEE535E4046656F9BBC363F40000000405C07F93F2B35D1A0EE535E4064A696A8BC363F40000000405C07F93FE25B3CE2EE535E40708D3FB9BC363F400000008066DEF83F', '2025-06-04 10:47:23.223093', '2025-06-04 10:47:23.223093', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271614', '8645782395347271615', 1, 1);
INSERT INTO public.lane VALUES ('8645275692285558724', 100001, '01020000A0E61000000600000018F0CF98EB535E40D82935FFD8363F40000000A06464F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73F33AD8255EB535E40049892E2EC363F40000000807640F83F062D0352EB535E40E5FAA4FEED363F40000000E09D11F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73FE8E1FC34EB535E408783C18BF7363F400000008030F0F73F', '2025-06-03 16:22:38.660343', '2025-06-03 16:22:38.660343', 'driving', NULL, 0, 'generate', 99, '0', '8645782395347271281', '8645782395347271279', 1, 1);
INSERT INTO public.lane VALUES ('8645275692285558717', 100001, '01020000A0E610000004000000A22B20D3EB535E4004738C15C9363F40000000801134F93F9035A9BCEB535E40968224A2CE363F4000000060E101F93F31601A9DEB535E40D3CABFC1D7363F40000000605A8DF83F18F0CF98EB535E40D82935FFD8363F40000000A06464F83F', '2025-06-03 16:22:39.289345', '2025-06-03 16:22:39.289345', 'driving', NULL, 0, 'generate', 99, '0', '8645782395347271282', '8645782395347271280', 1, 1);
INSERT INTO public.lane VALUES ('8645275692285558721', 100001, '01020000A0E610000005000000FBC65165EA535E406DB11ACCD8363F40000000802FC5F83F4C982E99EA535E400A403990C9363F40000000002485F93FEF8F5F8EEA535E409137BECBCC363F4000000040F573F93F4C982E99EA535E400A403990C9363F40000000002485F93F69FC209DEA535E40ED3D3963C8363F40000000C019AEF93F', '2025-06-03 16:03:44.274315', '2025-06-03 16:03:44.274315', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271285', '8645782395347271291', 2, 1);
INSERT INTO public.lane VALUES ('8642875801999507361', 100001, '01020000A0E610000003000000EFCB6143EC535E404033DE0FA5363F40000000A0E94FFA3FC18E971FEC535E40057B3250B0363F4000000020DB16FA3F3E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F', '2025-06-04 10:47:23.801147', '2025-06-04 10:47:23.801147', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271639', '8645782395347271637', 2, 1);
INSERT INTO public.lane VALUES ('8644989441305214912', 100001, '01020000A0E61000000300000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93F30FE46D3EA535E40E0A8A551B2363F4000000020DB16FA3F921E5BD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-03 17:24:33.162673', '2025-06-03 17:24:33.162673', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271581', '8645782395347271582', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507223', 100001, '01020000A0E61000000500000098DD0A96E7535E4082E472C3BC363F40000000C004F5F83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F6065498DE4535E40BE82042ABB363F40000000E05D4BF83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F3AED54B9E3535E40E891CFC3BA363F4000000000183AF83F', '2025-06-04 11:03:22.678907', '2025-06-04 11:03:22.678907', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591816', '8645924713383591818', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271253', 100001, '01020000A0E610000004000000A22B20D3EB535E4004738C15C9363F40000000801134F93F9035A9BCEB535E40968224A2CE363F4000000060E101F93F31601A9DEB535E40D3CABFC1D7363F40000000605A8DF83F18F0CF98EB535E40D82935FFD8363F40000000A06464F83F', '2025-06-03 14:46:52.224321', '2025-06-03 14:46:52.22532', 'driving', NULL, 0, 'generate', 99, '0', '8645782395347271282', '8645782395347271280', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271258', 100001, '01020000A0E610000005000000AB00D5FBEA535E40447D1EE5D8363F40000000A03B08F93FED066C2FEB535E402EEC52EBC9363F4000000000D429FA3F45A54625EB535E40A361DDEACC363F40000000A09920FA3FED066C2FEB535E402EEC52EBC9363F4000000000D429FA3FD7BE7133EB535E407CBFE0B9C8363F4000000080BF7BFA3F', '2025-06-03 14:46:52.810591', '2025-06-03 14:46:52.810591', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271283', '8645782395347271285', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271257', 100001, '01020000A0E610000005000000FBC65165EA535E406DB11ACCD8363F40000000802FC5F83F4C982E99EA535E400A403990C9363F40000000002485F93FEF8F5F8EEA535E409137BECBCC363F4000000040F573F93F4C982E99EA535E400A403990C9363F40000000002485F93F69FC209DEA535E40ED3D3963C8363F40000000C019AEF93F', '2025-06-03 14:46:53.402506', '2025-06-03 14:46:53.402506', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271285', '8645782395347271291', 2, 1);
INSERT INTO public.lane VALUES ('8645782395347271236', 100001, '01020000A0E610000005000000FBC65165EA535E406DB11ACCD8363F40000000802FC5F83F4C982E99EA535E400A403990C9363F40000000002485F93FEF8F5F8EEA535E409137BECBCC363F4000000040F573F93F4C982E99EA535E400A403990C9363F40000000002485F93F69FC209DEA535E40ED3D3963C8363F40000000C019AEF93F', '2025-06-03 15:00:25.218123', '2025-06-03 15:00:25.218123', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271285', '8645782395347271291', 2, 1);
INSERT INTO public.lane VALUES ('8645782395347271241', 100001, '01020000A0E610000005000000AB00D5FBEA535E40447D1EE5D8363F40000000A03B08F93FED066C2FEB535E402EEC52EBC9363F4000000000D429FA3F45A54625EB535E40A361DDEACC363F40000000A09920FA3FED066C2FEB535E402EEC52EBC9363F4000000000D429FA3FD7BE7133EB535E407CBFE0B9C8363F4000000080BF7BFA3F', '2025-06-03 15:52:27.412357', '2025-06-03 15:52:27.412357', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271283', '8645782395347271285', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271263', 100001, '01020000A0E610000006000000F9A0B8FAE9535E40341C183EF7363F40000000C0EB9EF73F3661F811EA535E40B4BD2CD9F0363F40000000009246F83FB0C08F1EEA535E403F018B31ED363F4000000020966AF83FD03C5D36EA535E40D83D9865E6363F40000000E0C22CF83F05E13A61EA535E4090574DFBD9363F40000000C0399CF83FFBC65165EA535E406DB11ACCD8363F40000000802FC5F83F', '2025-06-03 14:46:49.269116', '2025-06-03 14:46:49.269116', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271286', '8645782395347271292', 2, 1);
INSERT INTO public.lane VALUES ('8645782395347271264', 100001, '01020000A0E61000000600000044447194EA535E40DB050E5EF7363F4000000040D7F0F73FB25858AAEA535E407361B6FAF0363F400000000069EAF83F83DBB9B4EA535E401B49F4C5ED363F400000000069EAF83F518D3EB6EA535E408192A751ED363F40000000206D0EF93F06BAD5F7EA535E40BA9CBC0FDA363F40000000603131F93FAB00D5FBEA535E40447D1EE5D8363F40000000A03B08F93F', '2025-06-03 14:46:50.446488', '2025-06-03 14:46:50.446488', 'driving', NULL, 0, 'generate', 99, '0', '8645782395347271284', '8645782395347271286', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271260', 100001, '01020000A0E61000000600000018F0CF98EB535E40D82935FFD8363F40000000A06464F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73F33AD8255EB535E40049892E2EC363F40000000807640F83F062D0352EB535E40E5FAA4FEED363F40000000E09D11F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73FE8E1FC34EB535E408783C18BF7363F400000008030F0F73F', '2025-06-03 14:46:51.633692', '2025-06-03 14:46:51.633692', 'driving', NULL, 0, 'generate', 99, '0', '8645782395347271281', '8645782395347271279', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507215', 100001, '01020000A0E6100000030000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F359A57D3E7535E406AFA7FE4BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 11:03:23.282406', '2025-06-04 11:03:23.282406', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271662', '8645782395347271663', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507211', 100001, '01020000A0E61000000300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F036CDAA1EE535E40114D1596BC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 11:03:23.882116', '2025-06-04 11:03:23.882116', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271659', '8645782395347271658', 1, 1);
INSERT INTO public.lane VALUES ('8645275692285558784', 100001, '01020000A0E610000005000000FBC65165EA535E406DB11ACCD8363F40000000802FC5F83F4C982E99EA535E400A403990C9363F40000000002485F93FEF8F5F8EEA535E409137BECBCC363F4000000040F573F93F4C982E99EA535E400A403990C9363F40000000002485F93F69FC209DEA535E40ED3D3963C8363F40000000C019AEF93F', '2025-06-03 15:48:15.060496', '2025-06-03 15:48:15.060496', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271285', '8645782395347271291', 2, 1);
INSERT INTO public.lane VALUES ('8645782395347271250', 100001, '01020000A0E61000000600000018F0CF98EB535E40D82935FFD8363F40000000A06464F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73F33AD8255EB535E40049892E2EC363F40000000807640F83F062D0352EB535E40E5FAA4FEED363F40000000E09D11F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73FE8E1FC34EB535E408783C18BF7363F400000008030F0F73F', '2025-06-03 15:48:15.641828', '2025-06-03 15:48:15.641828', 'driving', NULL, 0, 'generate', 99, '0', '8645782395347271281', '8645782395347271279', 1, 1);
INSERT INTO public.lane VALUES ('8645275692285558722', 100001, '01020000A0E610000005000000AB00D5FBEA535E40447D1EE5D8363F40000000A03B08F93FED066C2FEB535E402EEC52EBC9363F4000000000D429FA3F45A54625EB535E40A361DDEACC363F40000000A09920FA3FED066C2FEB535E402EEC52EBC9363F4000000000D429FA3FD7BE7133EB535E407CBFE0B9C8363F4000000080BF7BFA3F', '2025-06-03 16:22:40.539998', '2025-06-03 16:22:40.539998', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271283', '8645782395347271285', 1, 1);
INSERT INTO public.lane VALUES ('8645275692285558728', 100001, '01020000A0E61000000600000044447194EA535E40DB050E5EF7363F4000000040D7F0F73FB25858AAEA535E407361B6FAF0363F400000000069EAF83F83DBB9B4EA535E401B49F4C5ED363F400000000069EAF83F518D3EB6EA535E408192A751ED363F40000000206D0EF93F06BAD5F7EA535E40BA9CBC0FDA363F40000000603131F93FAB00D5FBEA535E40447D1EE5D8363F40000000A03B08F93F', '2025-06-03 16:22:39.914736', '2025-06-03 16:22:39.914736', 'driving', 'null', 0, 'generate', 99, '0', '8645782395347271284', '8645275692285558772', 1, 1);
INSERT INTO public.lane VALUES ('8645275692285558727', 100001, '01020000A0E610000006000000F9A0B8FAE9535E40341C183EF7363F40000000C0EB9EF73F3661F811EA535E40B4BD2CD9F0363F40000000009246F83FB0C08F1EEA535E403F018B31ED363F4000000020966AF83FD03C5D36EA535E40D83D9865E6363F40000000E0C22CF83F05E13A61EA535E4090574DFBD9363F40000000C0399CF83FFBC65165EA535E406DB11ACCD8363F40000000802FC5F83F', '2025-06-03 16:22:41.164817', '2025-06-03 16:22:41.164817', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645275692285558772', '8645275692285558773', 2, 1);
INSERT INTO public.lane VALUES ('8645275692285558714', 100001, '01020000A0E610000005000000FBC65165EA535E406DB11ACCD8363F40000000802FC5F83F4C982E99EA535E400A403990C9363F40000000002485F93FEF8F5F8EEA535E409137BECBCC363F4000000040F573F93F4C982E99EA535E400A403990C9363F40000000002485F93F69FC209DEA535E40ED3D3963C8363F40000000C019AEF93F', '2025-06-03 16:22:41.793327', '2025-06-03 16:22:41.793327', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271285', '8645782395347271291', 2, 1);
INSERT INTO public.lane VALUES ('8642875801999507143', 100001, '01020000A0E61000000500000098DD0A96E7535E4082E472C3BC363F40000000C004F5F83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F6065498DE4535E40BE82042ABB363F40000000E05D4BF83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F3AED54B9E3535E40E891CFC3BA363F4000000000183AF83F', '2025-06-04 11:30:21.723878', '2025-06-04 11:30:21.723878', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591816', '8645924713383591818', 1, 1);
INSERT INTO public.lane VALUES ('8645275692285558750', 100001, '01020000A0E61000000600000018F0CF98EB535E40D82935FFD8363F40000000A06464F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73F33AD8255EB535E40049892E2EC363F40000000807640F83F062D0352EB535E40E5FAA4FEED363F40000000E09D11F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73FE8E1FC34EB535E408783C18BF7363F400000008030F0F73F', '2025-06-03 15:52:24.502927', '2025-06-03 15:52:24.502927', 'driving', NULL, 0, 'generate', 99, '0', '8645782395347271281', '8645782395347271279', 1, 1);
INSERT INTO public.lane VALUES ('8645924713383591904', 100001, '01020000A0E6100000040000001CF7FFD4EC535E40D43B9DAAC9363F40000000C02069F73F75B2E3A5EC535E404A7781D9D7363F40000000405D79F63FC0F9C83EEC535E40A631229DF6363F40000000800422FC3FB4601C3BEC535E4040C4EAB5F7363F40000000A0586EF93F', '2025-06-03 14:25:40.961517', '2025-06-03 14:25:40.961517', 'virtual', '[all_motor_vehicle]', 0, 'generate', 99, '0', '8645924713383591935', '8645924713383591934', 1, 1);
INSERT INTO public.lane VALUES ('8645924713383591902', 100001, '01020000A0E61000000400000003F71300E9535E407C56FF0BF7363F40000000000410F63F69884651E9535E40DCD611E5DD363F40000000C03DCFF63FD97DAB9BE9535E40CFE26C0AC9363F40000000A06B66F83F0016DB9FE9535E403A7F5CE0C7363F40000000A06B66F83F', '2025-06-03 14:25:41.551694', '2025-06-03 14:25:41.551694', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591914', '8645924713383591929', 1, 1);
INSERT INTO public.lane VALUES ('8645924713383591909', 100001, '01020000A0E610000008000000F9A0B8FAE9535E40341C183EF7363F40000000C0EB9EF73FB0C08F1EEA535E403F018B31ED363F4000000020966AF83FD03C5D36EA535E40D83D9865E6363F40000000E0C22CF83F60E8376AEA535E403989ED60D7363F40000000802FC5F83F4C982E99EA535E400A403990C9363F40000000002485F93FEF8F5F8EEA535E409137BECBCC363F4000000040F573F93F4C982E99EA535E400A403990C9363F40000000002485F93F69FC209DEA535E40ED3D3963C8363F40000000C019AEF93F', '2025-06-03 14:46:48.671072', '2025-06-03 14:46:48.671072', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591932', '8645924713383591933', 2, 1);
INSERT INTO public.lane VALUES ('8645924713383591910', 100001, '01020000A0E61000000900000044447194EA535E40DB050E5EF7363F4000000040D7F0F73F83DBB9B4EA535E401B49F4C5ED363F400000000069EAF83F518D3EB6EA535E408192A751ED363F40000000206D0EF93F2469E3FAEA535E40C1D15B2AD9363F40000000A03B08F93F4965B000EB535E406EECF880D7363F40000000A03B08F93FED066C2FEB535E402EEC52EBC9363F4000000000D429FA3F45A54625EB535E40A361DDEACC363F40000000A09920FA3FED066C2FEB535E402EEC52EBC9363F4000000000D429FA3FD7BE7133EB535E407CBFE0B9C8363F4000000080BF7BFA3F', '2025-06-03 14:46:49.85811', '2025-06-03 14:46:49.85811', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591931', '8645924713383591932', 1, 1);
INSERT INTO public.lane VALUES ('8645924713383591906', 100001, '01020000A0E6100000080000004CF5FFD2EB535E40F8E3BE21C9363F40000000801134F93F04D37097EB535E40437CCF64D9363F40000000A06464F83FD9D4FF8DEB535E401293E930DC363F40000000C08893F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73F33AD8255EB535E40049892E2EC363F40000000807640F83F062D0352EB535E40E5FAA4FEED363F40000000E09D11F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73FE8E1FC34EB535E408783C18BF7363F400000008030F0F73F', '2025-06-03 14:46:51.035653', '2025-06-03 14:46:51.035653', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591924', '8645924713383591936', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507390', 100001, '01020000A0E6100000030000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F864C1DD7EB535E4011E9A5CCC7363F4000000000FD85F93FE1051ED3EB535E4081278815C9363F40000000801134F93F', '2025-06-04 10:39:18.374262', '2025-06-04 10:39:18.374262', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271613', '8645782395347271612', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507419', 100001, '01020000A0E61000000300000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93F30FE46D3EA535E40E0A8A551B2363F4000000020DB16FA3F921E5BD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 10:39:18.984824', '2025-06-04 10:39:18.984824', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271581', '8645782395347271582', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507424', 100001, '01020000A0E6100000110000005C29BAE4EE535E40E6B320BABE363F40000000803114FA3FF48E8D1FEE535E405D7ED048BE363F4000000040273DFA3F35C12168ED535E4034801A6BBD363F4000000060D7A8FA3FC291AA67ED535E4034D1616ABD363F4000000060D7A8FA3F661FF9BDEC535E40F3F97C22BC363F4000000020CDD1FA3F6FEEC6BAEC535E403B89F41ABC363F4000000020CDD1FA3F5229FF25EC535E40DC9CFE77BA363F40000000C0260FFB3F89078522EC535E403B6E446CBA363F400000000031E6FA3F7DE7ECA4EB535E4096D0F075B8363F4000000020FD52FB3F3A1249A3EB535E40A279126EB8363F4000000020FD52FB3F2D438E40EB535E405B4E9531B6363F40000000A01101FB3FDA515D3FEB535E4073760F29B6363F40000000A01101FB3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3F915FC3FCEA535E40FD13F4C8B3363F4000000020B2BAFA3F4004C9F9EA535E40924747A4B3363F4000000060BC91FA3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 10:39:19.597606', '2025-06-04 10:39:19.597606', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271590', '8645782395347271591', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507384', 100001, '01020000A0E61000001800000047DB93E8EE535E40730DB76CC2363F40000000601F2BF83F4DB70866EE535E40D2818998C2363F40000000601F2BF83F6AE30936EE535E40903F67BEC2363F40000000201554F83FBDA3DD20EE535E40D833E4D5C2363F40000000601F2BF83FD24B2CF3ED535E40AE2DFA12C3363F40000000E00A7DF83FC81A3AE5ED535E406D324028C3363F40000000201554F83F180405C7ED535E401F378761C3363F40000000201554F83F54E6119CED535E406C624EBEC3363F4000000060B997F83F1E97C49BED535E4072A80FBFC3363F4000000060B997F83F326CBD74ED535E40A2110932C4363F40000000E0A4E9F83F51CAED5CED535E40079C3D81C4363F40000000E0A4E9F83FD4C7F54FED535E400CBC7EB4C4363F4000000020AFC0F83F991E292FED535E407D582346C5363F4000000060B997F83F5D6FC629ED535E40189C4260C5363F4000000060B997F83F144DCD09ED535E40D6DA751BC6363F4000000000D81CF83F917CD901ED535E40BE65FD4FC6363F4000000000D81CF83F70208CEEEC535E403BDC20F0C6363F4000000040E2F3F73FF28E5BE5EC535E40EDB0084CC7363F400000000002E4F73FEE6C37DDEC535E4088FCB9BCC7363F400000000002E4F73F282511D5EC535E40CFE2BD51C8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F4B51D3D3EC535E40E742297DC8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F5AD1FDD4EC535E40D43B9DAAC9363F40000000C02069F73F', '2025-06-04 10:47:24.379345', '2025-06-04 10:47:24.379345', 'virtual', '["non_motor_vehicle","walker"]', 0, 'generate', 99, '0', '8645924713383591843', '8645924713383591842', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271676', 100001, '01020000A0E610000004000000E25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83FC359A750F1535E40CEE61D19BE363F40000000608330F83FBE6DFC42F5535E407A502051C0363F4000000040500BF73F0AE9A281F5535E40E5BE5B74C0363F40000000001DD8F73F', '2025-06-03 17:20:48.488815', '2025-06-03 17:20:48.488815', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591798', '8645924713383591800', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271674', 100001, '01020000A0E610000005000000331DE184E7535E40C8DFE169BE363F4000000020EFD5F73FF81819D5E3535E40D586A97EBC363F400000006072F9F73FD491DF7FE4535E40F92599D7BC363F40000000206822F83FF81819D5E3535E40D586A97EBC363F400000006072F9F73FE5049BAAE3535E407C2B8468BC363F40000000402211F83F', '2025-06-03 11:17:10.674779', '2025-06-03 11:17:10.675931', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591818', '8645924713383591817', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271648', 100001, '01020000A0E610000015000000C2227AAAE7535E40594C62CCBA363F4000000000BD13FA3F3314AF66E8535E4065ABD0E2BA363F40000000A02D35FA3FDC0073FAE8535E4017B46047BB363F4000000060235EFA3FA58A3D0FE9535E40FF2A2A5CBB363F4000000060235EFA3F59EF5BA0E9535E40CFA63C1DBC363F40000000A07285FA3F8E3B5EAEE9535E40BD70F134BC363F40000000A07285FA3F5A84D939EA535E40752A8D56BD363F40000000A07285FA3FA7F8553FEA535E4087EC5B64BD363F400000006068AEFA3FF63ED9BDEA535E401B8FF1DFBE363F400000006036C1FA3F20CBB0C1EA535E40A46EB3EDBE363F400000006036C1FA3FA0275426EB535E40F7BEB19AC0363F4000000060B307FB3FF7F68B32EB535E40622757D9C0363F40000000A0BDDEFA3FFF78F176EB535E400267E283C2363F4000000040C3F7FA3FFA430D88EB535E40D8BC1C09C3363F4000000080CDCEFA3F743F9DAEEB535E40305CBD8DC4363F40000000C0D7A5FA3F95304FBEEB535E407DD77C69C5363F4000000040EC53FA3F710142CDEB535E404114BAB5C6363F40000000C00002FA3F645E4CD5EB535E405E4619C0C7363F4000000000FD85F93F0CD0E6D3EB535E40A09CF9B9C7363F4000000000FD85F93F645E4CD5EB535E405E4619C0C7363F4000000000FD85F93FD7BE7133EB535E407CBFE0B9C8363F4000000080BF7BFA3F', '2025-06-03 17:18:46.367292', '2025-06-03 17:18:46.367292', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271661', '8645782395347271660', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271672', 100001, '01020000A0E610000005000000932E26CBE3535E408A32ACC6B8363F40000000E034EFF83FDC552EA5E5535E40C594BFB0B9363F40000000808869F93F2F533A28E6535E40CB0F27F3B9363F40000000805F0DFA3F35CC036AE7535E40BE7629A8BA363F4000000040C7EAF93FC2227AAAE7535E40594C62CCBA363F4000000000BD13FA3F', '2025-06-03 17:20:39.652964', '2025-06-03 17:20:39.652964', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591815', '8645924713383591814', 1, 1);
INSERT INTO public.lane VALUES ('8645924713383591825', 100001, '01020000A0E6100000140000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F34611266EE535E40CD9D759AC0363F40000000805A70F93F20F45001EE535E401A1986BDC0363F40000000405099F93FF3D48DF1ED535E4044CCDBC7C0363F40000000805A70F93FB5F5488DED535E4097A8FF28C1363F40000000A0A7FAF93F8453A581ED535E409D9A2E38C1363F4000000020BCA8F93F7633A31FED535E40850D5EDAC1363F4000000040C67FF93F0DC6CF19ED535E4049C64BE6C1363F4000000040C67FF93F6E011DBDEC535E40E42023CBC2363F40000000E07B8DF93F6CA9D7BBEC535E40FCE7E0CEC2363F40000000E07B8DF93FE59B6D6EEC535E4054785BDFC3363F40000000205D08FA3FD73FE065EC535E40B9FE4603C4363F40000000205D08FA3F72F3322FEC535E409B2DB116C5363F400000004015B0F93F9C680121EC535E40E8E0B26DC5363F40000000801F87F93F287C3F00EC535E40D6A13567C6363F40000000801F87F93F592479F0EB535E406BAB6E02C7363F40000000801F87F93FB43E36E0EB535E4011DC7BCAC7363F4000000040075DF93F150705E2EB535E40761A01C6C7363F4000000040075DF93FB43E36E0EB535E4011DC7BCAC7363F4000000040075DF93FE1051ED3EB535E4081278815C9363F40000000801134F93F', '2025-06-03 17:20:44.962964', '2025-06-03 17:20:44.962964', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591836', '8645924713383591853', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507376', 100001, '01020000A0E610000004000000E25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83FC359A750F1535E40CEE61D19BE363F40000000608330F83FBE6DFC42F5535E407A502051C0363F4000000040500BF73F0AE9A281F5535E40E5BE5B74C0363F40000000001DD8F73F', '2025-06-04 10:47:24.957765', '2025-06-04 10:47:24.957765', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591798', '8645924713383591800', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507374', 100001, '01020000A0E610000006000000E647666FF5535E405BB4DF5EC2363F40000000C066EBF73F7AE31B3FF1535E409852C20CC0363F40000000605AD4F83F58054923EF535E4063E775DDBE363F40000000002F01FA3F229B589EEF535E408CA8F322BF363F4000000000585DF93F58054923EF535E4063E775DDBE363F40000000002F01FA3F5C29BAE4EE535E40E6B320BABE363F40000000803114FA3F', '2025-06-04 10:47:25.545904', '2025-06-04 10:47:25.545904', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591799', '8645924713383591876', 1, 1);
INSERT INTO public.lane VALUES ('8645046787708551144', 100001, '01020000A0E610000005000000FBC65165EA535E406DB11ACCD8363F40000000802FC5F83F4C982E99EA535E400A403990C9363F40000000002485F93FEF8F5F8EEA535E409137BECBCC363F4000000040F573F93F4C982E99EA535E400A403990C9363F40000000002485F93F69FC209DEA535E40ED3D3963C8363F40000000C019AEF93F', '2025-06-03 17:20:50.841359', '2025-06-03 17:20:50.841359', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271285', '8645782395347271291', 2, 1);
INSERT INTO public.lane VALUES ('8642875801999507373', 100001, '01020000A0E610000007000000DFE39D5AF5535E40AD120647C4363F40000000C08F47F73F6CB106E8F1535E40087F9160C2363F40000000809B68F73F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93FB743268DEF535E402091A20DC1363F40000000C076E2F83F11928B85EF535E40A3C25209C1363F400000000081B9F83F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93F4A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F', '2025-06-04 10:47:26.130086', '2025-06-04 10:47:26.130086', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591876', '8645924713383591870', 2, 1);
INSERT INTO public.lane VALUES ('8645046787708551145', 100001, '01020000A0E610000005000000AB00D5FBEA535E40447D1EE5D8363F40000000A03B08F93FED066C2FEB535E402EEC52EBC9363F4000000000D429FA3F45A54625EB535E40A361DDEACC363F40000000A09920FA3FED066C2FEB535E402EEC52EBC9363F4000000000D429FA3FD7BE7133EB535E407CBFE0B9C8363F4000000080BF7BFA3F', '2025-06-03 17:20:51.429941', '2025-06-03 17:20:51.429941', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271283', '8645782395347271285', 1, 1);
INSERT INTO public.lane VALUES ('8645046787708551136', 100001, '01020000A0E610000004000000A22B20D3EB535E4004738C15C9363F40000000801134F93F9035A9BCEB535E40968224A2CE363F4000000060E101F93F31601A9DEB535E40D3CABFC1D7363F40000000605A8DF83F18F0CF98EB535E40D82935FFD8363F40000000A06464F83F', '2025-06-03 17:20:52.016067', '2025-06-03 17:20:52.016067', 'driving', NULL, 0, 'generate', 99, '0', '8645782395347271282', '8645782395347271280', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507382', 100001, '01020000A0E610000005000000932E26CBE3535E408A32ACC6B8363F40000000E034EFF83FDC552EA5E5535E40C594BFB0B9363F40000000808869F93F2F533A28E6535E40CB0F27F3B9363F40000000805F0DFA3F35CC036AE7535E40BE7629A8BA363F4000000040C7EAF93FC2227AAAE7535E40594C62CCBA363F4000000000BD13FA3F', '2025-06-04 10:47:26.714758', '2025-06-04 10:47:26.714758', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591815', '8645924713383591814', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507366', 100001, '01020000A0E61000000300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F036CDAA1EE535E40114D1596BC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 10:47:27.295554', '2025-06-04 10:47:27.295554', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271659', '8645782395347271658', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507343', 100001, '01020000A0E61000001400000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93FDAFD1B95EA535E402A916AF6C5363F4000000040810CFA3F94BC0A8EEA535E40E29AF16CC5363F40000000808BE3F93F636EF973EA535E40B3BF1920C4363F40000000808BE3F93FFC1E9766EA535E40492FF8A1C3363F40000000C095BAF93F7FB7993AEA535E40A3C8465FC2363F40000000C095BAF93FA9708529EA535E404FD2CEF9C1363F40000000E073CBF93F84C401EAE9535E403E1B7FC3C0363F40000000608879F93F472B40D9E9535E404A58077FC0363F40000000A09250F93FC33B4784E9535E405172545CBF363F40000000A09250F93F0AB16A78E9535E402DC7383ABF363F40000000E09C27F93F460D8A0CE9535E409365CD37BE363F4000000060F948F93FC10BCF09E9535E40D46A6632BE363F4000000060F948F93FD24F2990E8535E40D5875670BD363F40000000E06068F93F06138986E8535E4081555364BD363F40000000206B3FF93F79904DDBE7535E40CF7C22DDBC363F40000000C004F5F83FEEEB5D0FE8535E404CCD16F7BC363F40000000607516F93FA7996FF6E7535E40F3986FE7BC363F40000000C004F5F83F79904DDBE7535E40CF7C22DDBC363F40000000C004F5F83FCCB7739EE7535E402E5EDDC5BC363F40000000C004F5F83F', '2025-06-04 10:47:29.057608', '2025-06-04 10:47:29.057608', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271583', '8645782395347271584', 1, 1);
INSERT INTO public.lane VALUES ('8645924713383591829', 100001, '01020000A0E610000014000000D7BE7133EB535E407CBFE0B9C8363F4000000080BF7BFA3F861C0F41EB535E4068A97290C6363F40000000C0D7A5FA3FFC09A363EB535E40B471CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4044FD964FC2363F40000000A0BDDEFA3FC38141E6EB535E40149E247EC1363F40000000E09E59FB3F347AF122EC535E40ECB08A83C0363F4000000060B307FB3FBADA8544EC535E404863350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E4050A8F2D3BE363F40000000206AF0FA3F30C57D2DED535E400C1237E1BD363F400000006074C7FA3FD80C4F33ED535E40844CC9D7BD363F40000000A07E9EFA3FA520C375ED535E4084F2EC6CBD363F4000000060D7A8FA3F3010E2C3ED535E40480A9E27BD363F40000000600A4FFA3FAE919915EE535E401CE474E0BC363F40000000803D82F93F82B6CA49EE535E406C846BBABC363F40000000C04759F93F19B1FC66EE535E4080566FAEBC363F40000000405C07F93F94E0CB83EE535E40F82855A8BC363F40000000405C07F93FE25B3CE2EE535E40E4AA32B9BC363F400000008066DEF83F', '2025-06-03 14:40:02.146757', '2025-06-03 14:40:02.146757', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591856', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271240', 100001, '01020000A0E610000005000000FBC65165EA535E406DB11ACCD8363F40000000802FC5F83F4C982E99EA535E400A403990C9363F40000000002485F93FEF8F5F8EEA535E409137BECBCC363F4000000040F573F93F4C982E99EA535E400A403990C9363F40000000002485F93F69FC209DEA535E40ED3D3963C8363F40000000C019AEF93F', '2025-06-03 15:22:31.63766', '2025-06-03 15:22:31.63766', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271285', '8645782395347271291', 2, 1);
INSERT INTO public.lane VALUES ('8645046787708551150', 100001, '01020000A0E610000006000000F9A0B8FAE9535E40341C183EF7363F40000000C0EB9EF73F3661F811EA535E40B4BD2CD9F0363F40000000009246F83FB0C08F1EEA535E403F018B31ED363F4000000020966AF83FD03C5D36EA535E40D83D9865E6363F40000000E0C22CF83F05E13A61EA535E4090574DFBD9363F40000000C0399CF83FFBC65165EA535E406DB11ACCD8363F40000000802FC5F83F', '2025-06-03 17:20:52.602148', '2025-06-03 17:20:52.602148', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645275692285558705', '8645275692285558706', 2, 1);
INSERT INTO public.lane VALUES ('8645046787708551147', 100001, '01020000A0E61000000600000018F0CF98EB535E40D82935FFD8363F40000000A06464F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73F33AD8255EB535E40049892E2EC363F40000000807640F83F062D0352EB535E40E5FAA4FEED363F40000000E09D11F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73FE8E1FC34EB535E408783C18BF7363F400000008030F0F73F', '2025-06-03 17:20:53.187992', '2025-06-03 17:20:53.187992', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558708', '8645275692285558707', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271646', 100001, '01020000A0E610000014000000D7BE7133EB535E407CBFE0B9C8363F4000000080BF7BFA3F861C0F41EB535E4068A97290C6363F40000000C0D7A5FA3FFC09A363EB535E40B471CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4044FD964FC2363F40000000A0BDDEFA3FC38141E6EB535E40149E247EC1363F40000000E09E59FB3F347AF122EC535E40ECB08A83C0363F4000000060B307FB3FBADA8544EC535E404863350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E4050A8F2D3BE363F40000000206AF0FA3F30C57D2DED535E400C1237E1BD363F400000006074C7FA3FD80C4F33ED535E40844CC9D7BD363F40000000A07E9EFA3FA520C375ED535E4084F2EC6CBD363F4000000060D7A8FA3F068E79C5ED535E40C821313ABD363F40000000200078FA3F49AB963EEE535E40FC15E046BD363F400000004033ABF93FCB68E664EE535E4094799209BD363F40000000005230F93F94E0CB83EE535E40F82855A8BC363F40000000405C07F93FE62D1995EE535E4034579CD2BC363F400000008066DEF83FE25B3CE2EE535E40E4AA32B9BC363F400000008066DEF83F', '2025-06-03 12:10:33.971057', '2025-06-03 12:10:33.972053', 'virtual', 'null', 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271248', 100001, '01020000A0E61000000600000044447194EA535E40DB050E5EF7363F4000000040D7F0F73FB25858AAEA535E407361B6FAF0363F400000000069EAF83F83DBB9B4EA535E401B49F4C5ED363F400000000069EAF83F518D3EB6EA535E408192A751ED363F40000000206D0EF93F06BAD5F7EA535E40BA9CBC0FDA363F40000000603131F93FAB00D5FBEA535E40447D1EE5D8363F40000000A03B08F93F', '2025-06-03 15:52:25.085302', '2025-06-03 15:52:25.085302', 'driving', NULL, 0, 'generate', 99, '0', '8645782395347271284', '8645782395347271286', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271247', 100001, '01020000A0E610000006000000F9A0B8FAE9535E40341C183EF7363F40000000C0EB9EF73F3661F811EA535E40B4BD2CD9F0363F40000000009246F83FB0C08F1EEA535E403F018B31ED363F4000000020966AF83FD03C5D36EA535E40D83D9865E6363F40000000E0C22CF83F05E13A61EA535E4090574DFBD9363F40000000C0399CF83FFBC65165EA535E406DB11ACCD8363F40000000802FC5F83F', '2025-06-03 15:48:14.475313', '2025-06-03 15:48:14.475313', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271286', '8645782395347271292', 2, 1);
INSERT INTO public.lane VALUES ('8642875801999507378', 100001, '01020000A0E61000000500000098DD0A96E7535E4082E472C3BC363F40000000C004F5F83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F6065498DE4535E40BE82042ABB363F40000000E05D4BF83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F3AED54B9E3535E40E891CFC3BA363F4000000000183AF83F', '2025-06-04 10:47:30.238449', '2025-06-04 10:47:30.238449', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591816', '8645924713383591818', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507370', 100001, '01020000A0E6100000030000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F359A57D3E7535E406AFA7FE4BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 10:47:30.822847', '2025-06-04 10:47:30.822847', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271662', '8645782395347271663', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507358', 100001, '01020000A0E610000003000000921E5BD6EA535E40E7F2510CB1363F40000000E0F99BF93F4096E203EB535E4028B1EAFAA5363F40000000600BCFFA3FAEF13109EB535E40D55809B0A4363F40000000C00776FA3F', '2025-06-04 10:47:31.396833', '2025-06-04 10:47:31.396833', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271633', '8645782395347271634', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507362', 100001, '01020000A0E610000003000000183ECCA5EB535E40701ECDDFA4363F4000000080FD9EFA3FF7A3F779EB535E4076AC8C25B0363F4000000020B2BAFA3FF4E64275EB535E40D5BD045DB1363F4000000060BC91FA3F', '2025-06-04 10:47:31.968127', '2025-06-04 10:47:31.968127', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271640', '8645782395347271639', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507341', 100001, '01020000A0E61000000300000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93F30FE46D3EA535E40E0A8A551B2363F4000000020DB16FA3F921E5BD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 10:47:32.541401', '2025-06-04 10:47:32.541401', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271581', '8645782395347271582', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507346', 100001, '01020000A0E6100000110000005C29BAE4EE535E40E6B320BABE363F40000000803114FA3FF48E8D1FEE535E405D7ED048BE363F4000000040273DFA3F35C12168ED535E4034801A6BBD363F4000000060D7A8FA3FC291AA67ED535E4034D1616ABD363F4000000060D7A8FA3F661FF9BDEC535E40F3F97C22BC363F4000000020CDD1FA3F6FEEC6BAEC535E403B89F41ABC363F4000000020CDD1FA3F5229FF25EC535E40DC9CFE77BA363F40000000C0260FFB3F89078522EC535E403B6E446CBA363F400000000031E6FA3F7DE7ECA4EB535E4096D0F075B8363F4000000020FD52FB3F3A1249A3EB535E40A279126EB8363F4000000020FD52FB3F2D438E40EB535E405B4E9531B6363F40000000A01101FB3FDA515D3FEB535E4073760F29B6363F40000000A01101FB3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3F915FC3FCEA535E40FD13F4C8B3363F4000000020B2BAFA3F4004C9F9EA535E40924747A4B3363F4000000060BC91FA3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 10:47:33.115595', '2025-06-04 10:47:33.115595', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271590', '8645782395347271591', 1, 1);
INSERT INTO public.lane VALUES ('8645924713383591828', 100001, '01020000A0E610000014000000D7BE7133EB535E407CBFE0B9C8363F4000000080BF7BFA3F861C0F41EB535E406BA97290C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F676AC375ED535E40F8A6EE6CBD363F4000000060D7A8FA3F6CDBE1C3ED535E407024A027BD363F40000000600A4FFA3FAE919915EE535E401CE474E0BC363F40000000803D82F93F5B36CB49EE535E4040336CBABC363F40000000C04759F93F9674FC66EE535E40704C6DAEBC363F40000000405C07F93FEEFCCB83EE535E40B73956A8BC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-03 17:20:45.553595', '2025-06-03 17:20:45.553595', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591846', '8645924713383591847', 2, 1);
INSERT INTO public.lane VALUES ('8645782395347271623', 100001, '01020000A0E610000003000000183ECCA5EB535E40701ECDDFA4363F4000000080FD9EFA3FF7A3F779EB535E4076AC8C25B0363F4000000020B2BAFA3FF4E64275EB535E40D5BD045DB1363F4000000060BC91FA3F', '2025-06-03 17:20:42.0258', '2025-06-03 17:20:42.0258', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271640', '8645782395347271639', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271625', 100001, '01020000A0E61000000300000054445DD6EA535E40E7F2510CB1363F40000000E0F99BF93F4096E203EB535E4028B1EAFAA5363F40000000600BCFFA3FAEF13109EB535E40D55809B0A4363F40000000C00776FA3F', '2025-06-03 17:20:42.612975', '2025-06-03 17:20:42.612975', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271633', '8645782395347271634', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271622', 100001, '01020000A0E610000003000000EFCB6143EC535E404033DE0FA5363F40000000A0E94FFA3FC18E971FEC535E40057B3250B0363F4000000020DB16FA3F3E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F', '2025-06-03 17:20:43.204158', '2025-06-03 17:20:43.204158', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271639', '8645782395347271637', 2, 1);
INSERT INTO public.lane VALUES ('8645046787708551151', 100001, '01020000A0E61000000600000044447194EA535E40DB050E5EF7363F4000000040D7F0F73FB25858AAEA535E407361B6FAF0363F400000000069EAF83F64EEBAB4EA535E40E0629EC5ED363F400000000069EAF83F572447B6EA535E4004DEAB51ED363F40000000206D0EF93F08121BF9EA535E4019D65215DA363F40000000603131F93FE4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F', '2025-06-03 17:20:53.775278', '2025-06-03 17:20:53.775278', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558709', '8645275692285558705', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507352', 100001, '01020000A0E610000013000000F4E64275EB535E40D5BD045DB1363F4000000060BC91FA3F09A69A59EB535E403399368BB3363F4000000060BC91FA3FF66A9E28EB535E400E3B2667B5363F40000000A01101FB3F57A15320EB535E407F3AD4A5B5363F40000000A01101FB3FA1164BDDEA535E409CB9E03CB7363F40000000A01101FB3FC04AB2CCEA535E403D950690B7363F4000000000C307FB3F02DAD27AEA535E4095160AE5B8363F400000006068AEFA3F6D8B2D62EA535E40E31A533BB9363F400000006068AEFA3FC1916B03EA535E40FAA53451BA363F400000006068AEFA3FAC73A4E4E9535E40D6E2C09CBA363F400000006068AEFA3F7D3E537AE9535E407040E373BB363F40000000A07285FA3F6C522558E9535E40593606ACBB363F4000000060235EFA3FAE11A5E3E8535E40B290DC41BC363F40000000A02D35FA3F9C7CEAC0E8535E403AE51863BC363F400000002042E3F93F48B7B6D4E7535E407607A9C2BC363F40000000C004F5F83F00982144E8535E401CD301B3BC363F40000000E06068F93F2659B223E8535E40AB8DE9BDBC363F40000000607516F93F48B7B6D4E7535E407607A9C2BC363F40000000C004F5F83F98DD0A96E7535E40053077C3BC363F40000000C004F5F83F', '2025-06-04 10:47:33.687068', '2025-06-04 10:47:33.687068', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271617', '8645782395347271616', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507356', 100001, '01020000A0E61000001300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F307A2F3DE8535E4084AC16F4B8363F40000000E06068F93F36331E98E8535E40365884D7B8363F40000000604CBAF93F0A534ABEE8535E40D707E5BFB8363F40000000604CBAF93FC32F6C02E9535E4048665380B8363F40000000200AF4F93F4ABB313AE9535E40FB6BE939B8363F40000000E0FF1CFA3FB5BB8667E9535E40C611BFF0B7363F40000000E0FF1CFA3F1DA849ACE9535E40A83C8267B7363F4000000000EC63FA3F1AF228C5E9535E4079C75C2BB7363F4000000000EC63FA3F19105C10EA535E40F6097A51B6363F4000000040F63AFA3FEC2E2019EA535E40FCEA3533B6363F4000000040F63AFA3FE1560761EA535E4068944F0BB5363F4000000040F63AFA3F6306A962EA535E404A1C3503B5363F4000000040F63AFA3FC8010F9AEA535E40E0B878B7B3363F40000000A05DFEF93F6F4F0CA0EA535E4063A2C28AB3363F40000000204950FA3F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93F9D2E65C2EA535E406F764D43B2363F40000000A05DFEF93F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93F921E5BD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 10:47:34.263751', '2025-06-04 10:47:34.263751', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271618', '8645782395347271619', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507381', 100001, '01020000A0E610000006000000E2EA72DDE3535E40C0E6F1BBB6363F400000004033F3F83FA711BEEDE5535E40BA3A8BD4B7363F40000000A014EDF83F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93FC5016651E7535E40FB8DCF94B8363F40000000A02255F93F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93F24ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F', '2025-06-04 10:47:35.407551', '2025-06-04 10:47:35.407551', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591814', '8645924713383591813', 2, 1);
INSERT INTO public.lane VALUES ('8642875801999507338', 100001, '01020000A0E61000000600000044447194EA535E40DB050E5EF7363F4000000040D7F0F73FB25858AAEA535E407361B6FAF0363F400000000069EAF83F64EEBAB4EA535E40E0629EC5ED363F400000000069EAF83F572447B6EA535E4004DEAB51ED363F40000000206D0EF93F08121BF9EA535E4019D65215DA363F40000000603131F93FE4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F', '2025-06-04 10:47:35.978885', '2025-06-04 10:47:35.978885', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558709', '8645275692285558705', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271603', 100001, '01020000A0E610000013000000F4E64275EB535E40D5BD045DB1363F4000000060BC91FA3F09A69A59EB535E403399368BB3363F4000000060BC91FA3FF66A9E28EB535E400E3B2667B5363F40000000A01101FB3F57A15320EB535E407F3AD4A5B5363F40000000A01101FB3FA1164BDDEA535E409CB9E03CB7363F40000000A01101FB3FC04AB2CCEA535E403D950690B7363F4000000000C307FB3F02DAD27AEA535E4095160AE5B8363F400000006068AEFA3F6D8B2D62EA535E40E31A533BB9363F400000006068AEFA3FC1916B03EA535E40FAA53451BA363F400000006068AEFA3FAC73A4E4E9535E40D6E2C09CBA363F400000006068AEFA3F7D3E537AE9535E407040E373BB363F40000000A07285FA3F6C522558E9535E40593606ACBB363F4000000060235EFA3FAE11A5E3E8535E40B290DC41BC363F40000000A02D35FA3F9C7CEAC0E8535E403AE51863BC363F400000002042E3F93F48B7B6D4E7535E407607A9C2BC363F40000000C004F5F83F00982144E8535E401CD301B3BC363F40000000E06068F93F2659B223E8535E40AB8DE9BDBC363F40000000607516F93F48B7B6D4E7535E407607A9C2BC363F40000000C004F5F83F98DD0A96E7535E40053077C3BC363F40000000C004F5F83F', '2025-06-03 17:20:44.377268', '2025-06-03 17:20:44.377268', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271617', '8645782395347271616', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507337', 100001, '01020000A0E610000006000000F9A0B8FAE9535E40341C183EF7363F40000000C0EB9EF73F3661F811EA535E40B4BD2CD9F0363F40000000009246F83FB0C08F1EEA535E403F018B31ED363F4000000020966AF83FD03C5D36EA535E40D83D9865E6363F40000000E0C22CF83F05E13A61EA535E4090574DFBD9363F40000000C0399CF83FFBC65165EA535E406DB11ACCD8363F40000000802FC5F83F', '2025-06-04 10:47:36.551961', '2025-06-04 10:47:36.551961', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645275692285558705', '8645275692285558706', 2, 1);
INSERT INTO public.lane VALUES ('8642875801999507334', 100001, '01020000A0E61000000600000018F0CF98EB535E40D82935FFD8363F40000000A06464F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73F33AD8255EB535E40049892E2EC363F40000000807640F83F062D0352EB535E40E5FAA4FEED363F40000000E09D11F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73FE8E1FC34EB535E408783C18BF7363F400000008030F0F73F', '2025-06-04 10:47:37.124826', '2025-06-04 10:47:37.124826', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558708', '8645275692285558707', 1, 1);
INSERT INTO public.lane VALUES ('8645275692285558755', 100001, '01020000A0E61000000600000044447194EA535E40DB050E5EF7363F4000000040D7F0F73FB25858AAEA535E407361B6FAF0363F400000000069EAF83F83DBB9B4EA535E401B49F4C5ED363F400000000069EAF83F518D3EB6EA535E408192A751ED363F40000000206D0EF93F06BAD5F7EA535E40BA9CBC0FDA363F40000000603131F93FAB00D5FBEA535E40447D1EE5D8363F40000000A03B08F93F', '2025-06-03 15:52:25.666466', '2025-06-03 15:52:25.666466', 'driving', 'null', 0, 'generate', 99, '0', '8645782395347271284', '8645275692285558772', 1, 1);
INSERT INTO public.lane VALUES ('8642723176041676722', 100001, '01020000A0E6100000030000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93FA5391CD7EB535E408E9DA1CCC7363F4000000000FD85F93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 11:39:52.986148', '2025-06-04 11:39:52.986148', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271613', '8645782395347271612', 1, 1);
INSERT INTO public.lane VALUES ('8642723176041676726', 100001, '01020000A0E6100000140000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F34611266EE535E40CD9D759AC0363F40000000805A70F93F20F45001EE535E401A1986BDC0363F40000000405099F93FF3D48DF1ED535E4044CCDBC7C0363F40000000805A70F93FB5F5488DED535E4097A8FF28C1363F40000000A0A7FAF93F8453A581ED535E409D9A2E38C1363F4000000020BCA8F93F7633A31FED535E40850D5EDAC1363F4000000040C67FF93F0DC6CF19ED535E4049C64BE6C1363F4000000040C67FF93F6E011DBDEC535E40E42023CBC2363F40000000E07B8DF93F6CA9D7BBEC535E40FCE7E0CEC2363F40000000E07B8DF93FE59B6D6EEC535E4054785BDFC3363F40000000205D08FA3FD73FE065EC535E40B9FE4603C4363F40000000205D08FA3F72F3322FEC535E409B2DB116C5363F400000004015B0F93F9C680121EC535E40E8E0B26DC5363F40000000801F87F93F287C3F00EC535E40D6A13567C6363F40000000801F87F93F592479F0EB535E406BAB6E02C7363F40000000801F87F93FD32B35E0EB535E40942780CAC7363F4000000040075DF93F150705E2EB535E40761A01C6C7363F4000000040075DF93FD32B35E0EB535E40942780CAC7363F4000000040075DF93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 11:39:56.023632', '2025-06-04 11:39:56.023632', 'virtual', NULL, 0, 'generate', 99, '0', '8645924713383591836', '8645924713383591853', 1, 1);
INSERT INTO public.lane VALUES ('8645275692285558771', 100001, '01020000A0E610000014000000D7BE7133EB535E407CBFE0B9C8363F4000000080BF7BFA3F861C0F41EB535E406BA97290C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-03 16:59:12.180512', '2025-06-03 16:59:12.180512', 'virtual', NULL, 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646102', 100001, '01020000A0E61000000A000000AF053CB7F0535E4013467196AB363F4000000040E17AF4BFC61239F1F3535E40C7518698B5363F4000000040E17AF4BF70664F5DF4535E4014C1BB39B5363F4000000040E17AF4BFEAFA8CABF4535E403F5080BEB3363F4000000040E17AF4BFE7A528B8F4535E40DAA2B822B2363F4000000040E17AF4BF805030C6F4535E4066695B58AD363F4000000040E17AF4BFAB92BECCF4535E40D7D5429BAC363F4000000040E17AF4BF8759D2CBF4535E40A8141DC4AC363F4000000040E17AF4BFAB92BECCF4535E40D7D5429BAC363F4000000040E17AF4BF2CBA25D4F4535E40DEEE913FAB363F4000000040E17AF4BF', '2025-06-04 16:49:36.361909', '2025-06-04 16:49:36.361909', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '1', '8642101470935646121', '8642101470935646120', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271244', 100001, '01020000A0E610000004000000A22B20D3EB535E4004738C15C9363F40000000801134F93F9035A9BCEB535E40968224A2CE363F4000000060E101F93F31601A9DEB535E40D3CABFC1D7363F40000000605A8DF83F18F0CF98EB535E40D82935FFD8363F40000000A06464F83F', '2025-06-03 15:48:16.223806', '2025-06-03 15:48:16.223806', 'driving', NULL, 0, 'generate', 99, '0', '8645782395347271282', '8645782395347271280', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214905', 100001, '01020000A0E610000005000000AB00D5FBEA535E40447D1EE5D8363F40000000A03B08F93FED066C2FEB535E402EEC52EBC9363F4000000000D429FA3F45A54625EB535E40A361DDEACC363F40000000A09920FA3FED066C2FEB535E402EEC52EBC9363F4000000000D429FA3FD7BE7133EB535E407CBFE0B9C8363F4000000080BF7BFA3F', '2025-06-03 17:24:39.930944', '2025-06-03 17:24:39.930944', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271283', '8645782395347271285', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214896', 100001, '01020000A0E610000004000000A22B20D3EB535E4004738C15C9363F40000000801134F93F9035A9BCEB535E40968224A2CE363F4000000060E101F93F31601A9DEB535E40D3CABFC1D7363F40000000605A8DF83F18F0CF98EB535E40D82935FFD8363F40000000A06464F83F', '2025-06-03 17:24:40.548494', '2025-06-03 17:24:40.548494', 'driving', NULL, 0, 'generate', 99, '0', '8645782395347271282', '8645782395347271280', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214898', 100001, '01020000A0E61000000600000018F0CF98EB535E40D82935FFD8363F40000000A06464F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73F33AD8255EB535E40049892E2EC363F40000000807640F83F062D0352EB535E40E5FAA4FEED363F40000000E09D11F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73FE8E1FC34EB535E408783C18BF7363F400000008030F0F73F', '2025-06-03 17:24:41.176721', '2025-06-03 17:24:41.176721', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558708', '8645275692285558707', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214904', 100001, '01020000A0E610000005000000FBC65165EA535E406DB11ACCD8363F40000000802FC5F83F4C982E99EA535E400A403990C9363F40000000002485F93FEF8F5F8EEA535E409137BECBCC363F4000000040F573F93F4C982E99EA535E400A403990C9363F40000000002485F93F69FC209DEA535E40ED3D3963C8363F40000000C019AEF93F', '2025-06-03 17:24:48.595047', '2025-06-03 17:24:48.595047', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271285', '8645782395347271291', 2, 1);
INSERT INTO public.lane VALUES ('8642101470935646099', 100001, '01020000A0E61000000A000000AF053CB7F0535E4013467196AB363F4000000040E17AF4BFC61239F1F3535E40C7518698B5363F4000000040E17AF4BF70664F5DF4535E4014C1BB39B5363F4000000040E17AF4BFEAFA8CABF4535E403F5080BEB3363F4000000040E17AF4BFE7A528B8F4535E40DAA2B822B2363F4000000040E17AF4BF805030C6F4535E4066695B58AD363F4000000040E17AF4BFAB92BECCF4535E40D7D5429BAC363F4000000040E17AF4BF8759D2CBF4535E40A8141DC4AC363F4000000040E17AF4BFAB92BECCF4535E40D7D5429BAC363F4000000040E17AF4BF2CBA25D4F4535E40DEEE913FAB363F4000000040E17AF4BF', '2025-06-04 16:50:43.344527', '2025-06-04 16:50:43.344527', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '1', '8642101470935646121', '8642101470935646120', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646104', 100001, '01020000A0E6100000060000002CBA25D4F4535E40DEEE913FAB363F4000000040E17AF4BF5308A2F6F4535E400035CC08A3363F4000000040E17AF4BFEE5157F5F4535E40A86D008CA0363F4000000040E17AF4BF9ABE97F5F4535E40FBF24609A1363F4000000040E17AF4BFEE5157F5F4535E40A86D008CA0363F4000000040E17AF4BFC3878EF4F4535E4002F6DB1B9F363F4000000040E17AF4BF', '2025-06-04 17:28:37.422142', '2025-06-04 17:28:37.422142', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '1', '8642101470935646116', '8642101470935646117', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271593', 100001, '01020000A0E6100000150000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F908E8212EC535E4021E04854B3363F4000000020DB16FA3F6512B61EEC535E40036CD5E8B4363F40000000E04434FA3FF592C920EC535E402C6ADC0DB5363F40000000204F0BFA3FB4CBB73EEC535E40F6378C75B6363F400000002001EAF93F66F67E45EC535E40BA6C88B2B6363F40000000C0EC3BFA3FA8D59772EC535E4007E064F0B7363F400000002001EAF93FDD14707EEC535E409C325334B8363F40000000E0F612FA3FA97CD7B9EC535E40BFA7284DB9363F40000000E014B3F93F5938E6C8EC535E409BDAD588B9363F4000000020F62DFA3F79880713ED535E40004EB07EBA363F40000000A00ADCF93F81740A22ED535E40068B90A8BA363F40000000A00ADCF93F4C92BE7BED535E4011996678BB363F40000000602961F93F3CB70387ED535E407C0AED8DBB363F40000000602961F93FB953A7F4ED535E40FFD99115BC363F40000000005230F93F4FF1B037EE535E40E1040445BC363F40000000405C07F93F4A7CF876EE535E40C9418F6CBC363F400000008066DEF83F599B6684EE535E40F3452C76BC363F400000008066DEF83FE2433597EE535E40F9BF957FBC363F400000008066DEF83F309B12A6EE535E40B790338CBC363F400000008066DEF83FE25B3CE2EE535E40708D3FB9BC363F400000008066DEF83F', '2025-06-03 17:20:38.471479', '2025-06-03 17:20:38.471479', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271614', '8645782395347271615', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271671', 100001, '01020000A0E610000006000000E2EA72DDE3535E40C0E6F1BBB6363F400000004033F3F83FA711BEEDE5535E40BA3A8BD4B7363F40000000A014EDF83F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93FC5016651E7535E40FB8DCF94B8363F40000000A02255F93F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93F24ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F', '2025-06-03 17:20:39.061851', '2025-06-03 17:20:39.061851', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591814', '8645924713383591813', 2, 1);
INSERT INTO public.lane VALUES ('8644989441305214861', 100001, '01020000A0E610000003000000183ECCA5EB535E40701ECDDFA4363F4000000080FD9EFA3FF7A3F779EB535E4076AC8C25B0363F4000000020B2BAFA3FF4E64275EB535E40D5BD045DB1363F4000000060BC91FA3F', '2025-06-04 10:39:26.897351', '2025-06-04 10:39:26.897351', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271640', '8645782395347271639', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214860', 100001, '01020000A0E610000003000000EFCB6143EC535E404033DE0FA5363F40000000A0E94FFA3FC18E971FEC535E40057B3250B0363F4000000020DB16FA3F3E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F', '2025-06-04 10:39:27.503115', '2025-06-04 10:39:27.503115', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271639', '8645782395347271637', 2, 1);
INSERT INTO public.lane VALUES ('8644989441305214857', 100001, '01020000A0E610000003000000921E5BD6EA535E40E7F2510CB1363F40000000E0F99BF93F4096E203EB535E4028B1EAFAA5363F40000000600BCFFA3FAEF13109EB535E40D55809B0A4363F40000000C00776FA3F', '2025-06-04 10:39:28.108333', '2025-06-04 10:39:28.108333', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271633', '8645782395347271634', 1, 1);
INSERT INTO public.lane VALUES ('8642723176041676797', 100001, '01020000A0E610000006000000E2EA72DDE3535E40C0E6F1BBB6363F400000004033F3F83FA711BEEDE5535E40BA3A8BD4B7363F40000000A014EDF83F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93FC5016651E7535E40FB8DCF94B8363F40000000A02255F93F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93F24ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F', '2025-06-04 11:39:44.50151', '2025-06-04 11:39:44.5025', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591814', '8645924713383591813', 2, 1);
INSERT INTO public.lane VALUES ('8644989441305214972', 100001, '01020000A0E610000015000000C2227AAAE7535E40594C62CCBA363F4000000000BD13FA3F3314AF66E8535E4065ABD0E2BA363F40000000A02D35FA3FDC0073FAE8535E4017B46047BB363F4000000060235EFA3FA58A3D0FE9535E40FF2A2A5CBB363F4000000060235EFA3F59EF5BA0E9535E40CFA63C1DBC363F40000000A07285FA3F8E3B5EAEE9535E40BD70F134BC363F40000000A07285FA3F5A84D939EA535E40752A8D56BD363F40000000A07285FA3FA7F8553FEA535E4087EC5B64BD363F400000006068AEFA3FF63ED9BDEA535E401B8FF1DFBE363F400000006036C1FA3F20CBB0C1EA535E40A46EB3EDBE363F400000006036C1FA3FA0275426EB535E40F7BEB19AC0363F4000000060B307FB3FF7F68B32EB535E40622757D9C0363F40000000A0BDDEFA3FFF78F176EB535E400267E283C2363F4000000040C3F7FA3FFA430D88EB535E40D8BC1C09C3363F4000000080CDCEFA3F743F9DAEEB535E40305CBD8DC4363F40000000C0D7A5FA3F95304FBEEB535E407DD77C69C5363F4000000040EC53FA3F710142CDEB535E404114BAB5C6363F40000000C00002FA3F645E4CD5EB535E405E4619C0C7363F4000000000FD85F93F0CD0E6D3EB535E40A09CF9B9C7363F4000000000FD85F93F645E4CD5EB535E405E4619C0C7363F4000000000FD85F93FD7BE7133EB535E407CBFE0B9C8363F4000000080BF7BFA3F', '2025-06-03 17:19:32.551391', '2025-06-03 17:19:32.551391', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271661', '8645782395347271660', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271642', 100001, '01020000A0E61000000300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F036CDAA1EE535E40114D1596BC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-03 17:20:40.253476', '2025-06-03 17:20:40.253476', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271659', '8645782395347271658', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271665', 100001, '01020000A0E61000000500000098DD0A96E7535E4082E472C3BC363F40000000C004F5F83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F6065498DE4535E40BE82042ABB363F40000000E05D4BF83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F3AED54B9E3535E40E891CFC3BA363F4000000000183AF83F', '2025-06-03 17:20:40.846382', '2025-06-03 17:20:40.846382', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591816', '8645924713383591818', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271586', 100001, '01020000A0E6100000110000005C29BAE4EE535E40E6B320BABE363F40000000803114FA3FF48E8D1FEE535E405D7ED048BE363F4000000040273DFA3F35C12168ED535E4034801A6BBD363F4000000060D7A8FA3FC291AA67ED535E4034D1616ABD363F4000000060D7A8FA3F661FF9BDEC535E40F3F97C22BC363F4000000020CDD1FA3F6FEEC6BAEC535E403B89F41ABC363F4000000020CDD1FA3F5229FF25EC535E40DC9CFE77BA363F40000000C0260FFB3F89078522EC535E403B6E446CBA363F400000000031E6FA3F7DE7ECA4EB535E4096D0F075B8363F4000000020FD52FB3F3A1249A3EB535E40A279126EB8363F4000000020FD52FB3F2D438E40EB535E405B4E9531B6363F40000000A01101FB3FDA515D3FEB535E4073760F29B6363F40000000A01101FB3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3F915FC3FCEA535E40FD13F4C8B3363F4000000020B2BAFA3F4004C9F9EA535E40924747A4B3363F4000000060BC91FA3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-03 17:20:41.434969', '2025-06-03 17:20:41.434969', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271590', '8645782395347271591', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271608', 100001, '01020000A0E61000001300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F307A2F3DE8535E4084AC16F4B8363F40000000E06068F93F36331E98E8535E40365884D7B8363F40000000604CBAF93F0A534ABEE8535E40D707E5BFB8363F40000000604CBAF93FC32F6C02E9535E4048665380B8363F40000000200AF4F93F4ABB313AE9535E40FB6BE939B8363F40000000E0FF1CFA3FB5BB8667E9535E40C611BFF0B7363F40000000E0FF1CFA3F1DA849ACE9535E40A83C8267B7363F4000000000EC63FA3F1AF228C5E9535E4079C75C2BB7363F4000000000EC63FA3F19105C10EA535E40F6097A51B6363F4000000040F63AFA3FEC2E2019EA535E40FCEA3533B6363F4000000040F63AFA3FE1560761EA535E4068944F0BB5363F4000000040F63AFA3F6306A962EA535E404A1C3503B5363F4000000040F63AFA3FC8010F9AEA535E40E0B878B7B3363F40000000A05DFEF93F6F4F0CA0EA535E4063A2C28AB3363F40000000204950FA3F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93F9D2E65C2EA535E406F764D43B2363F40000000A05DFEF93F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93F54445DD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-03 17:20:43.792757', '2025-06-03 17:20:43.792757', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271618', '8645782395347271619', 1, 1);
INSERT INTO public.lane VALUES ('8645924713383591823', 100001, '01020000A0E61000001800000047DB93E8EE535E40730DB76CC2363F40000000601F2BF83F4DB70866EE535E40D2818998C2363F40000000601F2BF83F6AE30936EE535E40903F67BEC2363F40000000201554F83FBDA3DD20EE535E40D833E4D5C2363F40000000601F2BF83FD24B2CF3ED535E40AE2DFA12C3363F40000000E00A7DF83FC81A3AE5ED535E406D324028C3363F40000000201554F83F180405C7ED535E401F378761C3363F40000000201554F83F54E6119CED535E406C624EBEC3363F4000000060B997F83F1E97C49BED535E4072A80FBFC3363F4000000060B997F83F326CBD74ED535E40A2110932C4363F40000000E0A4E9F83F51CAED5CED535E40079C3D81C4363F40000000E0A4E9F83FD4C7F54FED535E400CBC7EB4C4363F4000000020AFC0F83F991E292FED535E407D582346C5363F4000000060B997F83F5D6FC629ED535E40189C4260C5363F4000000060B997F83F144DCD09ED535E40D6DA751BC6363F4000000000D81CF83F917CD901ED535E40BE65FD4FC6363F4000000000D81CF83F70208CEEEC535E403BDC20F0C6363F4000000040E2F3F73FF28E5BE5EC535E40EDB0084CC7363F400000000002E4F73FEE6C37DDEC535E4088FCB9BCC7363F400000000002E4F73F282511D5EC535E40CFE2BD51C8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F4B51D3D3EC535E40E742297DC8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F5AD1FDD4EC535E40D43B9DAAC9363F40000000C02069F73F', '2025-06-03 17:20:46.140164', '2025-06-03 17:20:46.140164', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591843', '8645924713383591842', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271595', 100001, '01020000A0E6100000030000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F864C1DD7EB535E4011E9A5CCC7363F4000000000FD85F93FE1051ED3EB535E4081278815C9363F40000000801134F93F', '2025-06-03 17:20:46.727761', '2025-06-03 17:20:46.727761', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271613', '8645782395347271612', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271572', 100001, '01020000A0E61000000300000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93F30FE46D3EA535E40E0A8A551B2363F4000000020DB16FA3F54445DD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-03 17:20:47.316466', '2025-06-03 17:20:47.316466', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271581', '8645782395347271582', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271574', 100001, '01020000A0E61000001400000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93FDAFD1B95EA535E402A916AF6C5363F4000000040810CFA3F94BC0A8EEA535E40E29AF16CC5363F40000000808BE3F93F636EF973EA535E40B3BF1920C4363F40000000808BE3F93FFC1E9766EA535E40492FF8A1C3363F40000000C095BAF93F7FB7993AEA535E40A3C8465FC2363F40000000C095BAF93FA9708529EA535E404FD2CEF9C1363F40000000E073CBF93F84C401EAE9535E403E1B7FC3C0363F40000000608879F93F472B40D9E9535E404A58077FC0363F40000000A09250F93FC33B4784E9535E405172545CBF363F40000000A09250F93F0AB16A78E9535E402DC7383ABF363F40000000E09C27F93F460D8A0CE9535E409365CD37BE363F4000000060F948F93FC10BCF09E9535E40D46A6632BE363F4000000060F948F93FD24F2990E8535E40D5875670BD363F40000000E06068F93F06138986E8535E4081555364BD363F40000000206B3FF93F79904DDBE7535E40CF7C22DDBC363F40000000C004F5F83FEEEB5D0FE8535E404CCD16F7BC363F40000000607516F93FA7996FF6E7535E40F3986FE7BC363F40000000C004F5F83F79904DDBE7535E40CF7C22DDBC363F40000000C004F5F83FCCB7739EE7535E402E5EDDC5BC363F40000000C004F5F83F', '2025-06-03 17:20:47.90354', '2025-06-03 17:20:47.90354', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271583', '8645782395347271584', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271680', 100001, '01020000A0E610000006000000E647666FF5535E405BB4DF5EC2363F40000000C066EBF73F7AE31B3FF1535E409852C20CC0363F40000000605AD4F83F58054923EF535E4063E775DDBE363F40000000002F01FA3F229B589EEF535E408CA8F322BF363F4000000000585DF93F58054923EF535E4063E775DDBE363F40000000002F01FA3F5C29BAE4EE535E40E6B320BABE363F40000000803114FA3F', '2025-06-03 17:20:49.076709', '2025-06-03 17:20:49.076709', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591799', '8645924713383591876', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271644', 100001, '01020000A0E6100000030000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F359A57D3E7535E406AFA7FE4BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-03 17:20:49.662656', '2025-06-03 17:20:49.662656', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271662', '8645782395347271663', 1, 1);
INSERT INTO public.lane VALUES ('8645782395347271679', 100001, '01020000A0E610000007000000DFE39D5AF5535E40AD120647C4363F40000000C08F47F73F6CB106E8F1535E40087F9160C2363F40000000809B68F73F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93FB743268DEF535E402091A20DC1363F40000000C076E2F83F11928B85EF535E40A3C25209C1363F400000000081B9F83F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93F4A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F', '2025-06-03 17:20:50.252332', '2025-06-03 17:20:50.252332', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591876', '8645924713383591870', 2, 1);
INSERT INTO public.lane VALUES ('8642875801999507290', 100001, '01020000A0E61000000300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F036CDAA1EE535E40114D1596BC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 10:58:42.781698', '2025-06-04 10:58:42.781698', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271659', '8645782395347271658', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507095', 100001, '01020000A0E610000005000000E4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F71AAB530EB535E4033FB20F1C9363F4000000000D429FA3F77AFA426EB535E40566526EBCC363F40000000A09920FA3F71AAB530EB535E4033FB20F1C9363F4000000000D429FA3F48A3CD34EB535E40408843BAC8363F4000000080BF7BFA3F', '2025-06-04 11:30:35.586541', '2025-06-04 11:30:35.586541', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271283', '8645782395347271285', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507101', 100001, '01020000A0E61000000600000044447194EA535E40DB050E5EF7363F4000000040D7F0F73FB25858AAEA535E407361B6FAF0363F400000000069EAF83F64EEBAB4EA535E40E0629EC5ED363F400000000069EAF83F572447B6EA535E4004DEAB51ED363F40000000206D0EF93F08121BF9EA535E4019D65215DA363F40000000603131F93FE4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F', '2025-06-04 11:30:36.187149', '2025-06-04 11:30:36.187149', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558709', '8645275692285558705', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507100', 100001, '01020000A0E610000006000000F9A0B8FAE9535E40341C183EF7363F40000000C0EB9EF73F3661F811EA535E40B4BD2CD9F0363F40000000009246F83FB0C08F1EEA535E403F018B31ED363F4000000020966AF83FD03C5D36EA535E40D83D9865E6363F40000000E0C22CF83F05E13A61EA535E4090574DFBD9363F40000000C0399CF83FFBC65165EA535E406DB11ACCD8363F40000000802FC5F83F', '2025-06-04 11:30:36.787576', '2025-06-04 11:30:36.787576', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645275692285558705', '8645275692285558706', 2, 1);
INSERT INTO public.lane VALUES ('8642875801999507097', 100001, '01020000A0E61000000600000018F0CF98EB535E40D82935FFD8363F40000000A06464F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73F33AD8255EB535E40049892E2EC363F40000000807640F83F062D0352EB535E40E5FAA4FEED363F40000000E09D11F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73FE8E1FC34EB535E408783C18BF7363F400000008030F0F73F', '2025-06-04 11:30:37.386349', '2025-06-04 11:30:37.386349', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558708', '8645275692285558707', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214823', 100001, '01020000A0E61000000600000018F0CF98EB535E40D82935FFD8363F40000000A06464F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73F33AD8255EB535E40049892E2EC363F40000000807640F83F062D0352EB535E40E5FAA4FEED363F40000000E09D11F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73FE8E1FC34EB535E408783C18BF7363F400000008030F0F73F', '2025-06-04 10:19:27.419106', '2025-06-04 10:19:27.419106', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558708', '8645275692285558707', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214926', 100001, '01020000A0E610000013000000F4E64275EB535E40D5BD045DB1363F4000000060BC91FA3F09A69A59EB535E403399368BB3363F4000000060BC91FA3FF66A9E28EB535E400E3B2667B5363F40000000A01101FB3F57A15320EB535E407F3AD4A5B5363F40000000A01101FB3FA1164BDDEA535E409CB9E03CB7363F40000000A01101FB3FC04AB2CCEA535E403D950690B7363F4000000000C307FB3F02DAD27AEA535E4095160AE5B8363F400000006068AEFA3F6D8B2D62EA535E40E31A533BB9363F400000006068AEFA3FC1916B03EA535E40FAA53451BA363F400000006068AEFA3FAC73A4E4E9535E40D6E2C09CBA363F400000006068AEFA3F7D3E537AE9535E407040E373BB363F40000000A07285FA3F6C522558E9535E40593606ACBB363F4000000060235EFA3FAE11A5E3E8535E40B290DC41BC363F40000000A02D35FA3F9C7CEAC0E8535E403AE51863BC363F400000002042E3F93F48B7B6D4E7535E407607A9C2BC363F40000000C004F5F83F00982144E8535E401CD301B3BC363F40000000E06068F93F2659B223E8535E40AB8DE9BDBC363F40000000607516F93F48B7B6D4E7535E407607A9C2BC363F40000000C004F5F83F98DD0A96E7535E40053077C3BC363F40000000C004F5F83F', '2025-06-03 17:24:33.780023', '2025-06-03 17:24:33.780023', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271617', '8645782395347271616', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214930', 100001, '01020000A0E61000001300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F307A2F3DE8535E4084AC16F4B8363F40000000E06068F93F36331E98E8535E40365884D7B8363F40000000604CBAF93F0A534ABEE8535E40D707E5BFB8363F40000000604CBAF93FC32F6C02E9535E4048665380B8363F40000000200AF4F93F4ABB313AE9535E40FB6BE939B8363F40000000E0FF1CFA3FB5BB8667E9535E40C611BFF0B7363F40000000E0FF1CFA3F1DA849ACE9535E40A83C8267B7363F4000000000EC63FA3F1AF228C5E9535E4079C75C2BB7363F4000000000EC63FA3F19105C10EA535E40F6097A51B6363F4000000040F63AFA3FEC2E2019EA535E40FCEA3533B6363F4000000040F63AFA3FE1560761EA535E4068944F0BB5363F4000000040F63AFA3F6306A962EA535E404A1C3503B5363F4000000040F63AFA3FC8010F9AEA535E40E0B878B7B3363F40000000A05DFEF93F6F4F0CA0EA535E4063A2C28AB3363F40000000204950FA3F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93F9D2E65C2EA535E406F764D43B2363F40000000A05DFEF93F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93F921E5BD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-03 17:24:34.395841', '2025-06-03 17:24:34.395841', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271618', '8645782395347271619', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214917', 100001, '01020000A0E6100000110000005C29BAE4EE535E40E6B320BABE363F40000000803114FA3FF48E8D1FEE535E405D7ED048BE363F4000000040273DFA3F35C12168ED535E4034801A6BBD363F4000000060D7A8FA3FC291AA67ED535E4034D1616ABD363F4000000060D7A8FA3F661FF9BDEC535E40F3F97C22BC363F4000000020CDD1FA3F6FEEC6BAEC535E403B89F41ABC363F4000000020CDD1FA3F5229FF25EC535E40DC9CFE77BA363F40000000C0260FFB3F89078522EC535E403B6E446CBA363F400000000031E6FA3F7DE7ECA4EB535E4096D0F075B8363F4000000020FD52FB3F3A1249A3EB535E40A279126EB8363F4000000020FD52FB3F2D438E40EB535E405B4E9531B6363F40000000A01101FB3FDA515D3FEB535E4073760F29B6363F40000000A01101FB3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3F915FC3FCEA535E40FD13F4C8B3363F4000000020B2BAFA3F4004C9F9EA535E40924747A4B3363F4000000060BC91FA3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-03 17:24:35.012903', '2025-06-03 17:24:35.012903', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271590', '8645782395347271591', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214958', 100001, '01020000A0E610000006000000E2EA72DDE3535E40C0E6F1BBB6363F400000004033F3F83FA711BEEDE5535E40BA3A8BD4B7363F40000000A014EDF83F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93FC5016651E7535E40FB8DCF94B8363F40000000A02255F93F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93F24ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F', '2025-06-03 17:24:35.625822', '2025-06-03 17:24:35.625822', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591814', '8645924713383591813', 2, 1);
INSERT INTO public.lane VALUES ('8644989441305214959', 100001, '01020000A0E610000005000000932E26CBE3535E408A32ACC6B8363F40000000E034EFF83FDC552EA5E5535E40C594BFB0B9363F40000000808869F93F2F533A28E6535E40CB0F27F3B9363F40000000805F0DFA3F35CC036AE7535E40BE7629A8BA363F4000000040C7EAF93FC2227AAAE7535E40594C62CCBA363F4000000000BD13FA3F', '2025-06-03 17:24:36.241256', '2025-06-03 17:24:36.241256', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591815', '8645924713383591814', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214940', 100001, '01020000A0E61000000300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F036CDAA1EE535E40114D1596BC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-03 17:24:36.850705', '2025-06-03 17:24:36.850705', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271659', '8645782395347271658', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214949', 100001, '01020000A0E610000006000000E647666FF5535E405BB4DF5EC2363F40000000C066EBF73F7AE31B3FF1535E409852C20CC0363F40000000605AD4F83F58054923EF535E4063E775DDBE363F40000000002F01FA3F229B589EEF535E408CA8F322BF363F4000000000585DF93F58054923EF535E4063E775DDBE363F40000000002F01FA3F5C29BAE4EE535E40E6B320BABE363F40000000803114FA3F', '2025-06-03 17:24:37.464683', '2025-06-03 17:24:37.464683', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591799', '8645924713383591876', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214963', 100001, '01020000A0E6100000140000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F34611266EE535E40CD9D759AC0363F40000000805A70F93F20F45001EE535E401A1986BDC0363F40000000405099F93FF3D48DF1ED535E4044CCDBC7C0363F40000000805A70F93FB5F5488DED535E4097A8FF28C1363F40000000A0A7FAF93F8453A581ED535E409D9A2E38C1363F4000000020BCA8F93F7633A31FED535E40850D5EDAC1363F4000000040C67FF93F0DC6CF19ED535E4049C64BE6C1363F4000000040C67FF93F6E011DBDEC535E40E42023CBC2363F40000000E07B8DF93F6CA9D7BBEC535E40FCE7E0CEC2363F40000000E07B8DF93FE59B6D6EEC535E4054785BDFC3363F40000000205D08FA3FD73FE065EC535E40B9FE4603C4363F40000000205D08FA3F72F3322FEC535E409B2DB116C5363F400000004015B0F93F9C680121EC535E40E8E0B26DC5363F40000000801F87F93F287C3F00EC535E40D6A13567C6363F40000000801F87F93F592479F0EB535E406BAB6E02C7363F40000000801F87F93FB43E36E0EB535E4011DC7BCAC7363F4000000040075DF93F150705E2EB535E40761A01C6C7363F4000000040075DF93FB43E36E0EB535E4011DC7BCAC7363F4000000040075DF93FE1051ED3EB535E4081278815C9363F40000000801134F93F', '2025-06-03 17:24:38.080044', '2025-06-03 17:24:38.080044', 'virtual', NULL, 0, 'generate', 99, '0', '8645924713383591836', '8645924713383591853', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214948', 100001, '01020000A0E610000007000000DFE39D5AF5535E40AD120647C4363F40000000C08F47F73F6CB106E8F1535E40087F9160C2363F40000000809B68F73F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93FB743268DEF535E402091A20DC1363F40000000C076E2F83F11928B85EF535E40A3C25209C1363F400000000081B9F83F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93F4A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F', '2025-06-03 17:24:38.694022', '2025-06-03 17:24:38.694022', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591876', '8645924713383591870', 2, 1);
INSERT INTO public.lane VALUES ('8644989441305214961', 100001, '01020000A0E61000001800000047DB93E8EE535E40730DB76CC2363F40000000601F2BF83F4DB70866EE535E40D2818998C2363F40000000601F2BF83F6AE30936EE535E40903F67BEC2363F40000000201554F83FBDA3DD20EE535E40D833E4D5C2363F40000000601F2BF83FD24B2CF3ED535E40AE2DFA12C3363F40000000E00A7DF83FC81A3AE5ED535E406D324028C3363F40000000201554F83F180405C7ED535E401F378761C3363F40000000201554F83F54E6119CED535E406C624EBEC3363F4000000060B997F83F1E97C49BED535E4072A80FBFC3363F4000000060B997F83F326CBD74ED535E40A2110932C4363F40000000E0A4E9F83F51CAED5CED535E40079C3D81C4363F40000000E0A4E9F83FD4C7F54FED535E400CBC7EB4C4363F4000000020AFC0F83F991E292FED535E407D582346C5363F4000000060B997F83F5D6FC629ED535E40189C4260C5363F4000000060B997F83F144DCD09ED535E40D6DA751BC6363F4000000000D81CF83F917CD901ED535E40BE65FD4FC6363F4000000000D81CF83F70208CEEEC535E403BDC20F0C6363F4000000040E2F3F73FF28E5BE5EC535E40EDB0084CC7363F400000000002E4F73FEE6C37DDEC535E4088FCB9BCC7363F400000000002E4F73F282511D5EC535E40CFE2BD51C8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F4B51D3D3EC535E40E742297DC8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F5AD1FDD4EC535E40D43B9DAAC9363F40000000C02069F73F', '2025-06-03 17:24:39.305387', '2025-06-03 17:24:39.305387', 'virtual', '["non_motor_vehicle","walker"]', 0, 'generate', 99, '0', '8645924713383591843', '8645924713383591842', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214932', 100001, '01020000A0E610000003000000921E5BD6EA535E40E7F2510CB1363F40000000E0F99BF93F4096E203EB535E4028B1EAFAA5363F40000000600BCFFA3FAEF13109EB535E40D55809B0A4363F40000000C00776FA3F', '2025-06-03 17:24:41.797587', '2025-06-03 17:24:41.797587', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271633', '8645782395347271634', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214935', 100001, '01020000A0E610000003000000EFCB6143EC535E404033DE0FA5363F40000000A0E94FFA3FC18E971FEC535E40057B3250B0363F4000000020DB16FA3F3E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F', '2025-06-03 17:24:42.412783', '2025-06-03 17:24:42.412783', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271639', '8645782395347271637', 2, 1);
INSERT INTO public.lane VALUES ('8644989441305214923', 100001, '01020000A0E6100000150000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F908E8212EC535E4021E04854B3363F4000000020DB16FA3F6512B61EEC535E40036CD5E8B4363F40000000E04434FA3FF592C920EC535E402C6ADC0DB5363F40000000204F0BFA3FB4CBB73EEC535E40F6378C75B6363F400000002001EAF93F66F67E45EC535E40BA6C88B2B6363F40000000C0EC3BFA3FA8D59772EC535E4007E064F0B7363F400000002001EAF93FDD14707EEC535E409C325334B8363F40000000E0F612FA3FA97CD7B9EC535E40BFA7284DB9363F40000000E014B3F93F5938E6C8EC535E409BDAD588B9363F4000000020F62DFA3F79880713ED535E40004EB07EBA363F40000000A00ADCF93F81740A22ED535E40068B90A8BA363F40000000A00ADCF93F4C92BE7BED535E4011996678BB363F40000000602961F93F3CB70387ED535E407C0AED8DBB363F40000000602961F93F1AA4B0F0ED535E40A0B4B92FBC363F40000000005230F93F6B57F0F4ED535E40A07DC634BC363F40000000005230F93F2B35D1A0EE535E4064A696A8BC363F40000000405C07F93F341DF568EE535E40C35D8898BC363F400000008066DEF83F9CE13B6EEE535E4046656F9BBC363F40000000405C07F93F2B35D1A0EE535E4064A696A8BC363F40000000405C07F93FE25B3CE2EE535E40708D3FB9BC363F400000008066DEF83F', '2025-06-03 17:24:43.024073', '2025-06-03 17:24:43.024073', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271614', '8645782395347271615', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214936', 100001, '01020000A0E610000003000000183ECCA5EB535E40701ECDDFA4363F4000000080FD9EFA3FF7A3F779EB535E4076AC8C25B0363F4000000020B2BAFA3FF4E64275EB535E40D5BD045DB1363F4000000060BC91FA3F', '2025-06-03 17:24:43.636792', '2025-06-03 17:24:43.636792', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271640', '8645782395347271639', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214920', 100001, '01020000A0E6100000030000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F864C1DD7EB535E4011E9A5CCC7363F4000000000FD85F93FE1051ED3EB535E4081278815C9363F40000000801134F93F', '2025-06-03 17:24:44.247108', '2025-06-03 17:24:44.247108', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271613', '8645782395347271612', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214952', 100001, '01020000A0E610000004000000E25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83FC359A750F1535E40CEE61D19BE363F40000000608330F83FBE6DFC42F5535E407A502051C0363F4000000040500BF73F0AE9A281F5535E40E5BE5B74C0363F40000000001DD8F73F', '2025-06-03 17:24:44.85797', '2025-06-03 17:24:44.85797', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591798', '8645924713383591800', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214966', 100001, '01020000A0E610000014000000125AC5D1EB535E4040AA2915C9363F40000000801134F93F861C0F41EB535E406BA97290C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-03 17:24:45.47493', '2025-06-03 17:24:45.47493', 'virtual', NULL, 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214954', 100001, '01020000A0E61000000500000098DD0A96E7535E4082E472C3BC363F40000000C004F5F83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F6065498DE4535E40BE82042ABB363F40000000E05D4BF83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F3AED54B9E3535E40E891CFC3BA363F4000000000183AF83F', '2025-06-03 17:24:46.093552', '2025-06-03 17:24:46.093552', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591816', '8645924713383591818', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214968', 100001, '01020000A0E610000015000000C2227AAAE7535E40594C62CCBA363F4000000000BD13FA3F3314AF66E8535E4065ABD0E2BA363F40000000A02D35FA3FDC0073FAE8535E4017B46047BB363F4000000060235EFA3FA58A3D0FE9535E40FF2A2A5CBB363F4000000060235EFA3F59EF5BA0E9535E40CFA63C1DBC363F40000000A07285FA3F8E3B5EAEE9535E40BD70F134BC363F40000000A07285FA3F5A84D939EA535E40752A8D56BD363F40000000A07285FA3FA7F8553FEA535E4087EC5B64BD363F400000006068AEFA3FF63ED9BDEA535E401B8FF1DFBE363F400000006036C1FA3F20CBB0C1EA535E40A46EB3EDBE363F400000006036C1FA3FA0275426EB535E40F7BEB19AC0363F4000000060B307FB3FF7F68B32EB535E40622757D9C0363F40000000A0BDDEFA3FFF78F176EB535E400267E283C2363F4000000040C3F7FA3FFA430D88EB535E40D8BC1C09C3363F4000000080CDCEFA3F743F9DAEEB535E40305CBD8DC4363F40000000C0D7A5FA3F95304FBEEB535E407DD77C69C5363F4000000040EC53FA3F710142CDEB535E404114BAB5C6363F40000000C00002FA3F645E4CD5EB535E405E4619C0C7363F4000000000FD85F93F0CD0E6D3EB535E40A09CF9B9C7363F4000000000FD85F93F645E4CD5EB535E405E4619C0C7363F4000000000FD85F93F125AC5D1EB535E4040AA2915C9363F40000000801134F93F', '2025-06-03 17:24:46.71996', '2025-06-03 17:24:46.71996', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271661', '8645782395347271660', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214944', 100001, '01020000A0E6100000030000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F359A57D3E7535E406AFA7FE4BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-03 17:24:47.347955', '2025-06-03 17:24:47.347955', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271662', '8645782395347271663', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214914', 100001, '01020000A0E61000001400000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93FDAFD1B95EA535E402A916AF6C5363F4000000040810CFA3F94BC0A8EEA535E40E29AF16CC5363F40000000808BE3F93F636EF973EA535E40B3BF1920C4363F40000000808BE3F93FFC1E9766EA535E40492FF8A1C3363F40000000C095BAF93F7FB7993AEA535E40A3C8465FC2363F40000000C095BAF93FA9708529EA535E404FD2CEF9C1363F40000000E073CBF93F84C401EAE9535E403E1B7FC3C0363F40000000608879F93F472B40D9E9535E404A58077FC0363F40000000A09250F93FC33B4784E9535E405172545CBF363F40000000A09250F93F0AB16A78E9535E402DC7383ABF363F40000000E09C27F93F460D8A0CE9535E409365CD37BE363F4000000060F948F93FC10BCF09E9535E40D46A6632BE363F4000000060F948F93FD24F2990E8535E40D5875670BD363F40000000E06068F93F06138986E8535E4081555364BD363F40000000206B3FF93F79904DDBE7535E40CF7C22DDBC363F40000000C004F5F83FEEEB5D0FE8535E404CCD16F7BC363F40000000607516F93FA7996FF6E7535E40F3986FE7BC363F40000000C004F5F83F79904DDBE7535E40CF7C22DDBC363F40000000C004F5F83FCCB7739EE7535E402E5EDDC5BC363F40000000C004F5F83F', '2025-06-03 17:24:47.97318', '2025-06-03 17:24:47.97318', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271583', '8645782395347271584', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214908', 100001, '01020000A0E610000006000000F9A0B8FAE9535E40341C183EF7363F40000000C0EB9EF73F3661F811EA535E40B4BD2CD9F0363F40000000009246F83FB0C08F1EEA535E403F018B31ED363F4000000020966AF83FD03C5D36EA535E40D83D9865E6363F40000000E0C22CF83F05E13A61EA535E4090574DFBD9363F40000000C0399CF83FFBC65165EA535E406DB11ACCD8363F40000000802FC5F83F', '2025-06-03 17:24:49.206171', '2025-06-03 17:24:49.206171', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645275692285558705', '8645275692285558706', 2, 1);
INSERT INTO public.lane VALUES ('8644989441305214909', 100001, '01020000A0E61000000600000044447194EA535E40DB050E5EF7363F4000000040D7F0F73FB25858AAEA535E407361B6FAF0363F400000000069EAF83F64EEBAB4EA535E40E0629EC5ED363F400000000069EAF83F572447B6EA535E4004DEAB51ED363F40000000206D0EF93F08121BF9EA535E4019D65215DA363F40000000603131F93FE4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F', '2025-06-03 17:24:49.827785', '2025-06-03 17:24:49.827785', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558709', '8645275692285558705', 1, 1);
INSERT INTO public.lane VALUES ('8642723176041676768', 100001, '01020000A0E61000001300000013D44175EB535E40D5BD045DB1363F4000000060BC91FA3F09A69A59EB535E403399368BB3363F4000000060BC91FA3FF66A9E28EB535E400E3B2667B5363F40000000A01101FB3F57A15320EB535E407F3AD4A5B5363F40000000A01101FB3FA1164BDDEA535E409CB9E03CB7363F40000000A01101FB3FC04AB2CCEA535E403D950690B7363F4000000000C307FB3F02DAD27AEA535E4095160AE5B8363F400000006068AEFA3F6D8B2D62EA535E40E31A533BB9363F400000006068AEFA3FC1916B03EA535E40FAA53451BA363F400000006068AEFA3FAC73A4E4E9535E40D6E2C09CBA363F400000006068AEFA3F7D3E537AE9535E407040E373BB363F40000000A07285FA3F6C522558E9535E40593606ACBB363F4000000060235EFA3FAE11A5E3E8535E40B290DC41BC363F40000000A02D35FA3F9C7CEAC0E8535E403AE51863BC363F400000002042E3F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F30506644E8535E40FFDFD6B2BC363F40000000E06068F93F8320AF23E8535E40BDA34ABDBC363F40000000607516F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 11:39:45.115539', '2025-06-04 11:39:45.115539', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271617', '8645782395347271616', 1, 1);
INSERT INTO public.lane VALUES ('8642723176041676798', 100001, '01020000A0E610000005000000932E26CBE3535E408A32ACC6B8363F40000000E034EFF83FDC552EA5E5535E40C594BFB0B9363F40000000808869F93F2F533A28E6535E40CB0F27F3B9363F40000000805F0DFA3F16DF046AE7535E40BE7629A8BA363F4000000040C7EAF93FC2227AAAE7535E40D6005ECCBA363F4000000000BD13FA3F', '2025-06-04 11:39:45.723911', '2025-06-04 11:39:45.723911', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591815', '8645924713383591814', 1, 1);
INSERT INTO public.lane VALUES ('8642723176041676782', 100001, '01020000A0E61000000300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F036CDAA1EE535E40114D1596BC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 11:39:46.342032', '2025-06-04 11:39:46.342032', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271659', '8645782395347271658', 1, 1);
INSERT INTO public.lane VALUES ('8642723176041676794', 100001, '01020000A0E61000000500000098DD0A96E7535E4082E472C3BC363F40000000C004F5F83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F6065498DE4535E40BE82042ABB363F40000000E05D4BF83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F3AED54B9E3535E40E891CFC3BA363F4000000000183AF83F', '2025-06-04 11:39:46.947788', '2025-06-04 11:39:46.947788', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591816', '8645924713383591818', 1, 1);
INSERT INTO public.lane VALUES ('8642723176041676750', 100001, '01020000A0E610000006000000F9A0B8FAE9535E40341C183EF7363F40000000C0EB9EF73F3661F811EA535E40B4BD2CD9F0363F40000000009246F83FB0C08F1EEA535E403F018B31ED363F4000000020966AF83FD03C5D36EA535E40D83D9865E6363F40000000E0C22CF83F05E13A61EA535E4090574DFBD9363F40000000C0399CF83FFBC65165EA535E406DB11ACCD8363F40000000802FC5F83F', '2025-06-04 11:39:47.550981', '2025-06-04 11:39:47.550981', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645275692285558705', '8645275692285558706', 2, 1);
INSERT INTO public.lane VALUES ('8642723176041676744', 100001, '01020000A0E610000005000000FBC65165EA535E406DB11ACCD8363F40000000802FC5F83F4C982E99EA535E400A403990C9363F40000000002485F93FEF8F5F8EEA535E409137BECBCC363F4000000040F573F93F4C982E99EA535E400A403990C9363F40000000002485F93F69FC209DEA535E40ED3D3963C8363F40000000C019AEF93F', '2025-06-04 11:39:48.162949', '2025-06-04 11:39:48.162949', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271285', '8645782395347271291', 2, 1);
INSERT INTO public.lane VALUES ('8642723176041676786', 100001, '01020000A0E6100000030000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F15AD58D3E7535E40E7AE7BE4BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 11:39:48.771898', '2025-06-04 11:39:48.771898', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271662', '8645782395347271663', 1, 1);
INSERT INTO public.lane VALUES ('8642723176041676751', 100001, '01020000A0E61000000600000044447194EA535E40DB050E5EF7363F4000000040D7F0F73FB25858AAEA535E407361B6FAF0363F400000000069EAF83F64EEBAB4EA535E40E0629EC5ED363F400000000069EAF83F572447B6EA535E4004DEAB51ED363F40000000206D0EF93F08121BF9EA535E4019D65215DA363F40000000603131F93FE4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F', '2025-06-04 11:39:49.369883', '2025-06-04 11:39:49.369883', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558709', '8645275692285558705', 1, 1);
INSERT INTO public.lane VALUES ('8642723176041676734', 100001, '01020000A0E610000015000000C2227AAAE7535E40D6005ECCBA363F4000000000BD13FA3F3314AF66E8535E4065ABD0E2BA363F40000000A02D35FA3FDC0073FAE8535E4017B46047BB363F4000000060235EFA3FA58A3D0FE9535E40FF2A2A5CBB363F4000000060235EFA3F59EF5BA0E9535E40CFA63C1DBC363F40000000A07285FA3F8E3B5EAEE9535E40BD70F134BC363F40000000A07285FA3F5A84D939EA535E40752A8D56BD363F40000000A07285FA3FA7F8553FEA535E4087EC5B64BD363F400000006068AEFA3FF63ED9BDEA535E401B8FF1DFBE363F400000006036C1FA3F20CBB0C1EA535E40A46EB3EDBE363F400000006036C1FA3FA0275426EB535E40F7BEB19AC0363F4000000060B307FB3FF7F68B32EB535E40622757D9C0363F40000000A0BDDEFA3FFF78F176EB535E400267E283C2363F4000000040C3F7FA3FFA430D88EB535E40D8BC1C09C3363F4000000080CDCEFA3F743F9DAEEB535E40305CBD8DC4363F40000000C0D7A5FA3F95304FBEEB535E407DD77C69C5363F4000000040EC53FA3F710142CDEB535E404114BAB5C6363F40000000C00002FA3F951065D5EB535E405E4619C0C7363F4000000000FD85F93F6A97E3D3EB535E40C90E7DB9C7363F4000000000FD85F93F951065D5EB535E405E4619C0C7363F4000000000FD85F93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 11:39:49.974232', '2025-06-04 11:39:49.974232', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271661', '8645782395347271660', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214888', 100001, '01020000A0E6100000140000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F34611266EE535E40CD9D759AC0363F40000000805A70F93F20F45001EE535E401A1986BDC0363F40000000405099F93FF3D48DF1ED535E4044CCDBC7C0363F40000000805A70F93FB5F5488DED535E4097A8FF28C1363F40000000A0A7FAF93F8453A581ED535E409D9A2E38C1363F4000000020BCA8F93F7633A31FED535E40850D5EDAC1363F4000000040C67FF93F0DC6CF19ED535E4049C64BE6C1363F4000000040C67FF93F6E011DBDEC535E40E42023CBC2363F40000000E07B8DF93F6CA9D7BBEC535E40FCE7E0CEC2363F40000000E07B8DF93FE59B6D6EEC535E4054785BDFC3363F40000000205D08FA3FD73FE065EC535E40B9FE4603C4363F40000000205D08FA3F72F3322FEC535E409B2DB116C5363F400000004015B0F93F9C680121EC535E40E8E0B26DC5363F40000000801F87F93F287C3F00EC535E40D6A13567C6363F40000000801F87F93F592479F0EB535E406BAB6E02C7363F40000000801F87F93FB43E36E0EB535E4011DC7BCAC7363F4000000040075DF93F150705E2EB535E40761A01C6C7363F4000000040075DF93FB43E36E0EB535E4011DC7BCAC7363F4000000040075DF93FE1051ED3EB535E4081278815C9363F40000000801134F93F', '2025-06-03 17:46:21.667331', '2025-06-03 17:46:21.667331', 'virtual', NULL, 0, 'generate', 99, '0', '8645924713383591836', '8645924713383591853', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214886', 100001, '01020000A0E61000001800000047DB93E8EE535E40730DB76CC2363F40000000601F2BF83F4DB70866EE535E40D2818998C2363F40000000601F2BF83F6AE30936EE535E40903F67BEC2363F40000000201554F83FBDA3DD20EE535E40D833E4D5C2363F40000000601F2BF83FD24B2CF3ED535E40AE2DFA12C3363F40000000E00A7DF83FC81A3AE5ED535E406D324028C3363F40000000201554F83F180405C7ED535E401F378761C3363F40000000201554F83F54E6119CED535E406C624EBEC3363F4000000060B997F83F1E97C49BED535E4072A80FBFC3363F4000000060B997F83F326CBD74ED535E40A2110932C4363F40000000E0A4E9F83F51CAED5CED535E40079C3D81C4363F40000000E0A4E9F83FD4C7F54FED535E400CBC7EB4C4363F4000000020AFC0F83F991E292FED535E407D582346C5363F4000000060B997F83F5D6FC629ED535E40189C4260C5363F4000000060B997F83F144DCD09ED535E40D6DA751BC6363F4000000000D81CF83F917CD901ED535E40BE65FD4FC6363F4000000000D81CF83F70208CEEEC535E403BDC20F0C6363F4000000040E2F3F73FF28E5BE5EC535E40EDB0084CC7363F400000000002E4F73FEE6C37DDEC535E4088FCB9BCC7363F400000000002E4F73F282511D5EC535E40CFE2BD51C8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F4B51D3D3EC535E40E742297DC8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F5AD1FDD4EC535E40D43B9DAAC9363F40000000C02069F73F', '2025-06-04 10:19:32.370267', '2025-06-04 10:19:32.370267', 'virtual', '["non_motor_vehicle","walker"]', 0, 'generate', 99, '0', '8645924713383591843', '8645924713383591842', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214884', 100001, '01020000A0E610000005000000932E26CBE3535E408A32ACC6B8363F40000000E034EFF83FDC552EA5E5535E40C594BFB0B9363F40000000808869F93F2F533A28E6535E40CB0F27F3B9363F40000000805F0DFA3F35CC036AE7535E40BE7629A8BA363F4000000040C7EAF93FC2227AAAE7535E40594C62CCBA363F4000000000BD13FA3F', '2025-06-04 10:19:39.750795', '2025-06-04 10:19:39.750795', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591815', '8645924713383591814', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214883', 100001, '01020000A0E610000006000000E2EA72DDE3535E40C0E6F1BBB6363F400000004033F3F83FA711BEEDE5535E40BA3A8BD4B7363F40000000A014EDF83F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93FC5016651E7535E40FB8DCF94B8363F40000000A02255F93F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93F24ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F', '2025-06-04 10:19:40.980054', '2025-06-04 10:19:40.980054', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591814', '8645924713383591813', 2, 1);
INSERT INTO public.lane VALUES ('8642723176041676757', 100001, '01020000A0E61000001400000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93FDAFD1B95EA535E402A916AF6C5363F4000000040810CFA3F94BC0A8EEA535E40E29AF16CC5363F40000000808BE3F93F636EF973EA535E40B3BF1920C4363F40000000808BE3F93FFC1E9766EA535E40492FF8A1C3363F40000000C095BAF93F7FB7993AEA535E40A3C8465FC2363F40000000C095BAF93FA9708529EA535E404FD2CEF9C1363F40000000E073CBF93F84C401EAE9535E403E1B7FC3C0363F40000000608879F93F472B40D9E9535E404A58077FC0363F40000000A09250F93FC33B4784E9535E405172545CBF363F40000000A09250F93F0AB16A78E9535E402DC7383ABF363F40000000E09C27F93F460D8A0CE9535E409365CD37BE363F4000000060F948F93F15F0D508E9535E407B337430BE363F4000000060F948F93F4D9FB58CE8535E40224D1A75BD363F40000000206B3FF93F6AC2D585E8535E40BD6F516DBD363F40000000206B3FF93FD1487CD5E7535E40B7B219E7BC363F40000000C004F5F83F39F46C0FE8535E40228CF00DBD363F40000000607516F93FE6C4B4F5E7535E40B1321AF9BC363F40000000C004F5F83FD1487CD5E7535E40B7B219E7BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 11:39:50.572189', '2025-06-04 11:39:50.573184', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271583', '8645782395347271584', 1, 1);
INSERT INTO public.lane VALUES ('8642723176041676778', 100001, '01020000A0E610000003000000183ECCA5EB535E40701ECDDFA4363F4000000080FD9EFA3F1691F679EB535E40F3608825B0363F4000000020B2BAFA3F13D44175EB535E40D5BD045DB1363F4000000060BC91FA3F', '2025-06-04 11:39:51.174953', '2025-06-04 11:39:51.174953', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271640', '8645782395347271639', 1, 1);
INSERT INTO public.lane VALUES ('8642723176041676777', 100001, '01020000A0E610000003000000EFCB6143EC535E404033DE0FA5363F40000000A0E94FFA3FC18E971FEC535E40057B3250B0363F4000000020DB16FA3F3E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F', '2025-06-04 11:39:51.779054', '2025-06-04 11:39:51.779054', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271639', '8645782395347271637', 2, 1);
INSERT INTO public.lane VALUES ('8644989441305214845', 100001, '01020000A0E6100000030000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F864C1DD7EB535E4011E9A5CCC7363F4000000000FD85F93FE1051ED3EB535E4081278815C9363F40000000801134F93F', '2025-06-03 17:46:22.28547', '2025-06-03 17:46:22.28547', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271613', '8645782395347271612', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214830', 100001, '01020000A0E610000005000000AB00D5FBEA535E40447D1EE5D8363F40000000A03B08F93FED066C2FEB535E402EEC52EBC9363F4000000000D429FA3F45A54625EB535E40A361DDEACC363F40000000A09920FA3FED066C2FEB535E402EEC52EBC9363F4000000000D429FA3FD7BE7133EB535E407CBFE0B9C8363F4000000080BF7BFA3F', '2025-06-03 17:47:11.612652', '2025-06-03 17:47:11.612652', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271283', '8645782395347271285', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214821', 100001, '01020000A0E610000004000000A22B20D3EB535E4004738C15C9363F40000000801134F93F9035A9BCEB535E40968224A2CE363F4000000060E101F93F31601A9DEB535E40D3CABFC1D7363F40000000605A8DF83F18F0CF98EB535E40D82935FFD8363F40000000A06464F83F', '2025-06-03 17:47:12.210455', '2025-06-03 17:47:12.210455', 'driving', NULL, 0, 'generate', 99, '0', '8645782395347271282', '8645782395347271280', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507233', 100001, '01020000A0E6100000030000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93FA5391CD7EB535E408E9DA1CCC7363F4000000000FD85F93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 10:58:41.043947', '2025-06-04 10:58:41.043947', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271613', '8645782395347271612', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507241', 100001, '01020000A0E61000001400000048A3CD34EB535E40408843BAC8363F4000000080BF7BFA3FF99CCD40EB535E40BEA7CD93C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 10:58:43.935021', '2025-06-04 10:58:43.935021', 'virtual', NULL, 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214848', 100001, '01020000A0E6100000150000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F908E8212EC535E4021E04854B3363F4000000020DB16FA3F6512B61EEC535E40036CD5E8B4363F40000000E04434FA3FF592C920EC535E402C6ADC0DB5363F40000000204F0BFA3FB4CBB73EEC535E40F6378C75B6363F400000002001EAF93F66F67E45EC535E40BA6C88B2B6363F40000000C0EC3BFA3FA8D59772EC535E4007E064F0B7363F400000002001EAF93FDD14707EEC535E409C325334B8363F40000000E0F612FA3FA97CD7B9EC535E40BFA7284DB9363F40000000E014B3F93F5938E6C8EC535E409BDAD588B9363F4000000020F62DFA3F79880713ED535E40004EB07EBA363F40000000A00ADCF93F81740A22ED535E40068B90A8BA363F40000000A00ADCF93F4C92BE7BED535E4011996678BB363F40000000602961F93F3CB70387ED535E407C0AED8DBB363F40000000602961F93F1AA4B0F0ED535E40A0B4B92FBC363F40000000005230F93F6B57F0F4ED535E40A07DC634BC363F40000000005230F93F2B35D1A0EE535E4064A696A8BC363F40000000405C07F93F341DF568EE535E40C35D8898BC363F400000008066DEF83F9CE13B6EEE535E4046656F9BBC363F40000000405C07F93F2B35D1A0EE535E4064A696A8BC363F40000000405C07F93FE25B3CE2EE535E40708D3FB9BC363F400000008066DEF83F', '2025-06-04 10:19:29.896038', '2025-06-04 10:19:29.896038', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271614', '8645782395347271615', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214851', 100001, '01020000A0E610000013000000F4E64275EB535E40D5BD045DB1363F4000000060BC91FA3F09A69A59EB535E403399368BB3363F4000000060BC91FA3FF66A9E28EB535E400E3B2667B5363F40000000A01101FB3F57A15320EB535E407F3AD4A5B5363F40000000A01101FB3FA1164BDDEA535E409CB9E03CB7363F40000000A01101FB3FC04AB2CCEA535E403D950690B7363F4000000000C307FB3F02DAD27AEA535E4095160AE5B8363F400000006068AEFA3F6D8B2D62EA535E40E31A533BB9363F400000006068AEFA3FC1916B03EA535E40FAA53451BA363F400000006068AEFA3FAC73A4E4E9535E40D6E2C09CBA363F400000006068AEFA3F7D3E537AE9535E407040E373BB363F40000000A07285FA3F6C522558E9535E40593606ACBB363F4000000060235EFA3FAE11A5E3E8535E40B290DC41BC363F40000000A02D35FA3F9C7CEAC0E8535E403AE51863BC363F400000002042E3F93F48B7B6D4E7535E407607A9C2BC363F40000000C004F5F83F00982144E8535E401CD301B3BC363F40000000E06068F93F2659B223E8535E40AB8DE9BDBC363F40000000607516F93F48B7B6D4E7535E407607A9C2BC363F40000000C004F5F83F98DD0A96E7535E40053077C3BC363F40000000C004F5F83F', '2025-06-04 10:19:36.662203', '2025-06-04 10:19:36.662203', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271617', '8645782395347271616', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214855', 100001, '01020000A0E61000001300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F307A2F3DE8535E4084AC16F4B8363F40000000E06068F93F36331E98E8535E40365884D7B8363F40000000604CBAF93F0A534ABEE8535E40D707E5BFB8363F40000000604CBAF93FC32F6C02E9535E4048665380B8363F40000000200AF4F93F4ABB313AE9535E40FB6BE939B8363F40000000E0FF1CFA3FB5BB8667E9535E40C611BFF0B7363F40000000E0FF1CFA3F1DA849ACE9535E40A83C8267B7363F4000000000EC63FA3F1AF228C5E9535E4079C75C2BB7363F4000000000EC63FA3F19105C10EA535E40F6097A51B6363F4000000040F63AFA3FEC2E2019EA535E40FCEA3533B6363F4000000040F63AFA3FE1560761EA535E4068944F0BB5363F4000000040F63AFA3F6306A962EA535E404A1C3503B5363F4000000040F63AFA3FC8010F9AEA535E40E0B878B7B3363F40000000A05DFEF93F6F4F0CA0EA535E4063A2C28AB3363F40000000204950FA3F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93F9D2E65C2EA535E406F764D43B2363F40000000A05DFEF93F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93F921E5BD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 10:19:37.908693', '2025-06-04 10:19:37.908693', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271618', '8645782395347271619', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214837', 100001, '01020000A0E61000000300000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93F30FE46D3EA535E40E0A8A551B2363F4000000020DB16FA3F921E5BD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 10:19:39.142247', '2025-06-04 10:19:39.142247', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271581', '8645782395347271582', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507256', 100001, '01020000A0E610000005000000E4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F71AAB530EB535E4033FB20F1C9363F4000000000D429FA3F77AFA426EB535E40566526EBCC363F40000000A09920FA3F71AAB530EB535E4033FB20F1C9363F4000000000D429FA3F48A3CD34EB535E40408843BAC8363F4000000080BF7BFA3F', '2025-06-04 10:58:51.415079', '2025-06-04 10:58:51.415079', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271283', '8645782395347271285', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507153', 100001, '01020000A0E6100000030000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93FA5391CD7EB535E408E9DA1CCC7363F4000000000FD85F93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 11:03:15.476845', '2025-06-04 11:03:15.476845', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271613', '8645782395347271612', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507161', 100001, '01020000A0E61000001400000048A3CD34EB535E40408843BAC8363F4000000080BF7BFA3FF99CCD40EB535E40BEA7CD93C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 11:03:24.480751', '2025-06-04 11:03:24.480751', 'virtual', 'null', 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507187', 100001, '01020000A0E61000001400000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93FDAFD1B95EA535E402A916AF6C5363F4000000040810CFA3F94BC0A8EEA535E40E29AF16CC5363F40000000808BE3F93F636EF973EA535E40B3BF1920C4363F40000000808BE3F93FFC1E9766EA535E40492FF8A1C3363F40000000C095BAF93F7FB7993AEA535E40A3C8465FC2363F40000000C095BAF93FA9708529EA535E404FD2CEF9C1363F40000000E073CBF93F84C401EAE9535E403E1B7FC3C0363F40000000608879F93F472B40D9E9535E404A58077FC0363F40000000A09250F93FC33B4784E9535E405172545CBF363F40000000A09250F93F0AB16A78E9535E402DC7383ABF363F40000000E09C27F93F460D8A0CE9535E409365CD37BE363F4000000060F948F93FC10BCF09E9535E40D46A6632BE363F4000000060F948F93FD24F2990E8535E40D5875670BD363F40000000E06068F93F06138986E8535E4081555364BD363F40000000206B3FF93F9BEC04D3E7535E40C92937DABC363F40000000C004F5F83FA4E34E0FE8535E40C3EA09F7BC363F40000000607516F93FC6866EF6E7535E40821285E7BC363F40000000C004F5F83F9BEC04D3E7535E40C92937DABC363F40000000C004F5F83F98DD0A96E7535E40053077C3BC363F40000000C004F5F83F', '2025-06-04 11:03:25.077337', '2025-06-04 11:03:25.077337', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271583', '8645782395347271584', 1, 1);
INSERT INTO public.lane VALUES ('8642735957864349638', 100001, '01020000A0E610000005000000E4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F71AAB530EB535E4033FB20F1C9363F4000000000D429FA3F77AFA426EB535E40566526EBCC363F40000000A09920FA3F71AAB530EB535E4033FB20F1C9363F4000000000D429FA3F48A3CD34EB535E40408843BAC8363F4000000080BF7BFA3F', '2025-06-04 11:36:26.046317', '2025-06-04 11:36:26.047314', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271283', '8645782395347271285', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214829', 100001, '01020000A0E610000005000000FBC65165EA535E406DB11ACCD8363F40000000802FC5F83F4C982E99EA535E400A403990C9363F40000000002485F93FEF8F5F8EEA535E409137BECBCC363F4000000040F573F93F4C982E99EA535E400A403990C9363F40000000002485F93F69FC209DEA535E40ED3D3963C8363F40000000C019AEF93F', '2025-06-04 10:19:28.03845', '2025-06-04 10:19:28.03845', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271285', '8645782395347271291', 2, 1);
INSERT INTO public.lane VALUES ('8644989441305214891', 100001, '01020000A0E610000014000000125AC5D1EB535E4040AA2915C9363F40000000801134F93F861C0F41EB535E406BA97290C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-03 17:28:42.774318', '2025-06-03 17:28:42.774318', 'virtual', NULL, 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214893', 100001, '01020000A0E610000015000000C2227AAAE7535E40594C62CCBA363F4000000000BD13FA3F3314AF66E8535E4065ABD0E2BA363F40000000A02D35FA3FDC0073FAE8535E4017B46047BB363F4000000060235EFA3FA58A3D0FE9535E40FF2A2A5CBB363F4000000060235EFA3F59EF5BA0E9535E40CFA63C1DBC363F40000000A07285FA3F8E3B5EAEE9535E40BD70F134BC363F40000000A07285FA3F5A84D939EA535E40752A8D56BD363F40000000A07285FA3FA7F8553FEA535E4087EC5B64BD363F400000006068AEFA3FF63ED9BDEA535E401B8FF1DFBE363F400000006036C1FA3F20CBB0C1EA535E40A46EB3EDBE363F400000006036C1FA3FA0275426EB535E40F7BEB19AC0363F4000000060B307FB3FF7F68B32EB535E40622757D9C0363F40000000A0BDDEFA3FFF78F176EB535E400267E283C2363F4000000040C3F7FA3FFA430D88EB535E40D8BC1C09C3363F4000000080CDCEFA3F743F9DAEEB535E40305CBD8DC4363F40000000C0D7A5FA3F95304FBEEB535E407DD77C69C5363F4000000040EC53FA3F710142CDEB535E404114BAB5C6363F40000000C00002FA3F645E4CD5EB535E405E4619C0C7363F4000000000FD85F93F0CD0E6D3EB535E40A09CF9B9C7363F4000000000FD85F93F645E4CD5EB535E405E4619C0C7363F4000000000FD85F93F125AC5D1EB535E4040AA2915C9363F40000000801134F93F', '2025-06-03 17:28:43.382538', '2025-06-03 17:28:43.382538', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271661', '8645782395347271660', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214814', 100001, '01020000A0E610000015000000C2227AAAE7535E40594C62CCBA363F4000000000BD13FA3F3314AF66E8535E4065ABD0E2BA363F40000000A02D35FA3FDC0073FAE8535E4017B46047BB363F4000000060235EFA3FA58A3D0FE9535E40FF2A2A5CBB363F4000000060235EFA3F59EF5BA0E9535E40CFA63C1DBC363F40000000A07285FA3F8E3B5EAEE9535E40BD70F134BC363F40000000A07285FA3F5A84D939EA535E40752A8D56BD363F40000000A07285FA3FA7F8553FEA535E4087EC5B64BD363F400000006068AEFA3FF63ED9BDEA535E401B8FF1DFBE363F400000006036C1FA3F20CBB0C1EA535E40A46EB3EDBE363F400000006036C1FA3FA0275426EB535E40F7BEB19AC0363F4000000060B307FB3FF7F68B32EB535E40622757D9C0363F40000000A0BDDEFA3FFF78F176EB535E400267E283C2363F4000000040C3F7FA3FFA430D88EB535E40D8BC1C09C3363F4000000080CDCEFA3F743F9DAEEB535E40305CBD8DC4363F40000000C0D7A5FA3F95304FBEEB535E407DD77C69C5363F4000000040EC53FA3F710142CDEB535E404114BAB5C6363F40000000C00002FA3F645E4CD5EB535E405E4619C0C7363F4000000000FD85F93F0CD0E6D3EB535E40A09CF9B9C7363F4000000000FD85F93F645E4CD5EB535E405E4619C0C7363F4000000000FD85F93FD7BE7133EB535E407CBFE0B9C8363F4000000080BF7BFA3F', '2025-06-03 17:29:50.494046', '2025-06-03 17:29:50.494046', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271661', '8645782395347271660', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507280', 100001, '01020000A0E61000001300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F307A2F3DE8535E4084AC16F4B8363F40000000E06068F93F36331E98E8535E40365884D7B8363F40000000604CBAF93F0A534ABEE8535E40D707E5BFB8363F40000000604CBAF93FC32F6C02E9535E4048665380B8363F40000000200AF4F93F4ABB313AE9535E40FB6BE939B8363F40000000E0FF1CFA3FB5BB8667E9535E40C611BFF0B7363F40000000E0FF1CFA3F1DA849ACE9535E40A83C8267B7363F4000000000EC63FA3F1AF228C5E9535E4079C75C2BB7363F4000000000EC63FA3F19105C10EA535E40F6097A51B6363F4000000040F63AFA3FEC2E2019EA535E40FCEA3533B6363F4000000040F63AFA3FE1560761EA535E4068944F0BB5363F4000000040F63AFA3F6306A962EA535E404A1C3503B5363F4000000040F63AFA3FC8010F9AEA535E40E0B878B7B3363F40000000A05DFEF93F6F4F0CA0EA535E4063A2C28AB3363F40000000204950FA3F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93F9D2E65C2EA535E406F764D43B2363F40000000A05DFEF93F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93F921E5BD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 10:58:38.706671', '2025-06-04 10:58:38.706671', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271618', '8645782395347271619', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214818', 100001, '01020000A0E610000014000000D7BE7133EB535E407CBFE0B9C8363F4000000080BF7BFA3F861C0F41EB535E406BA97290C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-03 17:46:22.896529', '2025-06-03 17:46:22.896529', 'virtual', NULL, 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507270', 100001, '01020000A0E6100000110000005C29BAE4EE535E40E6B320BABE363F40000000803114FA3FF48E8D1FEE535E405D7ED048BE363F4000000040273DFA3F35C12168ED535E4034801A6BBD363F4000000060D7A8FA3FC291AA67ED535E4034D1616ABD363F4000000060D7A8FA3F661FF9BDEC535E40F3F97C22BC363F4000000020CDD1FA3F6FEEC6BAEC535E403B89F41ABC363F4000000020CDD1FA3F5229FF25EC535E40DC9CFE77BA363F40000000C0260FFB3F89078522EC535E403B6E446CBA363F400000000031E6FA3F7DE7ECA4EB535E4096D0F075B8363F4000000020FD52FB3F3A1249A3EB535E40A279126EB8363F4000000020FD52FB3F2D438E40EB535E405B4E9531B6363F40000000A01101FB3FDA515D3FEB535E4073760F29B6363F40000000A01101FB3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3F915FC3FCEA535E40FD13F4C8B3363F4000000020B2BAFA3F4004C9F9EA535E40924747A4B3363F4000000060BC91FA3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 10:58:39.292687', '2025-06-04 10:58:39.292687', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271590', '8645782395347271591', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507265', 100001, '01020000A0E61000000300000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93F30FE46D3EA535E40E0A8A551B2363F4000000020DB16FA3F921E5BD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 10:58:39.882567', '2025-06-04 10:58:39.882567', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271581', '8645782395347271582', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507276', 100001, '01020000A0E610000013000000F4E64275EB535E40D5BD045DB1363F4000000060BC91FA3F09A69A59EB535E403399368BB3363F4000000060BC91FA3FF66A9E28EB535E400E3B2667B5363F40000000A01101FB3F57A15320EB535E407F3AD4A5B5363F40000000A01101FB3FA1164BDDEA535E409CB9E03CB7363F40000000A01101FB3FC04AB2CCEA535E403D950690B7363F4000000000C307FB3F02DAD27AEA535E4095160AE5B8363F400000006068AEFA3F6D8B2D62EA535E40E31A533BB9363F400000006068AEFA3FC1916B03EA535E40FAA53451BA363F400000006068AEFA3FAC73A4E4E9535E40D6E2C09CBA363F400000006068AEFA3F7D3E537AE9535E407040E373BB363F40000000A07285FA3F6C522558E9535E40593606ACBB363F4000000060235EFA3FAE11A5E3E8535E40B290DC41BC363F40000000A02D35FA3F9C7CEAC0E8535E403AE51863BC363F400000002042E3F93F48B7B6D4E7535E407607A9C2BC363F40000000C004F5F83F00982144E8535E401CD301B3BC363F40000000E06068F93F2659B223E8535E40AB8DE9BDBC363F40000000607516F93F48B7B6D4E7535E407607A9C2BC363F40000000C004F5F83F98DD0A96E7535E40053077C3BC363F40000000C004F5F83F', '2025-06-04 10:58:40.467051', '2025-06-04 10:58:40.467051', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271617', '8645782395347271616', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507305', 100001, '01020000A0E610000006000000E2EA72DDE3535E40C0E6F1BBB6363F400000004033F3F83FA711BEEDE5535E40BA3A8BD4B7363F40000000A014EDF83F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93FC5016651E7535E40FB8DCF94B8363F40000000A02255F93F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93F24ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F', '2025-06-04 10:58:41.625613', '2025-06-04 10:58:41.625613', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591814', '8645924713383591813', 2, 1);
INSERT INTO public.lane VALUES ('8642875801999507306', 100001, '01020000A0E610000005000000932E26CBE3535E408A32ACC6B8363F40000000E034EFF83FDC552EA5E5535E40C594BFB0B9363F40000000808869F93F2F533A28E6535E40CB0F27F3B9363F40000000805F0DFA3F35CC036AE7535E40BE7629A8BA363F4000000040C7EAF93FC2227AAAE7535E40594C62CCBA363F4000000000BD13FA3F', '2025-06-04 10:58:42.204653', '2025-06-04 10:58:42.204653', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591815', '8645924713383591814', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507302', 100001, '01020000A0E61000000500000098DD0A96E7535E4082E472C3BC363F40000000C004F5F83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F6065498DE4535E40BE82042ABB363F40000000E05D4BF83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F3AED54B9E3535E40E891CFC3BA363F4000000000183AF83F', '2025-06-04 10:58:43.36054', '2025-06-04 10:58:43.36054', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591816', '8645924713383591818', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507245', 100001, '01020000A0E610000015000000C2227AAAE7535E40594C62CCBA363F4000000000BD13FA3F3314AF66E8535E4065ABD0E2BA363F40000000A02D35FA3FDC0073FAE8535E4017B46047BB363F4000000060235EFA3FA58A3D0FE9535E40FF2A2A5CBB363F4000000060235EFA3F59EF5BA0E9535E40CFA63C1DBC363F40000000A07285FA3F8E3B5EAEE9535E40BD70F134BC363F40000000A07285FA3F5A84D939EA535E40752A8D56BD363F40000000A07285FA3FA7F8553FEA535E4087EC5B64BD363F400000006068AEFA3FF63ED9BDEA535E401B8FF1DFBE363F400000006036C1FA3F20CBB0C1EA535E40A46EB3EDBE363F400000006036C1FA3FA0275426EB535E40F7BEB19AC0363F4000000060B307FB3FF7F68B32EB535E40622757D9C0363F40000000A0BDDEFA3FFF78F176EB535E400267E283C2363F4000000040C3F7FA3FFA430D88EB535E40D8BC1C09C3363F4000000080CDCEFA3F743F9DAEEB535E40305CBD8DC4363F40000000C0D7A5FA3F95304FBEEB535E407DD77C69C5363F4000000040EC53FA3F710142CDEB535E404114BAB5C6363F40000000C00002FA3F951065D5EB535E405E4619C0C7363F4000000000FD85F93F6A97E3D3EB535E40C90E7DB9C7363F4000000000FD85F93F951065D5EB535E405E4619C0C7363F4000000000FD85F93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 10:58:44.511672', '2025-06-04 10:58:44.511672', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271661', '8645782395347271660', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507294', 100001, '01020000A0E6100000030000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F359A57D3E7535E406AFA7FE4BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 10:58:45.084954', '2025-06-04 10:58:45.084954', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271662', '8645782395347271663', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507267', 100001, '01020000A0E61000001400000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93FDAFD1B95EA535E402A916AF6C5363F4000000040810CFA3F94BC0A8EEA535E40E29AF16CC5363F40000000808BE3F93F636EF973EA535E40B3BF1920C4363F40000000808BE3F93FFC1E9766EA535E40492FF8A1C3363F40000000C095BAF93F7FB7993AEA535E40A3C8465FC2363F40000000C095BAF93FA9708529EA535E404FD2CEF9C1363F40000000E073CBF93F84C401EAE9535E403E1B7FC3C0363F40000000608879F93F472B40D9E9535E404A58077FC0363F40000000A09250F93FC33B4784E9535E405172545CBF363F40000000A09250F93F0AB16A78E9535E402DC7383ABF363F40000000E09C27F93F460D8A0CE9535E409365CD37BE363F4000000060F948F93FC10BCF09E9535E40D46A6632BE363F4000000060F948F93FD24F2990E8535E40D5875670BD363F40000000E06068F93F06138986E8535E4081555364BD363F40000000206B3FF93F79904DDBE7535E40CF7C22DDBC363F40000000C004F5F83FEEEB5D0FE8535E404CCD16F7BC363F40000000607516F93FA7996FF6E7535E40F3986FE7BC363F40000000C004F5F83F79904DDBE7535E40CF7C22DDBC363F40000000C004F5F83FCCB7739EE7535E402E5EDDC5BC363F40000000C004F5F83F', '2025-06-04 10:58:45.659159', '2025-06-04 10:58:45.659159', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271583', '8645782395347271584', 1, 1);
INSERT INTO public.lane VALUES ('8644945289041412077', 100001, '01020000A0E610000005000000AB00D5FBEA535E40447D1EE5D8363F40000000A03B08F93FE230A030EB535E40E64FB1F0C9363F4000000000D429FA3FB97D4A26EB535E404A3715EBCC363F40000000A09920FA3FE230A030EB535E40E64FB1F0C9363F4000000000D429FA3F28B6CE34EB535E40408843BAC8363F4000000080BF7BFA3F', '2025-06-04 10:19:28.655538', '2025-06-04 10:19:28.655538', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271283', '8645782395347271285', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507237', 100001, '01020000A0E6100000140000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F34611266EE535E40CD9D759AC0363F40000000805A70F93F20F45001EE535E401A1986BDC0363F40000000405099F93FF3D48DF1ED535E4044CCDBC7C0363F40000000805A70F93FB5F5488DED535E4097A8FF28C1363F40000000A0A7FAF93F8453A581ED535E409D9A2E38C1363F4000000020BCA8F93F7633A31FED535E40850D5EDAC1363F4000000040C67FF93F0DC6CF19ED535E4049C64BE6C1363F4000000040C67FF93F6E011DBDEC535E40E42023CBC2363F40000000E07B8DF93F6CA9D7BBEC535E40FCE7E0CEC2363F40000000E07B8DF93FE59B6D6EEC535E4054785BDFC3363F40000000205D08FA3FD73FE065EC535E40B9FE4603C4363F40000000205D08FA3F72F3322FEC535E409B2DB116C5363F400000004015B0F93F9C680121EC535E40E8E0B26DC5363F40000000801F87F93F287C3F00EC535E40D6A13567C6363F40000000801F87F93F592479F0EB535E406BAB6E02C7363F40000000801F87F93FD32B35E0EB535E40942780CAC7363F4000000040075DF93F150705E2EB535E40761A01C6C7363F4000000040075DF93FD32B35E0EB535E40942780CAC7363F4000000040075DF93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 10:58:46.235045', '2025-06-04 10:58:46.235045', 'virtual', NULL, 0, 'generate', 99, '0', '8645924713383591836', '8645924713383591853', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507273', 100001, '01020000A0E6100000150000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F908E8212EC535E4021E04854B3363F4000000020DB16FA3F6512B61EEC535E40036CD5E8B4363F40000000E04434FA3FF592C920EC535E402C6ADC0DB5363F40000000204F0BFA3FB4CBB73EEC535E40F6378C75B6363F400000002001EAF93F66F67E45EC535E40BA6C88B2B6363F40000000C0EC3BFA3FA8D59772EC535E4007E064F0B7363F400000002001EAF93FDD14707EEC535E409C325334B8363F40000000E0F612FA3FA97CD7B9EC535E40BFA7284DB9363F40000000E014B3F93F5938E6C8EC535E409BDAD588B9363F4000000020F62DFA3F79880713ED535E40004EB07EBA363F40000000A00ADCF93F81740A22ED535E40068B90A8BA363F40000000A00ADCF93F4C92BE7BED535E4011996678BB363F40000000602961F93F3CB70387ED535E407C0AED8DBB363F40000000602961F93F1AA4B0F0ED535E40A0B4B92FBC363F40000000005230F93F6B57F0F4ED535E40A07DC634BC363F40000000005230F93F2B35D1A0EE535E4064A696A8BC363F40000000405C07F93F341DF568EE535E40C35D8898BC363F400000008066DEF83F9CE13B6EEE535E4046656F9BBC363F40000000405C07F93F2B35D1A0EE535E4064A696A8BC363F40000000405C07F93FE25B3CE2EE535E40708D3FB9BC363F400000008066DEF83F', '2025-06-04 10:58:46.8087', '2025-06-04 10:58:46.8087', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271614', '8645782395347271615', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507285', 100001, '01020000A0E610000003000000EFCB6143EC535E404033DE0FA5363F40000000A0E94FFA3FC18E971FEC535E40057B3250B0363F4000000020DB16FA3F3E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F', '2025-06-04 10:58:47.38429', '2025-06-04 10:58:47.38429', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271639', '8645782395347271637', 2, 1);
INSERT INTO public.lane VALUES ('8642875801999507308', 100001, '01020000A0E61000001800000047DB93E8EE535E40730DB76CC2363F40000000601F2BF83F4DB70866EE535E40D2818998C2363F40000000601F2BF83F6AE30936EE535E40903F67BEC2363F40000000201554F83FBDA3DD20EE535E40D833E4D5C2363F40000000601F2BF83FD24B2CF3ED535E40AE2DFA12C3363F40000000E00A7DF83FC81A3AE5ED535E406D324028C3363F40000000201554F83F180405C7ED535E401F378761C3363F40000000201554F83F54E6119CED535E406C624EBEC3363F4000000060B997F83F1E97C49BED535E4072A80FBFC3363F4000000060B997F83F326CBD74ED535E40A2110932C4363F40000000E0A4E9F83F51CAED5CED535E40079C3D81C4363F40000000E0A4E9F83FD4C7F54FED535E400CBC7EB4C4363F4000000020AFC0F83F991E292FED535E407D582346C5363F4000000060B997F83F5D6FC629ED535E40189C4260C5363F4000000060B997F83F144DCD09ED535E40D6DA751BC6363F4000000000D81CF83F917CD901ED535E40BE65FD4FC6363F4000000000D81CF83F70208CEEEC535E403BDC20F0C6363F4000000040E2F3F73FF28E5BE5EC535E40EDB0084CC7363F400000000002E4F73FEE6C37DDEC535E4088FCB9BCC7363F400000000002E4F73F282511D5EC535E40CFE2BD51C8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F4B51D3D3EC535E40E742297DC8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F5AD1FDD4EC535E40D43B9DAAC9363F40000000C02069F73F', '2025-06-04 10:58:47.960198', '2025-06-04 10:58:47.960198', 'virtual', '["non_motor_vehicle","walker"]', 0, 'generate', 99, '0', '8645924713383591843', '8645924713383591842', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507300', 100001, '01020000A0E610000004000000E25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83FC359A750F1535E40CEE61D19BE363F40000000608330F83FBE6DFC42F5535E407A502051C0363F4000000040500BF73F0AE9A281F5535E40E5BE5B74C0363F40000000001DD8F73F', '2025-06-04 10:58:48.539976', '2025-06-04 10:58:48.539976', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591798', '8645924713383591800', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507298', 100001, '01020000A0E610000006000000E647666FF5535E405BB4DF5EC2363F40000000C066EBF73F7AE31B3FF1535E409852C20CC0363F40000000605AD4F83F58054923EF535E4063E775DDBE363F40000000002F01FA3F229B589EEF535E408CA8F322BF363F4000000000585DF93F58054923EF535E4063E775DDBE363F40000000002F01FA3F5C29BAE4EE535E40E6B320BABE363F40000000803114FA3F', '2025-06-04 10:58:49.113052', '2025-06-04 10:58:49.113052', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591799', '8645924713383591876', 1, 1);
INSERT INTO public.lane VALUES ('8644945289041412068', 100001, '01020000A0E610000014000000A22B20D3EB535E4004738C15C9363F40000000801134F93FF99CCD40EB535E40BEA7CD93C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-03 17:51:16.455062', '2025-06-03 17:51:16.455062', 'virtual', NULL, 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8644945289041412072', 100001, '01020000A0E610000015000000C2227AAAE7535E40594C62CCBA363F4000000000BD13FA3F3314AF66E8535E4065ABD0E2BA363F40000000A02D35FA3FDC0073FAE8535E4017B46047BB363F4000000060235EFA3FA58A3D0FE9535E40FF2A2A5CBB363F4000000060235EFA3F59EF5BA0E9535E40CFA63C1DBC363F40000000A07285FA3F8E3B5EAEE9535E40BD70F134BC363F40000000A07285FA3F5A84D939EA535E40752A8D56BD363F40000000A07285FA3FA7F8553FEA535E4087EC5B64BD363F400000006068AEFA3FF63ED9BDEA535E401B8FF1DFBE363F400000006036C1FA3F20CBB0C1EA535E40A46EB3EDBE363F400000006036C1FA3FA0275426EB535E40F7BEB19AC0363F4000000060B307FB3FF7F68B32EB535E40622757D9C0363F40000000A0BDDEFA3FFF78F176EB535E400267E283C2363F4000000040C3F7FA3FFA430D88EB535E40D8BC1C09C3363F4000000080CDCEFA3F743F9DAEEB535E40305CBD8DC4363F40000000C0D7A5FA3F95304FBEEB535E407DD77C69C5363F4000000040EC53FA3F710142CDEB535E404114BAB5C6363F40000000C00002FA3F951065D5EB535E405E4619C0C7363F4000000000FD85F93F6A97E3D3EB535E40C90E7DB9C7363F4000000000FD85F93F951065D5EB535E405E4619C0C7363F4000000000FD85F93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-03 17:51:17.059223', '2025-06-03 17:51:17.059223', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271661', '8645782395347271660', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507297', 100001, '01020000A0E610000007000000DFE39D5AF5535E40AD120647C4363F40000000C08F47F73F6CB106E8F1535E40087F9160C2363F40000000809B68F73F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93FB743268DEF535E402091A20DC1363F40000000C076E2F83F11928B85EF535E40A3C25209C1363F400000000081B9F83F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93F4A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F', '2025-06-04 10:58:49.68711', '2025-06-04 10:58:49.68711', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591876', '8645924713383591870', 2, 1);
INSERT INTO public.lane VALUES ('8642946617420283904', 100001, '01020000A0E610000015000000C2227AAAE7535E40594C62CCBA363F4000000000BD13FA3F3314AF66E8535E4065ABD0E2BA363F40000000A02D35FA3FDC0073FAE8535E4017B46047BB363F4000000060235EFA3FA58A3D0FE9535E40FF2A2A5CBB363F4000000060235EFA3F59EF5BA0E9535E40CFA63C1DBC363F40000000A07285FA3F8E3B5EAEE9535E40BD70F134BC363F40000000A07285FA3F5A84D939EA535E40752A8D56BD363F40000000A07285FA3FA7F8553FEA535E4087EC5B64BD363F400000006068AEFA3FF63ED9BDEA535E401B8FF1DFBE363F400000006036C1FA3F20CBB0C1EA535E40A46EB3EDBE363F400000006036C1FA3FA0275426EB535E40F7BEB19AC0363F4000000060B307FB3FF7F68B32EB535E40622757D9C0363F40000000A0BDDEFA3FFF78F176EB535E400267E283C2363F4000000040C3F7FA3FFA430D88EB535E40D8BC1C09C3363F4000000080CDCEFA3F743F9DAEEB535E40305CBD8DC4363F40000000C0D7A5FA3F95304FBEEB535E407DD77C69C5363F4000000040EC53FA3F710142CDEB535E404114BAB5C6363F40000000C00002FA3F951065D5EB535E405E4619C0C7363F4000000000FD85F93F6A97E3D3EB535E40C90E7DB9C7363F4000000000FD85F93F951065D5EB535E405E4619C0C7363F4000000000FD85F93F48A3CD34EB535E40408843BAC8363F4000000080BF7BFA3F', '2025-06-04 09:51:13.09048', '2025-06-04 09:51:13.09048', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271661', '8645782395347271660', 1, 1);
INSERT INTO public.lane VALUES ('8644945289041412055', 100001, '01020000A0E610000015000000C2227AAAE7535E40594C62CCBA363F4000000000BD13FA3F3314AF66E8535E4065ABD0E2BA363F40000000A02D35FA3FDC0073FAE8535E4017B46047BB363F4000000060235EFA3FA58A3D0FE9535E40FF2A2A5CBB363F4000000060235EFA3F59EF5BA0E9535E40CFA63C1DBC363F40000000A07285FA3F8E3B5EAEE9535E40BD70F134BC363F40000000A07285FA3F5A84D939EA535E40752A8D56BD363F40000000A07285FA3FA7F8553FEA535E4087EC5B64BD363F400000006068AEFA3FF63ED9BDEA535E401B8FF1DFBE363F400000006036C1FA3F20CBB0C1EA535E40A46EB3EDBE363F400000006036C1FA3FA0275426EB535E40F7BEB19AC0363F4000000060B307FB3FF7F68B32EB535E40622757D9C0363F40000000A0BDDEFA3FFF78F176EB535E400267E283C2363F4000000040C3F7FA3FFA430D88EB535E40D8BC1C09C3363F4000000080CDCEFA3F743F9DAEEB535E40305CBD8DC4363F40000000C0D7A5FA3F95304FBEEB535E407DD77C69C5363F4000000040EC53FA3F710142CDEB535E404114BAB5C6363F40000000C00002FA3F951065D5EB535E405E4619C0C7363F4000000000FD85F93F6A97E3D3EB535E40C90E7DB9C7363F4000000000FD85F93F951065D5EB535E405E4619C0C7363F4000000000FD85F93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 09:49:56.57703', '2025-06-04 09:49:56.57703', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271661', '8645782395347271660', 1, 1);
INSERT INTO public.lane VALUES ('8642946617420283899', 100001, '01020000A0E610000015000000C2227AAAE7535E40594C62CCBA363F4000000000BD13FA3F3314AF66E8535E4065ABD0E2BA363F40000000A02D35FA3FDC0073FAE8535E4017B46047BB363F4000000060235EFA3FA58A3D0FE9535E40FF2A2A5CBB363F4000000060235EFA3F59EF5BA0E9535E40CFA63C1DBC363F40000000A07285FA3F8E3B5EAEE9535E40BD70F134BC363F40000000A07285FA3F5A84D939EA535E40752A8D56BD363F40000000A07285FA3FA7F8553FEA535E4087EC5B64BD363F400000006068AEFA3FF63ED9BDEA535E401B8FF1DFBE363F400000006036C1FA3F20CBB0C1EA535E40A46EB3EDBE363F400000006036C1FA3FA0275426EB535E40F7BEB19AC0363F4000000060B307FB3FF7F68B32EB535E40622757D9C0363F40000000A0BDDEFA3FFF78F176EB535E400267E283C2363F4000000040C3F7FA3FFA430D88EB535E40D8BC1C09C3363F4000000080CDCEFA3F743F9DAEEB535E40305CBD8DC4363F40000000C0D7A5FA3F95304FBEEB535E407DD77C69C5363F4000000040EC53FA3F710142CDEB535E404114BAB5C6363F40000000C00002FA3F951065D5EB535E405E4619C0C7363F4000000000FD85F93F6A97E3D3EB535E40C90E7DB9C7363F4000000000FD85F93F951065D5EB535E405E4619C0C7363F4000000000FD85F93F48A3CD34EB535E40408843BAC8363F4000000080BF7BFA3F', '2025-06-04 09:55:06.396934', '2025-06-04 09:55:06.396934', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271661', '8645782395347271660', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507286', 100001, '01020000A0E610000003000000183ECCA5EB535E40701ECDDFA4363F4000000080FD9EFA3FF7A3F779EB535E4076AC8C25B0363F4000000020B2BAFA3FF4E64275EB535E40D5BD045DB1363F4000000060BC91FA3F', '2025-06-04 10:58:50.260694', '2025-06-04 10:58:50.260694', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271640', '8645782395347271639', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214834', 100001, '01020000A0E61000000600000044447194EA535E40DB050E5EF7363F4000000040D7F0F73FB25858AAEA535E407361B6FAF0363F400000000069EAF83F64EEBAB4EA535E40E0629EC5ED363F400000000069EAF83F572447B6EA535E4004DEAB51ED363F40000000206D0EF93F08121BF9EA535E4019D65215DA363F40000000603131F93FE4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F', '2025-06-04 10:19:26.147944', '2025-06-04 10:19:26.147944', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558709', '8645275692285558705', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214833', 100001, '01020000A0E610000006000000F9A0B8FAE9535E40341C183EF7363F40000000C0EB9EF73F3661F811EA535E40B4BD2CD9F0363F40000000009246F83FB0C08F1EEA535E403F018B31ED363F4000000020966AF83FD03C5D36EA535E40D83D9865E6363F40000000E0C22CF83F05E13A61EA535E4090574DFBD9363F40000000C0399CF83FFBC65165EA535E406DB11ACCD8363F40000000802FC5F83F', '2025-06-04 10:19:26.79621', '2025-06-04 10:19:26.797208', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645275692285558705', '8645275692285558706', 2, 1);
INSERT INTO public.lane VALUES ('8644945289041412075', 100001, '01020000A0E610000004000000A22B20D3EB535E4004738C15C9363F40000000801134F93F9035A9BCEB535E40968224A2CE363F4000000060E101F93F31601A9DEB535E40D3CABFC1D7363F40000000605A8DF83F18F0CF98EB535E40D82935FFD8363F40000000A06464F83F', '2025-06-04 10:19:29.277122', '2025-06-04 10:19:29.277122', 'driving', NULL, 0, 'generate', 99, '0', '8645782395347271282', '8645782395347271280', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214873', 100001, '01020000A0E610000007000000DFE39D5AF5535E40AD120647C4363F40000000C08F47F73F6CB106E8F1535E40087F9160C2363F40000000809B68F73F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93FB743268DEF535E402091A20DC1363F40000000C076E2F83F11928B85EF535E40A3C25209C1363F400000000081B9F83F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93F4A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F', '2025-06-04 10:19:30.522364', '2025-06-04 10:19:30.522364', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591876', '8645924713383591870', 2, 1);
INSERT INTO public.lane VALUES ('8644989441305214874', 100001, '01020000A0E610000006000000E647666FF5535E405BB4DF5EC2363F40000000C066EBF73F7AE31B3FF1535E409852C20CC0363F40000000605AD4F83F58054923EF535E4063E775DDBE363F40000000002F01FA3F229B589EEF535E408CA8F322BF363F4000000000585DF93F58054923EF535E4063E775DDBE363F40000000002F01FA3F5C29BAE4EE535E40E6B320BABE363F40000000803114FA3F', '2025-06-04 10:19:31.144826', '2025-06-04 10:19:31.144826', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591799', '8645924713383591876', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214877', 100001, '01020000A0E610000004000000E25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83FC359A750F1535E40CEE61D19BE363F40000000608330F83FBE6DFC42F5535E407A502051C0363F4000000040500BF73F0AE9A281F5535E40E5BE5B74C0363F40000000001DD8F73F', '2025-06-04 10:19:31.758543', '2025-06-04 10:19:31.758543', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591798', '8645924713383591800', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214865', 100001, '01020000A0E61000000300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F036CDAA1EE535E40114D1596BC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 10:19:32.992105', '2025-06-04 10:19:32.992105', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271659', '8645782395347271658', 1, 1);
INSERT INTO public.lane VALUES ('8642933182762582016', 100001, '01020000A0E610000015000000C2227AAAE7535E40594C62CCBA363F4000000000BD13FA3F3314AF66E8535E4065ABD0E2BA363F40000000A02D35FA3FDC0073FAE8535E4017B46047BB363F4000000060235EFA3FA58A3D0FE9535E40FF2A2A5CBB363F4000000060235EFA3F59EF5BA0E9535E40CFA63C1DBC363F40000000A07285FA3F8E3B5EAEE9535E40BD70F134BC363F40000000A07285FA3F5A84D939EA535E40752A8D56BD363F40000000A07285FA3FA7F8553FEA535E4087EC5B64BD363F400000006068AEFA3FF63ED9BDEA535E401B8FF1DFBE363F400000006036C1FA3F20CBB0C1EA535E40A46EB3EDBE363F400000006036C1FA3FA0275426EB535E40F7BEB19AC0363F4000000060B307FB3FF7F68B32EB535E40622757D9C0363F40000000A0BDDEFA3FFF78F176EB535E400267E283C2363F4000000040C3F7FA3FFA430D88EB535E40D8BC1C09C3363F4000000080CDCEFA3F743F9DAEEB535E40305CBD8DC4363F40000000C0D7A5FA3F95304FBEEB535E407DD77C69C5363F4000000040EC53FA3F710142CDEB535E404114BAB5C6363F40000000C00002FA3F951065D5EB535E405E4619C0C7363F4000000000FD85F93F6A97E3D3EB535E40C90E7DB9C7363F4000000000FD85F93F951065D5EB535E405E4619C0C7363F4000000000FD85F93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 10:19:33.602223', '2025-06-04 10:19:33.602223', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271661', '8645782395347271660', 1, 1);
INSERT INTO public.lane VALUES ('8644945289041412058', 100001, '01020000A0E61000001400000048A3CD34EB535E40408843BAC8363F4000000080BF7BFA3FF99CCD40EB535E40BEA7CD93C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 10:19:34.212027', '2025-06-04 10:19:34.212027', 'virtual', NULL, 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214869', 100001, '01020000A0E6100000030000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F359A57D3E7535E406AFA7FE4BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 10:19:34.825927', '2025-06-04 10:19:34.825927', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271662', '8645782395347271663', 1, 1);
INSERT INTO public.lane VALUES ('8644945289041412064', 100001, '01020000A0E6100000140000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F34611266EE535E40CD9D759AC0363F40000000805A70F93F20F45001EE535E401A1986BDC0363F40000000405099F93FF3D48DF1ED535E4044CCDBC7C0363F40000000805A70F93FB5F5488DED535E4097A8FF28C1363F40000000A0A7FAF93F8453A581ED535E409D9A2E38C1363F4000000020BCA8F93F7633A31FED535E40850D5EDAC1363F4000000040C67FF93F0DC6CF19ED535E4049C64BE6C1363F4000000040C67FF93F6E011DBDEC535E40E42023CBC2363F40000000E07B8DF93F6CA9D7BBEC535E40FCE7E0CEC2363F40000000E07B8DF93FE59B6D6EEC535E4054785BDFC3363F40000000205D08FA3FD73FE065EC535E40B9FE4603C4363F40000000205D08FA3F72F3322FEC535E409B2DB116C5363F400000004015B0F93F9C680121EC535E40E8E0B26DC5363F40000000801F87F93F287C3F00EC535E40D6A13567C6363F40000000801F87F93F592479F0EB535E406BAB6E02C7363F40000000801F87F93FB43E36E0EB535E4011DC7BCAC7363F4000000040075DF93F150705E2EB535E40761A01C6C7363F4000000040075DF93FB43E36E0EB535E4011DC7BCAC7363F4000000040075DF93FE1051ED3EB535E4081278815C9363F40000000801134F93F', '2025-06-04 10:19:35.443035', '2025-06-04 10:19:35.444033', 'virtual', NULL, 0, 'generate', 99, '0', '8645924713383591836', '8645924713383591853', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214839', 100001, '01020000A0E61000001400000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93FDAFD1B95EA535E402A916AF6C5363F4000000040810CFA3F94BC0A8EEA535E40E29AF16CC5363F40000000808BE3F93F636EF973EA535E40B3BF1920C4363F40000000808BE3F93FFC1E9766EA535E40492FF8A1C3363F40000000C095BAF93F7FB7993AEA535E40A3C8465FC2363F40000000C095BAF93FA9708529EA535E404FD2CEF9C1363F40000000E073CBF93F84C401EAE9535E403E1B7FC3C0363F40000000608879F93F472B40D9E9535E404A58077FC0363F40000000A09250F93FC33B4784E9535E405172545CBF363F40000000A09250F93F0AB16A78E9535E402DC7383ABF363F40000000E09C27F93F460D8A0CE9535E409365CD37BE363F4000000060F948F93FC10BCF09E9535E40D46A6632BE363F4000000060F948F93FD24F2990E8535E40D5875670BD363F40000000E06068F93F06138986E8535E4081555364BD363F40000000206B3FF93F79904DDBE7535E40CF7C22DDBC363F40000000C004F5F83FEEEB5D0FE8535E404CCD16F7BC363F40000000607516F93FA7996FF6E7535E40F3986FE7BC363F40000000C004F5F83F79904DDBE7535E40CF7C22DDBC363F40000000C004F5F83FCCB7739EE7535E402E5EDDC5BC363F40000000C004F5F83F', '2025-06-04 10:19:36.053245', '2025-06-04 10:19:36.053245', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271583', '8645782395347271584', 1, 1);
INSERT INTO public.lane VALUES ('8644945289041412061', 100001, '01020000A0E6100000030000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F864C1DD7EB535E4011E9A5CCC7363F4000000000FD85F93FE1051ED3EB535E4081278815C9363F40000000801134F93F', '2025-06-04 10:19:37.274793', '2025-06-04 10:19:37.274793', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271613', '8645782395347271612', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214842', 100001, '01020000A0E6100000110000005C29BAE4EE535E40E6B320BABE363F40000000803114FA3FF48E8D1FEE535E405D7ED048BE363F4000000040273DFA3F35C12168ED535E4034801A6BBD363F4000000060D7A8FA3FC291AA67ED535E4034D1616ABD363F4000000060D7A8FA3F661FF9BDEC535E40F3F97C22BC363F4000000020CDD1FA3F6FEEC6BAEC535E403B89F41ABC363F4000000020CDD1FA3F5229FF25EC535E40DC9CFE77BA363F40000000C0260FFB3F89078522EC535E403B6E446CBA363F400000000031E6FA3F7DE7ECA4EB535E4096D0F075B8363F4000000020FD52FB3F3A1249A3EB535E40A279126EB8363F4000000020FD52FB3F2D438E40EB535E405B4E9531B6363F40000000A01101FB3FDA515D3FEB535E4073760F29B6363F40000000A01101FB3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3F915FC3FCEA535E40FD13F4C8B3363F4000000020B2BAFA3F4004C9F9EA535E40924747A4B3363F4000000060BC91FA3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 10:19:38.536007', '2025-06-04 10:19:38.536007', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271590', '8645782395347271591', 1, 1);
INSERT INTO public.lane VALUES ('8644989441305214879', 100001, '01020000A0E61000000500000098DD0A96E7535E4082E472C3BC363F40000000C004F5F83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F6065498DE4535E40BE82042ABB363F40000000E05D4BF83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F3AED54B9E3535E40E891CFC3BA363F4000000000183AF83F', '2025-06-04 10:19:40.369978', '2025-06-04 10:19:40.369978', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591816', '8645924713383591818', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507282', 100001, '01020000A0E610000003000000921E5BD6EA535E40E7F2510CB1363F40000000E0F99BF93F4096E203EB535E4028B1EAFAA5363F40000000600BCFFA3FAEF13109EB535E40D55809B0A4363F40000000C00776FA3F', '2025-06-04 10:58:50.838439', '2025-06-04 10:58:50.838439', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271633', '8645782395347271634', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507255', 100001, '01020000A0E610000005000000FBC65165EA535E406DB11ACCD8363F40000000802FC5F83F4C982E99EA535E400A403990C9363F40000000002485F93FEF8F5F8EEA535E409137BECBCC363F4000000040F573F93F4C982E99EA535E400A403990C9363F40000000002485F93F69FC209DEA535E40ED3D3963C8363F40000000C019AEF93F', '2025-06-04 10:58:51.990028', '2025-06-04 10:58:51.990028', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271285', '8645782395347271291', 2, 1);
INSERT INTO public.lane VALUES ('8642875801999507248', 100001, '01020000A0E610000004000000A22B20D3EB535E4004738C15C9363F40000000801134F93F9035A9BCEB535E40968224A2CE363F4000000060E101F93F31601A9DEB535E40D3CABFC1D7363F40000000605A8DF83F18F0CF98EB535E40D82935FFD8363F40000000A06464F83F', '2025-06-04 10:58:52.5664', '2025-06-04 10:58:52.5664', 'driving', 'null', 0, 'generate', 99, '0', '8645782395347271282', '8645782395347271280', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646096', 100001, '01020000A0E61000000A000000AF053CB7F0535E4013467196AB363F4000000040E17AF4BFC61239F1F3535E40C7518698B5363F4000000040E17AF4BF70664F5DF4535E4014C1BB39B5363F4000000040E17AF4BFEAFA8CABF4535E403F5080BEB3363F4000000040E17AF4BFE7A528B8F4535E40DAA2B822B2363F4000000040E17AF4BF805030C6F4535E4066695B58AD363F4000000040E17AF4BFAB92BECCF4535E40D7D5429BAC363F4000000040E17AF4BF8759D2CBF4535E40A8141DC4AC363F4000000040E17AF4BFAB92BECCF4535E40D7D5429BAC363F4000000040E17AF4BF2CBA25D4F4535E40DEEE913FAB363F4000000040E17AF4BF', '2025-06-04 16:55:55.056865', '2025-06-04 16:55:55.056865', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '1', '8642101470935646121', '8642101470935646120', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507262', 100001, '01020000A0E61000000600000044447194EA535E40DB050E5EF7363F4000000040D7F0F73FB25858AAEA535E407361B6FAF0363F400000000069EAF83F64EEBAB4EA535E40E0629EC5ED363F400000000069EAF83F572447B6EA535E4004DEAB51ED363F40000000206D0EF93F08121BF9EA535E4019D65215DA363F40000000603131F93FE4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F', '2025-06-04 10:59:04.919154', '2025-06-04 10:59:04.919154', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558709', '8645275692285558705', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507261', 100001, '01020000A0E610000006000000F9A0B8FAE9535E40341C183EF7363F40000000C0EB9EF73F3661F811EA535E40B4BD2CD9F0363F40000000009246F83FB0C08F1EEA535E403F018B31ED363F4000000020966AF83FD03C5D36EA535E40D83D9865E6363F40000000E0C22CF83F05E13A61EA535E4090574DFBD9363F40000000C0399CF83FFBC65165EA535E406DB11ACCD8363F40000000802FC5F83F', '2025-06-04 10:59:05.503268', '2025-06-04 10:59:05.503268', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645275692285558705', '8645275692285558706', 2, 1);
INSERT INTO public.lane VALUES ('8642875801999507258', 100001, '01020000A0E61000000600000018F0CF98EB535E40D82935FFD8363F40000000A06464F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73F33AD8255EB535E40049892E2EC363F40000000807640F83F062D0352EB535E40E5FAA4FEED363F40000000E09D11F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73FE8E1FC34EB535E408783C18BF7363F400000008030F0F73F', '2025-06-04 10:59:06.082314', '2025-06-04 10:59:06.082314', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558708', '8645275692285558707', 1, 1);
INSERT INTO public.lane VALUES ('8642723176041676761', 100001, '01020000A0E6100000110000005C29BAE4EE535E40E6B320BABE363F40000000803114FA3FF48E8D1FEE535E405D7ED048BE363F4000000040273DFA3F35C12168ED535E4034801A6BBD363F4000000060D7A8FA3FC291AA67ED535E4034D1616ABD363F4000000060D7A8FA3F661FF9BDEC535E40F3F97C22BC363F4000000020CDD1FA3F6FEEC6BAEC535E403B89F41ABC363F4000000020CDD1FA3F5229FF25EC535E40DC9CFE77BA363F40000000C0260FFB3F89078522EC535E403B6E446CBA363F400000000031E6FA3F7DE7ECA4EB535E4096D0F075B8363F4000000020FD52FB3F3A1249A3EB535E40A279126EB8363F4000000020FD52FB3F2D438E40EB535E405B4E9531B6363F40000000A01101FB3FDA515D3FEB535E4073760F29B6363F40000000A01101FB3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3F915FC3FCEA535E40FD13F4C8B3363F4000000020B2BAFA3F4004C9F9EA535E40924747A4B3363F4000000060BC91FA3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 11:39:52.381225', '2025-06-04 11:39:52.381225', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271590', '8645782395347271591', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507190', 100001, '01020000A0E6100000110000005C29BAE4EE535E40E6B320BABE363F40000000803114FA3FF48E8D1FEE535E405D7ED048BE363F4000000040273DFA3F35C12168ED535E4034801A6BBD363F4000000060D7A8FA3FC291AA67ED535E4034D1616ABD363F4000000060D7A8FA3F661FF9BDEC535E40F3F97C22BC363F4000000020CDD1FA3F6FEEC6BAEC535E403B89F41ABC363F4000000020CDD1FA3F5229FF25EC535E40DC9CFE77BA363F40000000C0260FFB3F89078522EC535E403B6E446CBA363F400000000031E6FA3F7DE7ECA4EB535E4096D0F075B8363F4000000020FD52FB3F3A1249A3EB535E40A279126EB8363F4000000020FD52FB3F2D438E40EB535E405B4E9531B6363F40000000A01101FB3FDA515D3FEB535E4073760F29B6363F40000000A01101FB3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3F915FC3FCEA535E40FD13F4C8B3363F4000000020B2BAFA3F4004C9F9EA535E40924747A4B3363F4000000060BC91FA3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 11:03:14.268083', '2025-06-04 11:03:14.268083', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271590', '8645782395347271591', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507197', 100001, '01020000A0E610000013000000F4E64275EB535E40D5BD045DB1363F4000000060BC91FA3F09A69A59EB535E403399368BB3363F4000000060BC91FA3FF66A9E28EB535E400E3B2667B5363F40000000A01101FB3F57A15320EB535E407F3AD4A5B5363F40000000A01101FB3FA1164BDDEA535E409CB9E03CB7363F40000000A01101FB3FC04AB2CCEA535E403D950690B7363F4000000000C307FB3F02DAD27AEA535E4095160AE5B8363F400000006068AEFA3F6D8B2D62EA535E40E31A533BB9363F400000006068AEFA3FC1916B03EA535E40FAA53451BA363F400000006068AEFA3FAC73A4E4E9535E40D6E2C09CBA363F400000006068AEFA3F7D3E537AE9535E407040E373BB363F40000000A07285FA3F6C522558E9535E40593606ACBB363F4000000060235EFA3FAE11A5E3E8535E40B290DC41BC363F40000000A02D35FA3F9C7CEAC0E8535E403AE51863BC363F400000002042E3F93F48B7B6D4E7535E407607A9C2BC363F40000000C004F5F83F00982144E8535E401CD301B3BC363F40000000E06068F93F2659B223E8535E40AB8DE9BDBC363F40000000607516F93F48B7B6D4E7535E407607A9C2BC363F40000000C004F5F83F98DD0A96E7535E40053077C3BC363F40000000C004F5F83F', '2025-06-04 11:03:14.871945', '2025-06-04 11:03:14.871945', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271617', '8645782395347271616', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507226', 100001, '01020000A0E610000006000000E2EA72DDE3535E40C0E6F1BBB6363F400000004033F3F83FA711BEEDE5535E40BA3A8BD4B7363F40000000A014EDF83F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93FC5016651E7535E40FB8DCF94B8363F40000000A02255F93F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93F24ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F', '2025-06-04 11:03:16.083555', '2025-06-04 11:03:16.083555', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591814', '8645924713383591813', 2, 1);
INSERT INTO public.lane VALUES ('8642875801999507175', 100001, '01020000A0E610000005000000FBC65165EA535E406DB11ACCD8363F40000000802FC5F83F4C982E99EA535E400A403990C9363F40000000002485F93FEF8F5F8EEA535E409137BECBCC363F4000000040F573F93F4C982E99EA535E400A403990C9363F40000000002485F93F69FC209DEA535E40ED3D3963C8363F40000000C019AEF93F', '2025-06-04 11:03:16.681536', '2025-06-04 11:03:16.681536', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271285', '8645782395347271291', 2, 1);
INSERT INTO public.lane VALUES ('8642875801999507176', 100001, '01020000A0E610000005000000E4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F71AAB530EB535E4033FB20F1C9363F4000000000D429FA3F77AFA426EB535E40566526EBCC363F40000000A09920FA3F71AAB530EB535E4033FB20F1C9363F4000000000D429FA3F48A3CD34EB535E40408843BAC8363F4000000080BF7BFA3F', '2025-06-04 11:03:17.280411', '2025-06-04 11:03:17.280411', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271283', '8645782395347271285', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507168', 100001, '01020000A0E610000004000000A22B20D3EB535E4004738C15C9363F40000000801134F93F9035A9BCEB535E40968224A2CE363F4000000060E101F93F31601A9DEB535E40D3CABFC1D7363F40000000605A8DF83F18F0CF98EB535E40D82935FFD8363F40000000A06464F83F', '2025-06-04 11:03:17.878476', '2025-06-04 11:03:17.878476', 'driving', 'null', 0, 'generate', 99, '0', '8645782395347271282', '8645782395347271280', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507194', 100001, '01020000A0E6100000160000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F908E8212EC535E4021E04854B3363F4000000020DB16FA3F6512B61EEC535E40036CD5E8B4363F40000000E04434FA3FF592C920EC535E402C6ADC0DB5363F40000000204F0BFA3FB4CBB73EEC535E40F6378C75B6363F400000002001EAF93F66F67E45EC535E40BA6C88B2B6363F40000000C0EC3BFA3FA8D59772EC535E4007E064F0B7363F400000002001EAF93FDD14707EEC535E409C325334B8363F40000000E0F612FA3FA97CD7B9EC535E40BFA7284DB9363F40000000E014B3F93F5938E6C8EC535E409BDAD588B9363F4000000020F62DFA3F79880713ED535E40004EB07EBA363F40000000A00ADCF93F81740A22ED535E40068B90A8BA363F40000000A00ADCF93F4C92BE7BED535E4011996678BB363F40000000602961F93F3CB70387ED535E407C0AED8DBB363F40000000602961F93F1AA4B0F0ED535E40A0B4B92FBC363F40000000005230F93F6B57F0F4ED535E40A07DC634BC363F40000000005230F93F15813D68EE535E40D573E997BC363F40000000405C07F93FBCCE3A6EEE535E40CF477C9BBC363F40000000405C07F93F390C6FA1EE535E409A020EABBC363F40000000405C07F93F77E66CA1EE535E409F9916ABBC363F400000008066DEF83F390C6FA1EE535E409A020EABBC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 11:03:18.478983', '2025-06-04 11:03:18.478983', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271614', '8645782395347271615', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507229', 100001, '01020000A0E61000001800000047DB93E8EE535E40730DB76CC2363F40000000601F2BF83F4DB70866EE535E40D2818998C2363F40000000601F2BF83F6AE30936EE535E40903F67BEC2363F40000000201554F83FBDA3DD20EE535E40D833E4D5C2363F40000000601F2BF83FD24B2CF3ED535E40AE2DFA12C3363F40000000E00A7DF83FC81A3AE5ED535E406D324028C3363F40000000201554F83F180405C7ED535E401F378761C3363F40000000201554F83F54E6119CED535E406C624EBEC3363F4000000060B997F83F1E97C49BED535E4072A80FBFC3363F4000000060B997F83F326CBD74ED535E40A2110932C4363F40000000E0A4E9F83F51CAED5CED535E40079C3D81C4363F40000000E0A4E9F83FD4C7F54FED535E400CBC7EB4C4363F4000000020AFC0F83F991E292FED535E407D582346C5363F4000000060B997F83F5D6FC629ED535E40189C4260C5363F4000000060B997F83F144DCD09ED535E40D6DA751BC6363F4000000000D81CF83F917CD901ED535E40BE65FD4FC6363F4000000000D81CF83F70208CEEEC535E403BDC20F0C6363F4000000040E2F3F73FF28E5BE5EC535E40EDB0084CC7363F400000000002E4F73FEE6C37DDEC535E4088FCB9BCC7363F400000000002E4F73F282511D5EC535E40CFE2BD51C8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F4B51D3D3EC535E40E742297DC8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F5AD1FDD4EC535E40D43B9DAAC9363F40000000C02069F73F', '2025-06-04 11:03:19.685064', '2025-06-04 11:03:19.685064', 'virtual', '["non_motor_vehicle","walker"]', 0, 'generate', 99, '0', '8645924713383591843', '8645924713383591842', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507221', 100001, '01020000A0E610000004000000E25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83FC359A750F1535E40CEE61D19BE363F40000000608330F83FBE6DFC42F5535E407A502051C0363F4000000040500BF73F0AE9A281F5535E40E5BE5B74C0363F40000000001DD8F73F', '2025-06-04 11:03:20.884422', '2025-06-04 11:03:20.884422', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591798', '8645924713383591800', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507219', 100001, '01020000A0E610000006000000E647666FF5535E405BB4DF5EC2363F40000000C066EBF73F7AE31B3FF1535E409852C20CC0363F40000000605AD4F83F58054923EF535E4063E775DDBE363F40000000002F01FA3F229B589EEF535E408CA8F322BF363F4000000000585DF93F58054923EF535E4063E775DDBE363F40000000002F01FA3F5C29BAE4EE535E40E6B320BABE363F40000000803114FA3F', '2025-06-04 11:03:21.480482', '2025-06-04 11:03:21.480482', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591799', '8645924713383591876', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507227', 100001, '01020000A0E610000005000000932E26CBE3535E408A32ACC6B8363F40000000E034EFF83FDC552EA5E5535E40C594BFB0B9363F40000000808869F93F2F533A28E6535E40CB0F27F3B9363F40000000805F0DFA3F35CC036AE7535E40BE7629A8BA363F4000000040C7EAF93FC2227AAAE7535E40594C62CCBA363F4000000000BD13FA3F', '2025-06-04 11:03:22.078526', '2025-06-04 11:03:22.078526', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591815', '8645924713383591814', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507123', 100001, '01020000A0E610000003000000B20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F4096E203EB535E4028B1EAFAA5363F40000000600BCFFA3FAEF13109EB535E40D55809B0A4363F40000000C00776FA3F', '2025-06-04 11:30:30.148016', '2025-06-04 11:30:30.148016', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271633', '8645782395347271634', 1, 1);
INSERT INTO public.lane VALUES ('8642723176041676765', 100001, '01020000A0E6100000160000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F908E8212EC535E4021E04854B3363F4000000020DB16FA3F6512B61EEC535E40036CD5E8B4363F40000000E04434FA3FF592C920EC535E402C6ADC0DB5363F40000000204F0BFA3FB4CBB73EEC535E40F6378C75B6363F400000002001EAF93F66F67E45EC535E40BA6C88B2B6363F40000000C0EC3BFA3FA8D59772EC535E4007E064F0B7363F400000002001EAF93FDD14707EEC535E409C325334B8363F40000000E0F612FA3FA97CD7B9EC535E40BFA7284DB9363F40000000E014B3F93F5938E6C8EC535E409BDAD588B9363F4000000020F62DFA3F79880713ED535E40004EB07EBA363F40000000A00ADCF93F81740A22ED535E40068B90A8BA363F40000000A00ADCF93F4C92BE7BED535E4011996678BB363F40000000602961F93F3CB70387ED535E407C0AED8DBB363F40000000602961F93F1AA4B0F0ED535E40A0B4B92FBC363F40000000005230F93F6B57F0F4ED535E40A07DC634BC363F40000000005230F93F15813D68EE535E40D573E997BC363F40000000405C07F93FBCCE3A6EEE535E40CF477C9BBC363F40000000405C07F93F390C6FA1EE535E409A020EABBC363F40000000405C07F93F77E66CA1EE535E409F9916ABBC363F400000008066DEF83F390C6FA1EE535E409A020EABBC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 11:39:53.593063', '2025-06-04 11:39:53.593063', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271614', '8645782395347271615', 1, 1);
INSERT INTO public.lane VALUES ('8642723176041676792', 100001, '01020000A0E610000004000000E25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83FC359A750F1535E40CEE61D19BE363F40000000608330F83FBE6DFC42F5535E407A502051C0363F4000000040500BF73F0AE9A281F5535E40E5BE5B74C0363F40000000001DD8F73F', '2025-06-04 11:39:54.204949', '2025-06-04 11:39:54.204949', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591798', '8645924713383591800', 1, 1);
INSERT INTO public.lane VALUES ('8642723176041676730', 100001, '01020000A0E61000001400000048A3CD34EB535E40408843BAC8363F4000000080BF7BFA3FF99CCD40EB535E40BEA7CD93C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 11:39:54.803803', '2025-06-04 11:39:54.803803', 'virtual', 'null', 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8642723176041676790', 100001, '01020000A0E610000006000000E647666FF5535E405BB4DF5EC2363F40000000C066EBF73F7AE31B3FF1535E409852C20CC0363F40000000605AD4F83F58054923EF535E4063E775DDBE363F40000000002F01FA3F229B589EEF535E408CA8F322BF363F4000000000585DF93F58054923EF535E4063E775DDBE363F40000000002F01FA3F5C29BAE4EE535E40E6B320BABE363F40000000803114FA3F', '2025-06-04 11:39:55.408786', '2025-06-04 11:39:55.408786', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591799', '8645924713383591876', 1, 1);
INSERT INTO public.lane VALUES ('8642723176041676747', 100001, '01020000A0E61000000600000018F0CF98EB535E40D82935FFD8363F40000000A06464F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73F33AD8255EB535E40049892E2EC363F40000000807640F83F062D0352EB535E40E5FAA4FEED363F40000000E09D11F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73FE8E1FC34EB535E408783C18BF7363F400000008030F0F73F', '2025-06-04 11:39:56.623955', '2025-06-04 11:39:56.623955', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558708', '8645275692285558707', 1, 1);
INSERT INTO public.lane VALUES ('8642723176041676789', 100001, '01020000A0E610000007000000DFE39D5AF5535E40AD120647C4363F40000000C08F47F73F6CB106E8F1535E40087F9160C2363F40000000809B68F73F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93FB743268DEF535E402091A20DC1363F40000000C076E2F83F11928B85EF535E40A3C25209C1363F400000000081B9F83F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93F4A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F', '2025-06-04 11:39:57.223011', '2025-06-04 11:39:57.223011', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591876', '8645924713383591870', 2, 1);
INSERT INTO public.lane VALUES ('8642723176041676800', 100001, '01020000A0E61000001800000047DB93E8EE535E40730DB76CC2363F40000000601F2BF83F4DB70866EE535E40D2818998C2363F40000000601F2BF83F6AE30936EE535E40903F67BEC2363F40000000201554F83FBDA3DD20EE535E40D833E4D5C2363F40000000601F2BF83FD24B2CF3ED535E40AE2DFA12C3363F40000000E00A7DF83FC81A3AE5ED535E406D324028C3363F40000000201554F83F180405C7ED535E401F378761C3363F40000000201554F83F54E6119CED535E406C624EBEC3363F4000000060B997F83F1E97C49BED535E4072A80FBFC3363F4000000060B997F83F326CBD74ED535E40A2110932C4363F40000000E0A4E9F83F51CAED5CED535E40079C3D81C4363F40000000E0A4E9F83FD4C7F54FED535E400CBC7EB4C4363F4000000020AFC0F83F991E292FED535E407D582346C5363F4000000060B997F83F5D6FC629ED535E40189C4260C5363F4000000060B997F83F144DCD09ED535E40D6DA751BC6363F4000000000D81CF83F917CD901ED535E40BE65FD4FC6363F4000000000D81CF83F70208CEEEC535E403BDC20F0C6363F4000000040E2F3F73FF28E5BE5EC535E40EDB0084CC7363F400000000002E4F73FEE6C37DDEC535E4088FCB9BCC7363F400000000002E4F73F282511D5EC535E40CFE2BD51C8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F4B51D3D3EC535E40E742297DC8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F5AD1FDD4EC535E40D43B9DAAC9363F40000000C02069F73F', '2025-06-04 11:39:57.831213', '2025-06-04 11:39:57.831213', 'virtual', '["non_motor_vehicle","walker"]', 0, 'generate', 99, '0', '8645924713383591843', '8645924713383591842', 1, 1);
INSERT INTO public.lane VALUES ('8642723176041676745', 100001, '01020000A0E610000005000000E4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F71AAB530EB535E4033FB20F1C9363F4000000000D429FA3F77AFA426EB535E40566526EBCC363F40000000A09920FA3F71AAB530EB535E4033FB20F1C9363F4000000000D429FA3F48A3CD34EB535E40408843BAC8363F4000000080BF7BFA3F', '2025-06-04 11:39:58.433437', '2025-06-04 11:39:58.434434', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271283', '8645782395347271285', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507393', 100001, '01020000A0E6100000140000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F34611266EE535E40CD9D759AC0363F40000000805A70F93F20F45001EE535E401A1986BDC0363F40000000405099F93FF3D48DF1ED535E4044CCDBC7C0363F40000000805A70F93FB5F5488DED535E4097A8FF28C1363F40000000A0A7FAF93F8453A581ED535E409D9A2E38C1363F4000000020BCA8F93F7633A31FED535E40850D5EDAC1363F4000000040C67FF93F0DC6CF19ED535E4049C64BE6C1363F4000000040C67FF93F6E011DBDEC535E40E42023CBC2363F40000000E07B8DF93F6CA9D7BBEC535E40FCE7E0CEC2363F40000000E07B8DF93FE59B6D6EEC535E4054785BDFC3363F40000000205D08FA3FD73FE065EC535E40B9FE4603C4363F40000000205D08FA3F72F3322FEC535E409B2DB116C5363F400000004015B0F93F9C680121EC535E40E8E0B26DC5363F40000000801F87F93F287C3F00EC535E40D6A13567C6363F40000000801F87F93F592479F0EB535E406BAB6E02C7363F40000000801F87F93FB43E36E0EB535E4011DC7BCAC7363F4000000040075DF93F150705E2EB535E40761A01C6C7363F4000000040075DF93FB43E36E0EB535E4011DC7BCAC7363F4000000040075DF93FE1051ED3EB535E4081278815C9363F40000000801134F93F', '2025-06-04 10:31:42.296', '2025-06-04 10:31:42.296', 'virtual', NULL, 0, 'generate', 99, '0', '8645924713383591836', '8645924713383591853', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507446', 100001, '01020000A0E610000006000000E647666FF5535E405BB4DF5EC2363F40000000C066EBF73F7AE31B3FF1535E409852C20CC0363F40000000605AD4F83F58054923EF535E4063E775DDBE363F40000000002F01FA3F229B589EEF535E408CA8F322BF363F4000000000585DF93F58054923EF535E4063E775DDBE363F40000000002F01FA3F5C29BAE4EE535E40E6B320BABE363F40000000803114FA3F', '2025-06-04 10:39:14.100709', '2025-06-04 10:39:14.101706', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591799', '8645924713383591876', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507387', 100001, '01020000A0E6100000140000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F34611266EE535E40CD9D759AC0363F40000000805A70F93F20F45001EE535E401A1986BDC0363F40000000405099F93FF3D48DF1ED535E4044CCDBC7C0363F40000000805A70F93FB5F5488DED535E4097A8FF28C1363F40000000A0A7FAF93F8453A581ED535E409D9A2E38C1363F4000000020BCA8F93F7633A31FED535E40850D5EDAC1363F4000000040C67FF93F0DC6CF19ED535E4049C64BE6C1363F4000000040C67FF93F6E011DBDEC535E40E42023CBC2363F40000000E07B8DF93F6CA9D7BBEC535E40FCE7E0CEC2363F40000000E07B8DF93FE59B6D6EEC535E4054785BDFC3363F40000000205D08FA3FD73FE065EC535E40B9FE4603C4363F40000000205D08FA3F72F3322FEC535E409B2DB116C5363F400000004015B0F93F9C680121EC535E40E8E0B26DC5363F40000000801F87F93F287C3F00EC535E40D6A13567C6363F40000000801F87F93F592479F0EB535E406BAB6E02C7363F40000000801F87F93FB43E36E0EB535E4011DC7BCAC7363F4000000040075DF93F150705E2EB535E40761A01C6C7363F4000000040075DF93FB43E36E0EB535E4011DC7BCAC7363F4000000040075DF93FE1051ED3EB535E4081278815C9363F40000000801134F93F', '2025-06-04 10:39:14.717375', '2025-06-04 10:39:14.717375', 'virtual', NULL, 0, 'generate', 99, '0', '8645924713383591836', '8645924713383591853', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507445', 100001, '01020000A0E610000007000000DFE39D5AF5535E40AD120647C4363F40000000C08F47F73F6CB106E8F1535E40087F9160C2363F40000000809B68F73F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93FB743268DEF535E402091A20DC1363F40000000C076E2F83F11928B85EF535E40A3C25209C1363F400000000081B9F83F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93F4A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F', '2025-06-04 10:39:15.323819', '2025-06-04 10:39:15.323819', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591876', '8645924713383591870', 2, 1);
INSERT INTO public.lane VALUES ('8642875801999507456', 100001, '01020000A0E61000001800000047DB93E8EE535E40730DB76CC2363F40000000601F2BF83F4DB70866EE535E40D2818998C2363F40000000601F2BF83F6AE30936EE535E40903F67BEC2363F40000000201554F83FBDA3DD20EE535E40D833E4D5C2363F40000000601F2BF83FD24B2CF3ED535E40AE2DFA12C3363F40000000E00A7DF83FC81A3AE5ED535E406D324028C3363F40000000201554F83F180405C7ED535E401F378761C3363F40000000201554F83F54E6119CED535E406C624EBEC3363F4000000060B997F83F1E97C49BED535E4072A80FBFC3363F4000000060B997F83F326CBD74ED535E40A2110932C4363F40000000E0A4E9F83F51CAED5CED535E40079C3D81C4363F40000000E0A4E9F83FD4C7F54FED535E400CBC7EB4C4363F4000000020AFC0F83F991E292FED535E407D582346C5363F4000000060B997F83F5D6FC629ED535E40189C4260C5363F4000000060B997F83F144DCD09ED535E40D6DA751BC6363F4000000000D81CF83F917CD901ED535E40BE65FD4FC6363F4000000000D81CF83F70208CEEEC535E403BDC20F0C6363F4000000040E2F3F73FF28E5BE5EC535E40EDB0084CC7363F400000000002E4F73FEE6C37DDEC535E4088FCB9BCC7363F400000000002E4F73F282511D5EC535E40CFE2BD51C8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F4B51D3D3EC535E40E742297DC8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F5AD1FDD4EC535E40D43B9DAAC9363F40000000C02069F73F', '2025-06-04 10:39:15.937201', '2025-06-04 10:39:15.937201', 'virtual', '["non_motor_vehicle","walker"]', 0, 'generate', 99, '0', '8645924713383591843', '8645924713383591842', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507409', 100001, '01020000A0E610000005000000FBC65165EA535E406DB11ACCD8363F40000000802FC5F83F4C982E99EA535E400A403990C9363F40000000002485F93FEF8F5F8EEA535E409137BECBCC363F4000000040F573F93F4C982E99EA535E400A403990C9363F40000000002485F93F69FC209DEA535E40ED3D3963C8363F40000000C019AEF93F', '2025-06-04 10:39:16.547091', '2025-06-04 10:39:16.547091', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271285', '8645782395347271291', 2, 1);
INSERT INTO public.lane VALUES ('8642875801999507410', 100001, '01020000A0E610000005000000AB00D5FBEA535E40447D1EE5D8363F40000000A03B08F93FE230A030EB535E40E64FB1F0C9363F4000000000D429FA3FB97D4A26EB535E404A3715EBCC363F40000000A09920FA3FE230A030EB535E40E64FB1F0C9363F4000000000D429FA3F28B6CE34EB535E40408843BAC8363F4000000080BF7BFA3F', '2025-06-04 10:39:17.156776', '2025-06-04 10:39:17.156776', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271283', '8645782395347271285', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507403', 100001, '01020000A0E610000004000000A22B20D3EB535E4004738C15C9363F40000000801134F93F9035A9BCEB535E40968224A2CE363F4000000060E101F93F31601A9DEB535E40D3CABFC1D7363F40000000605A8DF83F18F0CF98EB535E40D82935FFD8363F40000000A06464F83F', '2025-06-04 10:39:17.766424', '2025-06-04 10:39:17.766424', 'driving', NULL, 0, 'generate', 99, '0', '8645782395347271282', '8645782395347271280', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507206', 100001, '01020000A0E610000003000000EFCB6143EC535E404033DE0FA5363F40000000A0E94FFA3FC18E971FEC535E40057B3250B0363F4000000020DB16FA3F3E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F', '2025-06-04 11:03:19.08629', '2025-06-04 11:03:19.08629', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271639', '8645782395347271637', 2, 1);
INSERT INTO public.lane VALUES ('8642875801999507218', 100001, '01020000A0E610000007000000DFE39D5AF5535E40AD120647C4363F40000000C08F47F73F6CB106E8F1535E40087F9160C2363F40000000809B68F73F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93FB743268DEF535E402091A20DC1363F40000000C076E2F83F11928B85EF535E40A3C25209C1363F400000000081B9F83F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93F4A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F', '2025-06-04 11:03:20.286466', '2025-06-04 11:03:20.286466', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591876', '8645924713383591870', 2, 1);
INSERT INTO public.lane VALUES ('8642875801999507400', 100001, '01020000A0E610000015000000C2227AAAE7535E40594C62CCBA363F4000000000BD13FA3F3314AF66E8535E4065ABD0E2BA363F40000000A02D35FA3FDC0073FAE8535E4017B46047BB363F4000000060235EFA3FA58A3D0FE9535E40FF2A2A5CBB363F4000000060235EFA3F59EF5BA0E9535E40CFA63C1DBC363F40000000A07285FA3F8E3B5EAEE9535E40BD70F134BC363F40000000A07285FA3F5A84D939EA535E40752A8D56BD363F40000000A07285FA3FA7F8553FEA535E4087EC5B64BD363F400000006068AEFA3FF63ED9BDEA535E401B8FF1DFBE363F400000006036C1FA3F20CBB0C1EA535E40A46EB3EDBE363F400000006036C1FA3FA0275426EB535E40F7BEB19AC0363F4000000060B307FB3FF7F68B32EB535E40622757D9C0363F40000000A0BDDEFA3FFF78F176EB535E400267E283C2363F4000000040C3F7FA3FFA430D88EB535E40D8BC1C09C3363F4000000080CDCEFA3F743F9DAEEB535E40305CBD8DC4363F40000000C0D7A5FA3F95304FBEEB535E407DD77C69C5363F4000000040EC53FA3F710142CDEB535E404114BAB5C6363F40000000C00002FA3F951065D5EB535E405E4619C0C7363F4000000000FD85F93F6A97E3D3EB535E40C90E7DB9C7363F4000000000FD85F93F951065D5EB535E405E4619C0C7363F4000000000FD85F93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 10:39:20.206578', '2025-06-04 10:39:20.206578', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271661', '8645782395347271660', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507396', 100001, '01020000A0E61000001400000048A3CD34EB535E40408843BAC8363F4000000080BF7BFA3FF99CCD40EB535E40BEA7CD93C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 10:39:20.821463', '2025-06-04 10:39:20.821463', 'virtual', NULL, 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507448', 100001, '01020000A0E610000004000000E25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83FC359A750F1535E40CEE61D19BE363F40000000608330F83FBE6DFC42F5535E407A502051C0363F4000000040500BF73F0AE9A281F5535E40E5BE5B74C0363F40000000001DD8F73F', '2025-06-04 10:39:21.427281', '2025-06-04 10:39:21.427281', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591798', '8645924713383591800', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507442', 100001, '01020000A0E6100000030000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F359A57D3E7535E406AFA7FE4BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 10:39:22.037657', '2025-06-04 10:39:22.037657', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271662', '8645782395347271663', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507421', 100001, '01020000A0E61000001400000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93FDAFD1B95EA535E402A916AF6C5363F4000000040810CFA3F94BC0A8EEA535E40E29AF16CC5363F40000000808BE3F93F636EF973EA535E40B3BF1920C4363F40000000808BE3F93FFC1E9766EA535E40492FF8A1C3363F40000000C095BAF93F7FB7993AEA535E40A3C8465FC2363F40000000C095BAF93FA9708529EA535E404FD2CEF9C1363F40000000E073CBF93F84C401EAE9535E403E1B7FC3C0363F40000000608879F93F472B40D9E9535E404A58077FC0363F40000000A09250F93FC33B4784E9535E405172545CBF363F40000000A09250F93F0AB16A78E9535E402DC7383ABF363F40000000E09C27F93F460D8A0CE9535E409365CD37BE363F4000000060F948F93FC10BCF09E9535E40D46A6632BE363F4000000060F948F93FD24F2990E8535E40D5875670BD363F40000000E06068F93F06138986E8535E4081555364BD363F40000000206B3FF93F79904DDBE7535E40CF7C22DDBC363F40000000C004F5F83FEEEB5D0FE8535E404CCD16F7BC363F40000000607516F93FA7996FF6E7535E40F3986FE7BC363F40000000C004F5F83F79904DDBE7535E40CF7C22DDBC363F40000000C004F5F83FCCB7739EE7535E402E5EDDC5BC363F40000000C004F5F83F', '2025-06-04 10:39:22.648337', '2025-06-04 10:39:22.648337', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271583', '8645782395347271584', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507454', 100001, '01020000A0E610000005000000932E26CBE3535E408A32ACC6B8363F40000000E034EFF83FDC552EA5E5535E40C594BFB0B9363F40000000808869F93F2F533A28E6535E40CB0F27F3B9363F40000000805F0DFA3F35CC036AE7535E40BE7629A8BA363F4000000040C7EAF93FC2227AAAE7535E40594C62CCBA363F4000000000BD13FA3F', '2025-06-04 10:39:23.255632', '2025-06-04 10:39:23.255632', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591815', '8645924713383591814', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507438', 100001, '01020000A0E61000000300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F036CDAA1EE535E40114D1596BC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 10:39:23.862055', '2025-06-04 10:39:23.862055', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271659', '8645782395347271658', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507450', 100001, '01020000A0E61000000500000098DD0A96E7535E4082E472C3BC363F40000000C004F5F83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F6065498DE4535E40BE82042ABB363F40000000E05D4BF83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F3AED54B9E3535E40E891CFC3BA363F4000000000183AF83F', '2025-06-04 10:39:24.469238', '2025-06-04 10:39:24.469238', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591816', '8645924713383591818', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507416', 100001, '01020000A0E61000000600000044447194EA535E40DB050E5EF7363F4000000040D7F0F73FB25858AAEA535E407361B6FAF0363F400000000069EAF83F64EEBAB4EA535E40E0629EC5ED363F400000000069EAF83F572447B6EA535E4004DEAB51ED363F40000000206D0EF93F08121BF9EA535E4019D65215DA363F40000000603131F93FE4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F', '2025-06-04 10:39:25.077517', '2025-06-04 10:39:25.077517', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558709', '8645275692285558705', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507415', 100001, '01020000A0E610000006000000F9A0B8FAE9535E40341C183EF7363F40000000C0EB9EF73F3661F811EA535E40B4BD2CD9F0363F40000000009246F83FB0C08F1EEA535E403F018B31ED363F4000000020966AF83FD03C5D36EA535E40D83D9865E6363F40000000E0C22CF83F05E13A61EA535E4090574DFBD9363F40000000C0399CF83FFBC65165EA535E406DB11ACCD8363F40000000802FC5F83F', '2025-06-04 10:39:25.686116', '2025-06-04 10:39:25.686116', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645275692285558705', '8645275692285558706', 2, 1);
INSERT INTO public.lane VALUES ('8642875801999507412', 100001, '01020000A0E61000000600000018F0CF98EB535E40D82935FFD8363F40000000A06464F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73F33AD8255EB535E40049892E2EC363F40000000807640F83F062D0352EB535E40E5FAA4FEED363F40000000E09D11F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73FE8E1FC34EB535E408783C18BF7363F400000008030F0F73F', '2025-06-04 10:39:26.291047', '2025-06-04 10:39:26.291047', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558708', '8645275692285558707', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507434', 100001, '01020000A0E61000001300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F307A2F3DE8535E4084AC16F4B8363F40000000E06068F93F36331E98E8535E40365884D7B8363F40000000604CBAF93F0A534ABEE8535E40D707E5BFB8363F40000000604CBAF93FC32F6C02E9535E4048665380B8363F40000000200AF4F93F4ABB313AE9535E40FB6BE939B8363F40000000E0FF1CFA3FB5BB8667E9535E40C611BFF0B7363F40000000E0FF1CFA3F1DA849ACE9535E40A83C8267B7363F4000000000EC63FA3F1AF228C5E9535E4079C75C2BB7363F4000000000EC63FA3F19105C10EA535E40F6097A51B6363F4000000040F63AFA3FEC2E2019EA535E40FCEA3533B6363F4000000040F63AFA3FE1560761EA535E4068944F0BB5363F4000000040F63AFA3F6306A962EA535E404A1C3503B5363F4000000040F63AFA3FC8010F9AEA535E40E0B878B7B3363F40000000A05DFEF93F6F4F0CA0EA535E4063A2C28AB3363F40000000204950FA3F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93F9D2E65C2EA535E406F764D43B2363F40000000A05DFEF93F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93F921E5BD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 10:39:28.712684', '2025-06-04 10:39:28.712684', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271618', '8645782395347271619', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507453', 100001, '01020000A0E610000006000000E2EA72DDE3535E40C0E6F1BBB6363F400000004033F3F83FA711BEEDE5535E40BA3A8BD4B7363F40000000A014EDF83F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93FC5016651E7535E40FB8DCF94B8363F40000000A02255F93F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93F24ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F', '2025-06-04 10:39:29.32077', '2025-06-04 10:39:29.32077', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591814', '8645924713383591813', 2, 1);
INSERT INTO public.lane VALUES ('8642875801999507427', 100001, '01020000A0E6100000150000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F908E8212EC535E4021E04854B3363F4000000020DB16FA3F6512B61EEC535E40036CD5E8B4363F40000000E04434FA3FF592C920EC535E402C6ADC0DB5363F40000000204F0BFA3FB4CBB73EEC535E40F6378C75B6363F400000002001EAF93F66F67E45EC535E40BA6C88B2B6363F40000000C0EC3BFA3FA8D59772EC535E4007E064F0B7363F400000002001EAF93FDD14707EEC535E409C325334B8363F40000000E0F612FA3FA97CD7B9EC535E40BFA7284DB9363F40000000E014B3F93F5938E6C8EC535E409BDAD588B9363F4000000020F62DFA3F79880713ED535E40004EB07EBA363F40000000A00ADCF93F81740A22ED535E40068B90A8BA363F40000000A00ADCF93F4C92BE7BED535E4011996678BB363F40000000602961F93F3CB70387ED535E407C0AED8DBB363F40000000602961F93F1AA4B0F0ED535E40A0B4B92FBC363F40000000005230F93F6B57F0F4ED535E40A07DC634BC363F40000000005230F93F2B35D1A0EE535E4064A696A8BC363F40000000405C07F93F341DF568EE535E40C35D8898BC363F400000008066DEF83F9CE13B6EEE535E4046656F9BBC363F40000000405C07F93F2B35D1A0EE535E4064A696A8BC363F40000000405C07F93FE25B3CE2EE535E40708D3FB9BC363F400000008066DEF83F', '2025-06-04 10:39:29.927597', '2025-06-04 10:39:29.927597', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271614', '8645782395347271615', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507430', 100001, '01020000A0E610000013000000F4E64275EB535E40D5BD045DB1363F4000000060BC91FA3F09A69A59EB535E403399368BB3363F4000000060BC91FA3FF66A9E28EB535E400E3B2667B5363F40000000A01101FB3F57A15320EB535E407F3AD4A5B5363F40000000A01101FB3FA1164BDDEA535E409CB9E03CB7363F40000000A01101FB3FC04AB2CCEA535E403D950690B7363F4000000000C307FB3F02DAD27AEA535E4095160AE5B8363F400000006068AEFA3F6D8B2D62EA535E40E31A533BB9363F400000006068AEFA3FC1916B03EA535E40FAA53451BA363F400000006068AEFA3FAC73A4E4E9535E40D6E2C09CBA363F400000006068AEFA3F7D3E537AE9535E407040E373BB363F40000000A07285FA3F6C522558E9535E40593606ACBB363F4000000060235EFA3FAE11A5E3E8535E40B290DC41BC363F40000000A02D35FA3F9C7CEAC0E8535E403AE51863BC363F400000002042E3F93F48B7B6D4E7535E407607A9C2BC363F40000000C004F5F83F00982144E8535E401CD301B3BC363F40000000E06068F93F2659B223E8535E40AB8DE9BDBC363F40000000607516F93F48B7B6D4E7535E407607A9C2BC363F40000000C004F5F83F98DD0A96E7535E40053077C3BC363F40000000C004F5F83F', '2025-06-04 10:39:30.53028', '2025-06-04 10:39:30.53028', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271617', '8645782395347271616', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646067', 100001, '01020000A0E610000003000000AF053CB7F0535E4013467196AB363F4000000040E17AF4BFD44526BAF0535E4070F5993CB0363F4000000040E17AF4BF29312BBBF0535E40709AD19EB1363F4000000040E17AF4BF', '2025-06-04 17:28:39.1581', '2025-06-04 17:28:39.1581', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '1', '8642101470935646075', '8642101470935646077', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646061', 100001, '01020000A0E61000000700000029312BBBF0535E40709AD19EB1363F4000000040E17AF4BFD7E984F3F0535E4051BF0B5BB3363F4000000040E17AF4BFE5EB530AF1535E401B7EE695B3363F4000000040E17AF4BF426C7E36F1535E4086A6B702B4363F4000000040E17AF4BFA5D46246F1535E40AA1AE029B4363F4000000040E17AF4BF52575DD8F1535E40CD7AF9E9B4363F4000000040E17AF4BF19CEFD21F2535E40146D2948B5363F4000000040E17AF4BF', '2025-06-04 17:06:02.294346', '2025-06-04 17:06:02.294346', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '1', '8642101470935646074', '8642101470935646076', 1, 1);
INSERT INTO public.lane VALUES ('8642718640556212196', 100001, '01020000A0E61000001300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F307A2F3DE8535E4084AC16F4B8363F40000000E06068F93F36331E98E8535E40365884D7B8363F40000000604CBAF93F0A534ABEE8535E40D707E5BFB8363F40000000604CBAF93FC32F6C02E9535E4048665380B8363F40000000200AF4F93F4ABB313AE9535E40FB6BE939B8363F40000000E0FF1CFA3FB5BB8667E9535E40C611BFF0B7363F40000000E0FF1CFA3F1DA849ACE9535E40A83C8267B7363F4000000000EC63FA3F1AF228C5E9535E4079C75C2BB7363F4000000000EC63FA3F19105C10EA535E40F6097A51B6363F4000000040F63AFA3FEC2E2019EA535E40FCEA3533B6363F4000000040F63AFA3FE1560761EA535E4068944F0BB5363F4000000040F63AFA3F6306A962EA535E404A1C3503B5363F4000000040F63AFA3FC8010F9AEA535E40E0B878B7B3363F40000000A05DFEF93F6F4F0CA0EA535E4063A2C28AB3363F40000000204950FA3F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93F7D4166C2EA535E40EC2A4943B2363F40000000A05DFEF93F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 11:49:32.904421', '2025-06-04 11:49:32.904421', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271618', '8645782395347271619', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507331', 100001, '01020000A0E610000005000000FBC65165EA535E406DB11ACCD8363F40000000802FC5F83F4C982E99EA535E400A403990C9363F40000000002485F93FEF8F5F8EEA535E409137BECBCC363F4000000040F573F93F4C982E99EA535E400A403990C9363F40000000002485F93F69FC209DEA535E40ED3D3963C8363F40000000C019AEF93F', '2025-06-04 10:47:22.060664', '2025-06-04 10:47:22.060664', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271285', '8645782395347271291', 2, 1);
INSERT INTO public.lane VALUES ('8642875801999507324', 100001, '01020000A0E610000004000000A22B20D3EB535E4004738C15C9363F40000000801134F93F9035A9BCEB535E40968224A2CE363F4000000060E101F93F31601A9DEB535E40D3CABFC1D7363F40000000605A8DF83F18F0CF98EB535E40D82935FFD8363F40000000A06464F83F', '2025-06-04 10:47:22.64117', '2025-06-04 10:47:22.64117', 'driving', 'null', 0, 'generate', 99, '0', '8645782395347271282', '8645782395347271280', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507314', 100001, '01020000A0E6100000140000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F34611266EE535E40CD9D759AC0363F40000000805A70F93F20F45001EE535E401A1986BDC0363F40000000405099F93FF3D48DF1ED535E4044CCDBC7C0363F40000000805A70F93FB5F5488DED535E4097A8FF28C1363F40000000A0A7FAF93F8453A581ED535E409D9A2E38C1363F4000000020BCA8F93F7633A31FED535E40850D5EDAC1363F4000000040C67FF93F0DC6CF19ED535E4049C64BE6C1363F4000000040C67FF93F6E011DBDEC535E40E42023CBC2363F40000000E07B8DF93F6CA9D7BBEC535E40FCE7E0CEC2363F40000000E07B8DF93FE59B6D6EEC535E4054785BDFC3363F40000000205D08FA3FD73FE065EC535E40B9FE4603C4363F40000000205D08FA3F72F3322FEC535E409B2DB116C5363F400000004015B0F93F9C680121EC535E40E8E0B26DC5363F40000000801F87F93F287C3F00EC535E40D6A13567C6363F40000000801F87F93F592479F0EB535E406BAB6E02C7363F40000000801F87F93FB43E36E0EB535E4011DC7BCAC7363F4000000040075DF93F150705E2EB535E40761A01C6C7363F4000000040075DF93FB43E36E0EB535E4011DC7BCAC7363F4000000040075DF93FE1051ED3EB535E4081278815C9363F40000000801134F93F', '2025-06-04 10:47:27.873745', '2025-06-04 10:47:27.873745', 'virtual', NULL, 0, 'generate', 99, '0', '8645924713383591836', '8645924713383591853', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507203', 100001, '01020000A0E610000003000000921E5BD6EA535E40E7F2510CB1363F40000000E0F99BF93F4096E203EB535E4028B1EAFAA5363F40000000600BCFFA3FAEF13109EB535E40D55809B0A4363F40000000C00776FA3F', '2025-06-04 11:03:26.871792', '2025-06-04 11:03:26.871792', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271633', '8645782395347271634', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507321', 100001, '01020000A0E610000015000000C2227AAAE7535E40594C62CCBA363F4000000000BD13FA3F3314AF66E8535E4065ABD0E2BA363F40000000A02D35FA3FDC0073FAE8535E4017B46047BB363F4000000060235EFA3FA58A3D0FE9535E40FF2A2A5CBB363F4000000060235EFA3F59EF5BA0E9535E40CFA63C1DBC363F40000000A07285FA3F8E3B5EAEE9535E40BD70F134BC363F40000000A07285FA3F5A84D939EA535E40752A8D56BD363F40000000A07285FA3FA7F8553FEA535E4087EC5B64BD363F400000006068AEFA3FF63ED9BDEA535E401B8FF1DFBE363F400000006036C1FA3F20CBB0C1EA535E40A46EB3EDBE363F400000006036C1FA3FA0275426EB535E40F7BEB19AC0363F4000000060B307FB3FF7F68B32EB535E40622757D9C0363F40000000A0BDDEFA3FFF78F176EB535E400267E283C2363F4000000040C3F7FA3FFA430D88EB535E40D8BC1C09C3363F4000000080CDCEFA3F743F9DAEEB535E40305CBD8DC4363F40000000C0D7A5FA3F95304FBEEB535E407DD77C69C5363F4000000040EC53FA3F710142CDEB535E404114BAB5C6363F40000000C00002FA3F951065D5EB535E405E4619C0C7363F4000000000FD85F93F6A97E3D3EB535E40C90E7DB9C7363F4000000000FD85F93F951065D5EB535E405E4619C0C7363F4000000000FD85F93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 10:47:28.466571', '2025-06-04 10:47:28.466571', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271661', '8645782395347271660', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507317', 100001, '01020000A0E61000001400000048A3CD34EB535E40408843BAC8363F4000000080BF7BFA3FF99CCD40EB535E40BEA7CD93C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 10:47:29.653016', '2025-06-04 10:47:29.653016', 'virtual', NULL, 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507311', 100001, '01020000A0E6100000030000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F864C1DD7EB535E4011E9A5CCC7363F4000000000FD85F93FE1051ED3EB535E4081278815C9363F40000000801134F93F', '2025-06-04 10:47:34.835303', '2025-06-04 10:47:34.835303', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271613', '8645782395347271612', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646058', 100001, '01020000A0E61000000700000029312BBBF0535E40709AD19EB1363F4000000040E17AF4BFD7E984F3F0535E4051BF0B5BB3363F4000000040E17AF4BFE5EB530AF1535E401B7EE695B3363F4000000040E17AF4BF426C7E36F1535E4086A6B702B4363F4000000040E17AF4BFA5D46246F1535E40AA1AE029B4363F4000000040E17AF4BF52575DD8F1535E40CD7AF9E9B4363F4000000040E17AF4BF19CEFD21F2535E40146D2948B5363F4000000040E17AF4BF', '2025-06-04 17:07:04.872245', '2025-06-04 17:07:04.872245', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '1', '8642101470935646074', '8642101470935646076', 1, 1);
INSERT INTO public.lane VALUES ('8642718640556212158', 100001, '01020000A0E610000015000000C2227AAAE7535E40D6005ECCBA363F4000000000BD13FA3F3314AF66E8535E4065ABD0E2BA363F40000000A02D35FA3FDC0073FAE8535E4017B46047BB363F4000000060235EFA3FA58A3D0FE9535E40FF2A2A5CBB363F4000000060235EFA3F59EF5BA0E9535E40CFA63C1DBC363F40000000A07285FA3F8E3B5EAEE9535E40BD70F134BC363F40000000A07285FA3F5A84D939EA535E40752A8D56BD363F40000000A07285FA3FA7F8553FEA535E4087EC5B64BD363F400000006068AEFA3FF63ED9BDEA535E401B8FF1DFBE363F400000006036C1FA3F20CBB0C1EA535E40A46EB3EDBE363F400000006036C1FA3FA0275426EB535E40F7BEB19AC0363F4000000060B307FB3FF7F68B32EB535E40622757D9C0363F40000000A0BDDEFA3FFF78F176EB535E400267E283C2363F4000000040C3F7FA3FFA430D88EB535E40D8BC1C09C3363F4000000080CDCEFA3F743F9DAEEB535E40305CBD8DC4363F40000000C0D7A5FA3F95304FBEEB535E407DD77C69C5363F4000000040EC53FA3F710142CDEB535E404114BAB5C6363F40000000C00002FA3F951065D5EB535E405E4619C0C7363F4000000000FD85F93F6A97E3D3EB535E40C90E7DB9C7363F4000000000FD85F93F951065D5EB535E405E4619C0C7363F4000000000FD85F93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 11:49:38.87043', '2025-06-04 11:49:38.87043', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271661', '8645782395347271660', 1, 1);
INSERT INTO public.lane VALUES ('8642718640556212154', 100001, '01020000A0E61000001400000048A3CD34EB535E40408843BAC8363F4000000080BF7BFA3FF99CCD40EB535E40BEA7CD93C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 11:49:39.461386', '2025-06-04 11:49:39.461386', 'virtual', 'null', 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8642718640556212150', 100001, '01020000A0E6100000140000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F34611266EE535E40CD9D759AC0363F40000000805A70F93F20F45001EE535E401A1986BDC0363F40000000405099F93FF3D48DF1ED535E4044CCDBC7C0363F40000000805A70F93FB5F5488DED535E4097A8FF28C1363F40000000A0A7FAF93F8453A581ED535E409D9A2E38C1363F4000000020BCA8F93F7633A31FED535E40850D5EDAC1363F4000000040C67FF93F0DC6CF19ED535E4049C64BE6C1363F4000000040C67FF93F6E011DBDEC535E40E42023CBC2363F40000000E07B8DF93F6CA9D7BBEC535E40FCE7E0CEC2363F40000000E07B8DF93FE59B6D6EEC535E4054785BDFC3363F40000000205D08FA3FD73FE065EC535E40B9FE4603C4363F40000000205D08FA3F72F3322FEC535E409B2DB116C5363F400000004015B0F93F9C680121EC535E40E8E0B26DC5363F40000000801F87F93F287C3F00EC535E40D6A13567C6363F40000000801F87F93F592479F0EB535E406BAB6E02C7363F40000000801F87F93FD32B35E0EB535E40942780CAC7363F4000000040075DF93F150705E2EB535E40761A01C6C7363F4000000040075DF93FD32B35E0EB535E40942780CAC7363F4000000040075DF93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 11:49:41.219011', '2025-06-04 11:49:41.219011', 'virtual', NULL, 0, 'generate', 99, '0', '8645924713383591836', '8645924713383591853', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646055', 100001, '01020000A0E61000000700000029312BBBF0535E40709AD19EB1363F4000000040E17AF4BFD7E984F3F0535E4051BF0B5BB3363F4000000040E17AF4BFE5EB530AF1535E401B7EE695B3363F4000000040E17AF4BF426C7E36F1535E4086A6B702B4363F4000000040E17AF4BFA5D46246F1535E40AA1AE029B4363F4000000040E17AF4BF52575DD8F1535E40CD7AF9E9B4363F4000000040E17AF4BF19CEFD21F2535E40146D2948B5363F4000000040E17AF4BF', '2025-06-04 17:28:36.844852', '2025-06-04 17:28:36.844852', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '1', '8642101470935646074', '8642101470935646076', 1, 1);
INSERT INTO public.lane VALUES ('8642698677548220345', 100001, '01020000A0E61000001400000048A3CD34EB535E40408843BAC8363F4000000080BF7BFA3FF99CCD40EB535E40BEA7CD93C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 12:05:12.997145', '2025-06-04 12:05:12.997145', 'virtual', 'null', 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8642698677548220338', 100001, '01020000A0E6100000030000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93FA5391CD7EB535E408E9DA1CCC7363F4000000000FD85F93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 14:10:04.412342', '2025-06-04 14:10:04.412342', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271613', '8645782395347271612', 1, 1);
INSERT INTO public.lane VALUES ('8642660435159416779', 100001, '01020000A0E61000000300000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93F6FD844D3EA535E40E0A8A551B2363F4000000020DB16FA3F13D44175EB535E40D5BD045DB1363F4000000060BC91FA3F', '2025-06-04 14:14:13.669546', '2025-06-04 14:14:13.669546', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271581', '8645782395347271582', 1, 1);
INSERT INTO public.lane VALUES ('8642391707645640640', 100001, '01020000A0E610000004000000A22B20D3EB535E4004738C15C9363F40000000801134F93F9035A9BCEB535E40968224A2CE363F4000000060E101F93F31601A9DEB535E40D3CABFC1D7363F40000000605A8DF83FE4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F', '2025-06-04 14:26:46.367134', '2025-06-04 14:26:46.367134', 'driving', 'null', 0, 'generate', 99, '0', '8645782395347271282', '8645782395347271280', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507165', 100001, '01020000A0E610000015000000C2227AAAE7535E40594C62CCBA363F4000000000BD13FA3F3314AF66E8535E4065ABD0E2BA363F40000000A02D35FA3FDC0073FAE8535E4017B46047BB363F4000000060235EFA3FA58A3D0FE9535E40FF2A2A5CBB363F4000000060235EFA3F59EF5BA0E9535E40CFA63C1DBC363F40000000A07285FA3F8E3B5EAEE9535E40BD70F134BC363F40000000A07285FA3F5A84D939EA535E40752A8D56BD363F40000000A07285FA3FA7F8553FEA535E4087EC5B64BD363F400000006068AEFA3FF63ED9BDEA535E401B8FF1DFBE363F400000006036C1FA3F20CBB0C1EA535E40A46EB3EDBE363F400000006036C1FA3FA0275426EB535E40F7BEB19AC0363F4000000060B307FB3FF7F68B32EB535E40622757D9C0363F40000000A0BDDEFA3FFF78F176EB535E400267E283C2363F4000000040C3F7FA3FFA430D88EB535E40D8BC1C09C3363F4000000080CDCEFA3F743F9DAEEB535E40305CBD8DC4363F40000000C0D7A5FA3F95304FBEEB535E407DD77C69C5363F4000000040EC53FA3F710142CDEB535E404114BAB5C6363F40000000C00002FA3F951065D5EB535E405E4619C0C7363F4000000000FD85F93F6A97E3D3EB535E40C90E7DB9C7363F4000000000FD85F93F951065D5EB535E405E4619C0C7363F4000000000FD85F93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 11:03:25.677138', '2025-06-04 11:03:25.677138', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271661', '8645782395347271660', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507157', 100001, '01020000A0E6100000140000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F34611266EE535E40CD9D759AC0363F40000000805A70F93F20F45001EE535E401A1986BDC0363F40000000405099F93FF3D48DF1ED535E4044CCDBC7C0363F40000000805A70F93FB5F5488DED535E4097A8FF28C1363F40000000A0A7FAF93F8453A581ED535E409D9A2E38C1363F4000000020BCA8F93F7633A31FED535E40850D5EDAC1363F4000000040C67FF93F0DC6CF19ED535E4049C64BE6C1363F4000000040C67FF93F6E011DBDEC535E40E42023CBC2363F40000000E07B8DF93F6CA9D7BBEC535E40FCE7E0CEC2363F40000000E07B8DF93FE59B6D6EEC535E4054785BDFC3363F40000000205D08FA3FD73FE065EC535E40B9FE4603C4363F40000000205D08FA3F72F3322FEC535E409B2DB116C5363F400000004015B0F93F9C680121EC535E40E8E0B26DC5363F40000000801F87F93F287C3F00EC535E40D6A13567C6363F40000000801F87F93F592479F0EB535E406BAB6E02C7363F40000000801F87F93FD32B35E0EB535E40942780CAC7363F4000000040075DF93F150705E2EB535E40761A01C6C7363F4000000040075DF93FD32B35E0EB535E40942780CAC7363F4000000040075DF93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 11:03:26.27542', '2025-06-04 11:03:26.27542', 'virtual', NULL, 0, 'generate', 99, '0', '8645924713383591836', '8645924713383591853', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507207', 100001, '01020000A0E610000003000000183ECCA5EB535E40701ECDDFA4363F4000000080FD9EFA3FF7A3F779EB535E4076AC8C25B0363F4000000020B2BAFA3FF4E64275EB535E40D5BD045DB1363F4000000060BC91FA3F', '2025-06-04 11:03:27.473552', '2025-06-04 11:03:27.473552', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271640', '8645782395347271639', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507201', 100001, '01020000A0E61000001300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F307A2F3DE8535E4084AC16F4B8363F40000000E06068F93F36331E98E8535E40365884D7B8363F40000000604CBAF93F0A534ABEE8535E40D707E5BFB8363F40000000604CBAF93FC32F6C02E9535E4048665380B8363F40000000200AF4F93F4ABB313AE9535E40FB6BE939B8363F40000000E0FF1CFA3FB5BB8667E9535E40C611BFF0B7363F40000000E0FF1CFA3F1DA849ACE9535E40A83C8267B7363F4000000000EC63FA3F1AF228C5E9535E4079C75C2BB7363F4000000000EC63FA3F19105C10EA535E40F6097A51B6363F4000000040F63AFA3FEC2E2019EA535E40FCEA3533B6363F4000000040F63AFA3FE1560761EA535E4068944F0BB5363F4000000040F63AFA3F6306A962EA535E404A1C3503B5363F4000000040F63AFA3FC8010F9AEA535E40E0B878B7B3363F40000000A05DFEF93F6F4F0CA0EA535E4063A2C28AB3363F40000000204950FA3F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93F9D2E65C2EA535E406F764D43B2363F40000000A05DFEF93F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93F921E5BD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 11:03:28.072732', '2025-06-04 11:03:28.072732', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271618', '8645782395347271619', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507185', 100001, '01020000A0E61000000300000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93F30FE46D3EA535E40E0A8A551B2363F4000000020DB16FA3F921E5BD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 11:03:28.669201', '2025-06-04 11:03:28.669201', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271581', '8645782395347271582', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507182', 100001, '01020000A0E61000000600000044447194EA535E40DB050E5EF7363F4000000040D7F0F73FB25858AAEA535E407361B6FAF0363F400000000069EAF83F64EEBAB4EA535E40E0629EC5ED363F400000000069EAF83F572447B6EA535E4004DEAB51ED363F40000000206D0EF93F08121BF9EA535E4019D65215DA363F40000000603131F93FE4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F', '2025-06-04 11:03:29.267791', '2025-06-04 11:03:29.267791', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558709', '8645275692285558705', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507181', 100001, '01020000A0E610000006000000F9A0B8FAE9535E40341C183EF7363F40000000C0EB9EF73F3661F811EA535E40B4BD2CD9F0363F40000000009246F83FB0C08F1EEA535E403F018B31ED363F4000000020966AF83FD03C5D36EA535E40D83D9865E6363F40000000E0C22CF83F05E13A61EA535E4090574DFBD9363F40000000C0399CF83FFBC65165EA535E406DB11ACCD8363F40000000802FC5F83F', '2025-06-04 11:03:29.866393', '2025-06-04 11:03:29.866393', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645275692285558705', '8645275692285558706', 2, 1);
INSERT INTO public.lane VALUES ('8642875801999507178', 100001, '01020000A0E61000000600000018F0CF98EB535E40D82935FFD8363F40000000A06464F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73F33AD8255EB535E40049892E2EC363F40000000807640F83F062D0352EB535E40E5FAA4FEED363F40000000E09D11F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73FE8E1FC34EB535E408783C18BF7363F400000008030F0F73F', '2025-06-04 11:03:30.462324', '2025-06-04 11:03:30.462324', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558708', '8645275692285558707', 1, 1);
INSERT INTO public.lane VALUES ('8642718640556212192', 100001, '01020000A0E61000001300000013D44175EB535E40D5BD045DB1363F4000000060BC91FA3F09A69A59EB535E403399368BB3363F4000000060BC91FA3FF66A9E28EB535E400E3B2667B5363F40000000A01101FB3F57A15320EB535E407F3AD4A5B5363F40000000A01101FB3FA1164BDDEA535E409CB9E03CB7363F40000000A01101FB3FC04AB2CCEA535E403D950690B7363F4000000000C307FB3F02DAD27AEA535E4095160AE5B8363F400000006068AEFA3F6D8B2D62EA535E40E31A533BB9363F400000006068AEFA3FC1916B03EA535E40FAA53451BA363F400000006068AEFA3FAC73A4E4E9535E40D6E2C09CBA363F400000006068AEFA3F7D3E537AE9535E407040E373BB363F40000000A07285FA3F6C522558E9535E40593606ACBB363F4000000060235EFA3FAE11A5E3E8535E40B290DC41BC363F40000000A02D35FA3F9C7CEAC0E8535E403AE51863BC363F400000002042E3F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F30506644E8535E40FFDFD6B2BC363F40000000E06068F93F8320AF23E8535E40BDA34ABDBC363F40000000607516F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 11:43:42.799468', '2025-06-04 11:43:42.799468', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271617', '8645782395347271616', 1, 1);
INSERT INTO public.lane VALUES ('8642668028661596160', 100001, '01020000A0E61000001400000048A3CD34EB535E40408843BAC8363F4000000080BF7BFA3FF99CCD40EB535E40BEA7CD93C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 12:07:07.299759', '2025-06-04 12:07:07.300757', 'virtual', 'null', 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8642698677548220349', 100001, '01020000A0E610000015000000C2227AAAE7535E40D6005ECCBA363F4000000000BD13FA3F3314AF66E8535E4065ABD0E2BA363F40000000A02D35FA3FDC0073FAE8535E4017B46047BB363F4000000060235EFA3FA58A3D0FE9535E40FF2A2A5CBB363F4000000060235EFA3F59EF5BA0E9535E40CFA63C1DBC363F40000000A07285FA3F8E3B5EAEE9535E40BD70F134BC363F40000000A07285FA3F5A84D939EA535E40752A8D56BD363F40000000A07285FA3FA7F8553FEA535E4087EC5B64BD363F400000006068AEFA3FF63ED9BDEA535E401B8FF1DFBE363F400000006036C1FA3F20CBB0C1EA535E40A46EB3EDBE363F400000006036C1FA3FA0275426EB535E40F7BEB19AC0363F4000000060B307FB3FF7F68B32EB535E40622757D9C0363F40000000A0BDDEFA3FFF78F176EB535E400267E283C2363F4000000040C3F7FA3FFA430D88EB535E40D8BC1C09C3363F4000000080CDCEFA3F743F9DAEEB535E40305CBD8DC4363F40000000C0D7A5FA3F95304FBEEB535E407DD77C69C5363F4000000040EC53FA3F710142CDEB535E404114BAB5C6363F40000000C00002FA3F951065D5EB535E405E4619C0C7363F4000000000FD85F93F6A97E3D3EB535E40C90E7DB9C7363F4000000000FD85F93F951065D5EB535E405E4619C0C7363F4000000000FD85F93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 14:10:07.008375', '2025-06-04 14:10:07.008375', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271661', '8645782395347271660', 1, 1);
INSERT INTO public.lane VALUES ('8642698677548220402', 100001, '01020000A0E6100000030000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F15AD58D3E7535E40E7AE7BE4BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 14:10:07.695852', '2025-06-04 14:10:07.695852', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271662', '8645782395347271663', 1, 1);
INSERT INTO public.lane VALUES ('8642698677548220342', 100001, '01020000A0E6100000140000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F34611266EE535E40CD9D759AC0363F40000000805A70F93F20F45001EE535E401A1986BDC0363F40000000405099F93FF3D48DF1ED535E4044CCDBC7C0363F40000000805A70F93FB5F5488DED535E4097A8FF28C1363F40000000A0A7FAF93F8453A581ED535E409D9A2E38C1363F4000000020BCA8F93F7633A31FED535E40850D5EDAC1363F4000000040C67FF93F0DC6CF19ED535E4049C64BE6C1363F4000000040C67FF93F6E011DBDEC535E40E42023CBC2363F40000000E07B8DF93F6CA9D7BBEC535E40FCE7E0CEC2363F40000000E07B8DF93FE59B6D6EEC535E4054785BDFC3363F40000000205D08FA3FD73FE065EC535E40B9FE4603C4363F40000000205D08FA3F72F3322FEC535E409B2DB116C5363F400000004015B0F93F9C680121EC535E40E8E0B26DC5363F40000000801F87F93F287C3F00EC535E40D6A13567C6363F40000000801F87F93F592479F0EB535E406BAB6E02C7363F40000000801F87F93FD32B35E0EB535E40942780CAC7363F4000000040075DF93F150705E2EB535E40761A01C6C7363F4000000040075DF93FD32B35E0EB535E40942780CAC7363F4000000040075DF93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 14:10:08.377871', '2025-06-04 14:10:08.377871', 'virtual', NULL, 0, 'generate', 99, '0', '8645924713383591836', '8645924713383591853', 1, 1);
INSERT INTO public.lane VALUES ('8642698677548220410', 100001, '01020000A0E61000000500000098DD0A96E7535E4082E472C3BC363F40000000C004F5F83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F6065498DE4535E40BE82042ABB363F40000000E05D4BF83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F3AED54B9E3535E40E891CFC3BA363F4000000000183AF83F', '2025-06-04 14:10:09.044243', '2025-06-04 14:10:09.044243', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591816', '8645924713383591818', 1, 1);
INSERT INTO public.lane VALUES ('8642698677548220372', 100001, '01020000A0E61000001400000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93FDAFD1B95EA535E402A916AF6C5363F4000000040810CFA3F94BC0A8EEA535E40E29AF16CC5363F40000000808BE3F93F636EF973EA535E40B3BF1920C4363F40000000808BE3F93FFC1E9766EA535E40492FF8A1C3363F40000000C095BAF93F7FB7993AEA535E40A3C8465FC2363F40000000C095BAF93FA9708529EA535E404FD2CEF9C1363F40000000E073CBF93F84C401EAE9535E403E1B7FC3C0363F40000000608879F93F472B40D9E9535E404A58077FC0363F40000000A09250F93FC33B4784E9535E405172545CBF363F40000000A09250F93F0AB16A78E9535E402DC7383ABF363F40000000E09C27F93F460D8A0CE9535E409365CD37BE363F4000000060F948F93F15F0D508E9535E407B337430BE363F4000000060F948F93F4D9FB58CE8535E40224D1A75BD363F40000000206B3FF93F6AC2D585E8535E40BD6F516DBD363F40000000206B3FF93FD1487CD5E7535E40B7B219E7BC363F40000000C004F5F83F39F46C0FE8535E40228CF00DBD363F40000000607516F93FE6C4B4F5E7535E40B1321AF9BC363F40000000C004F5F83FD1487CD5E7535E40B7B219E7BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 14:10:10.323629', '2025-06-04 14:10:10.323629', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271583', '8645782395347271584', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507131', 100001, '01020000A0E61000000300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F036CDAA1EE535E40114D1596BC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 11:30:21.103071', '2025-06-04 11:30:21.103071', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271659', '8645782395347271658', 1, 1);
INSERT INTO public.lane VALUES ('8642718640556212142', 100001, '01020000A0E61000001300000013D44175EB535E40D5BD045DB1363F4000000060BC91FA3F09A69A59EB535E403399368BB3363F4000000060BC91FA3FF66A9E28EB535E400E3B2667B5363F40000000A01101FB3F57A15320EB535E407F3AD4A5B5363F40000000A01101FB3FA1164BDDEA535E409CB9E03CB7363F40000000A01101FB3FC04AB2CCEA535E403D950690B7363F4000000000C307FB3F02DAD27AEA535E4095160AE5B8363F400000006068AEFA3F6D8B2D62EA535E40E31A533BB9363F400000006068AEFA3FC1916B03EA535E40FAA53451BA363F400000006068AEFA3FAC73A4E4E9535E40D6E2C09CBA363F400000006068AEFA3F7D3E537AE9535E407040E373BB363F40000000A07285FA3F6C522558E9535E40593606ACBB363F4000000060235EFA3FAE11A5E3E8535E40B290DC41BC363F40000000A02D35FA3F9C7CEAC0E8535E403AE51863BC363F400000002042E3F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F30506644E8535E40FFDFD6B2BC363F40000000E06068F93F8320AF23E8535E40BDA34ABDBC363F40000000607516F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 11:44:47.771195', '2025-06-04 11:44:47.771195', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271617', '8645782395347271616', 1, 1);
INSERT INTO public.lane VALUES ('8642660435159416832', 100001, '01020000A0E61000001400000048A3CD34EB535E40408843BAC8363F4000000080BF7BFA3FF99CCD40EB535E40BEA7CD93C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 14:10:09.702429', '2025-06-04 14:10:09.702429', 'virtual', 'null', 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507135', 100001, '01020000A0E6100000030000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F15AD58D3E7535E40E7AE7BE4BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 11:30:24.14325', '2025-06-04 11:30:24.14325', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271662', '8645782395347271663', 1, 1);
INSERT INTO public.lane VALUES ('8642698677548220380', 100001, '01020000A0E6100000160000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F908E8212EC535E4021E04854B3363F4000000020DB16FA3F6512B61EEC535E40036CD5E8B4363F40000000E04434FA3FF592C920EC535E402C6ADC0DB5363F40000000204F0BFA3FB4CBB73EEC535E40F6378C75B6363F400000002001EAF93F66F67E45EC535E40BA6C88B2B6363F40000000C0EC3BFA3FA8D59772EC535E4007E064F0B7363F400000002001EAF93FDD14707EEC535E409C325334B8363F40000000E0F612FA3FA97CD7B9EC535E40BFA7284DB9363F40000000E014B3F93F5938E6C8EC535E409BDAD588B9363F4000000020F62DFA3F79880713ED535E40004EB07EBA363F40000000A00ADCF93F81740A22ED535E40068B90A8BA363F40000000A00ADCF93F4C92BE7BED535E4011996678BB363F40000000602961F93F3CB70387ED535E407C0AED8DBB363F40000000602961F93F1AA4B0F0ED535E40A0B4B92FBC363F40000000005230F93F6B57F0F4ED535E40A07DC634BC363F40000000005230F93F15813D68EE535E40D573E997BC363F40000000405C07F93FBCCE3A6EEE535E40CF477C9BBC363F40000000405C07F93F390C6FA1EE535E409A020EABBC363F40000000405C07F93F77E66CA1EE535E409F9916ABBC363F400000008066DEF83F390C6FA1EE535E409A020EABBC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 14:10:10.932367', '2025-06-04 14:10:10.932367', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271614', '8645782395347271615', 1, 1);
INSERT INTO public.lane VALUES ('8642698677548220393', 100001, '01020000A0E610000003000000EFCB6143EC535E404033DE0FA5363F40000000A0E94FFA3FC18E971FEC535E40057B3250B0363F4000000020DB16FA3F3E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F', '2025-06-04 14:10:11.539177', '2025-06-04 14:10:11.539177', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271639', '8645782395347271637', 2, 1);
INSERT INTO public.lane VALUES ('8642698677548220406', 100001, '01020000A0E610000006000000E647666FF5535E405BB4DF5EC2363F40000000C066EBF73F7AE31B3FF1535E409852C20CC0363F40000000605AD4F83F58054923EF535E4063E775DDBE363F40000000002F01FA3F229B589EEF535E408CA8F322BF363F4000000000585DF93F58054923EF535E4063E775DDBE363F40000000002F01FA3F5C29BAE4EE535E40E6B320BABE363F40000000803114FA3F', '2025-06-04 14:10:12.146856', '2025-06-04 14:10:12.147855', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591799', '8645924713383591876', 1, 1);
INSERT INTO public.lane VALUES ('8642698677548220408', 100001, '01020000A0E610000004000000E25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83FC359A750F1535E40CEE61D19BE363F40000000608330F83FBE6DFC42F5535E407A502051C0363F4000000040500BF73F0AE9A281F5535E40E5BE5B74C0363F40000000001DD8F73F', '2025-06-04 14:10:12.755165', '2025-06-04 14:10:12.755165', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591798', '8645924713383591800', 1, 1);
INSERT INTO public.lane VALUES ('8642698677548220416', 100001, '01020000A0E61000001800000047DB93E8EE535E40730DB76CC2363F40000000601F2BF83F4DB70866EE535E40D2818998C2363F40000000601F2BF83F6AE30936EE535E40903F67BEC2363F40000000201554F83FBDA3DD20EE535E40D833E4D5C2363F40000000601F2BF83FD24B2CF3ED535E40AE2DFA12C3363F40000000E00A7DF83FC81A3AE5ED535E406D324028C3363F40000000201554F83F180405C7ED535E401F378761C3363F40000000201554F83F54E6119CED535E406C624EBEC3363F4000000060B997F83F1E97C49BED535E4072A80FBFC3363F4000000060B997F83F326CBD74ED535E40A2110932C4363F40000000E0A4E9F83F51CAED5CED535E40079C3D81C4363F40000000E0A4E9F83FD4C7F54FED535E400CBC7EB4C4363F4000000020AFC0F83F991E292FED535E407D582346C5363F4000000060B997F83F5D6FC629ED535E40189C4260C5363F4000000060B997F83F144DCD09ED535E40D6DA751BC6363F4000000000D81CF83F917CD901ED535E40BE65FD4FC6363F4000000000D81CF83F70208CEEEC535E403BDC20F0C6363F4000000040E2F3F73FF28E5BE5EC535E40EDB0084CC7363F400000000002E4F73FEE6C37DDEC535E4088FCB9BCC7363F400000000002E4F73F282511D5EC535E40CFE2BD51C8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F4B51D3D3EC535E40E742297DC8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F5AD1FDD4EC535E40D43B9DAAC9363F40000000C02069F73F', '2025-06-04 14:10:13.36436', '2025-06-04 14:10:13.36436', 'virtual', '["non_motor_vehicle","walker"]', 0, 'generate', 99, '0', '8645924713383591843', '8645924713383591842', 1, 1);
INSERT INTO public.lane VALUES ('8642698677548220405', 100001, '01020000A0E610000007000000DFE39D5AF5535E40AD120647C4363F40000000C08F47F73F6CB106E8F1535E40087F9160C2363F40000000809B68F73F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93FB743268DEF535E402091A20DC1363F40000000C076E2F83F11928B85EF535E40A3C25209C1363F400000000081B9F83F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93F4A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F', '2025-06-04 14:10:13.979839', '2025-06-04 14:10:13.979839', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591876', '8645924713383591870', 2, 1);
INSERT INTO public.lane VALUES ('8642698677548220366', 100001, '01020000A0E61000000600000044447194EA535E40DB050E5EF7363F4000000040D7F0F73FB25858AAEA535E407361B6FAF0363F400000000069EAF83F64EEBAB4EA535E40E0629EC5ED363F400000000069EAF83F572447B6EA535E4004DEAB51ED363F40000000206D0EF93F08121BF9EA535E4019D65215DA363F40000000603131F93FE4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F', '2025-06-04 14:10:14.58969', '2025-06-04 14:10:14.58969', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558709', '8645275692285558705', 1, 1);
INSERT INTO public.lane VALUES ('8642698677548220365', 100001, '01020000A0E610000006000000F9A0B8FAE9535E40341C183EF7363F40000000C0EB9EF73F3661F811EA535E40B4BD2CD9F0363F40000000009246F83FB0C08F1EEA535E403F018B31ED363F4000000020966AF83FD03C5D36EA535E40D83D9865E6363F40000000E0C22CF83F05E13A61EA535E4090574DFBD9363F40000000C0399CF83FFBC65165EA535E406DB11ACCD8363F40000000802FC5F83F', '2025-06-04 14:10:15.196626', '2025-06-04 14:10:15.196626', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645275692285558705', '8645275692285558706', 2, 1);
INSERT INTO public.lane VALUES ('8642698677548220362', 100001, '01020000A0E61000000600000018F0CF98EB535E40D82935FFD8363F40000000A06464F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73F33AD8255EB535E40049892E2EC363F40000000807640F83F062D0352EB535E40E5FAA4FEED363F40000000E09D11F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73FE8E1FC34EB535E408783C18BF7363F400000008030F0F73F', '2025-06-04 14:10:15.806352', '2025-06-04 14:10:15.806352', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558708', '8645275692285558707', 1, 1);
INSERT INTO public.lane VALUES ('8642698677548220360', 100001, '01020000A0E610000005000000E4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F71AAB530EB535E4033FB20F1C9363F4000000000D429FA3F77AFA426EB535E40566526EBCC363F40000000A09920FA3F71AAB530EB535E4033FB20F1C9363F4000000000D429FA3F48A3CD34EB535E40408843BAC8363F4000000080BF7BFA3F', '2025-06-04 14:10:16.411571', '2025-06-04 14:10:16.411571', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271283', '8645782395347271285', 1, 1);
INSERT INTO public.lane VALUES ('8642698677548220359', 100001, '01020000A0E610000005000000FBC65165EA535E406DB11ACCD8363F40000000802FC5F83F4C982E99EA535E400A403990C9363F40000000002485F93FEF8F5F8EEA535E409137BECBCC363F4000000040F573F93F4C982E99EA535E400A403990C9363F40000000002485F93F69FC209DEA535E40ED3D3963C8363F40000000C019AEF93F', '2025-06-04 14:10:17.025502', '2025-06-04 14:10:17.025502', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271285', '8645782395347271291', 2, 1);
INSERT INTO public.lane VALUES ('8642875801999507117', 100001, '01020000A0E61000001300000013D44175EB535E40D5BD045DB1363F4000000060BC91FA3F09A69A59EB535E403399368BB3363F4000000060BC91FA3FF66A9E28EB535E400E3B2667B5363F40000000A01101FB3F57A15320EB535E407F3AD4A5B5363F40000000A01101FB3FA1164BDDEA535E409CB9E03CB7363F40000000A01101FB3FC04AB2CCEA535E403D950690B7363F4000000000C307FB3F02DAD27AEA535E4095160AE5B8363F400000006068AEFA3F6D8B2D62EA535E40E31A533BB9363F400000006068AEFA3FC1916B03EA535E40FAA53451BA363F400000006068AEFA3FAC73A4E4E9535E40D6E2C09CBA363F400000006068AEFA3F7D3E537AE9535E407040E373BB363F40000000A07285FA3F6C522558E9535E40593606ACBB363F4000000060235EFA3FAE11A5E3E8535E40B290DC41BC363F40000000A02D35FA3F9C7CEAC0E8535E403AE51863BC363F400000002042E3F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F30506644E8535E40FFDFD6B2BC363F40000000E06068F93F8320AF23E8535E40BDA34ABDBC363F40000000607516F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 11:20:03.788395', '2025-06-04 11:20:03.788395', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271617', '8645782395347271616', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507084', 100001, '01020000A0E610000015000000C2227AAAE7535E40D6005ECCBA363F4000000000BD13FA3F3314AF66E8535E4065ABD0E2BA363F40000000A02D35FA3FDC0073FAE8535E4017B46047BB363F4000000060235EFA3FA58A3D0FE9535E40FF2A2A5CBB363F4000000060235EFA3F59EF5BA0E9535E40CFA63C1DBC363F40000000A07285FA3F8E3B5EAEE9535E40BD70F134BC363F40000000A07285FA3F5A84D939EA535E40752A8D56BD363F40000000A07285FA3FA7F8553FEA535E4087EC5B64BD363F400000006068AEFA3FF63ED9BDEA535E401B8FF1DFBE363F400000006036C1FA3F20CBB0C1EA535E40A46EB3EDBE363F400000006036C1FA3FA0275426EB535E40F7BEB19AC0363F4000000060B307FB3FF7F68B32EB535E40622757D9C0363F40000000A0BDDEFA3FFF78F176EB535E400267E283C2363F4000000040C3F7FA3FFA430D88EB535E40D8BC1C09C3363F4000000080CDCEFA3F743F9DAEEB535E40305CBD8DC4363F40000000C0D7A5FA3F95304FBEEB535E407DD77C69C5363F4000000040EC53FA3F710142CDEB535E404114BAB5C6363F40000000C00002FA3F951065D5EB535E405E4619C0C7363F4000000000FD85F93F6A97E3D3EB535E40C90E7DB9C7363F4000000000FD85F93F951065D5EB535E405E4619C0C7363F4000000000FD85F93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 11:30:22.331094', '2025-06-04 11:30:22.331094', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271661', '8645782395347271660', 1, 1);
INSERT INTO public.lane VALUES ('8642698677548220352', 100001, '01020000A0E610000004000000A22B20D3EB535E4004738C15C9363F40000000801134F93F9035A9BCEB535E40968224A2CE363F4000000060E101F93F31601A9DEB535E40D3CABFC1D7363F40000000605A8DF83F18F0CF98EB535E40D82935FFD8363F40000000A06464F83F', '2025-06-04 14:10:17.633152', '2025-06-04 14:10:17.633152', 'driving', 'null', 0, 'generate', 99, '0', '8645782395347271282', '8645782395347271280', 1, 1);
INSERT INTO public.lane VALUES ('8642660435159416799', 100001, '01020000A0E61000001300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F307A2F3DE8535E4084AC16F4B8363F40000000E06068F93F36331E98E8535E40365884D7B8363F40000000604CBAF93F0A534ABEE8535E40D707E5BFB8363F40000000604CBAF93FC32F6C02E9535E4048665380B8363F40000000200AF4F93F4ABB313AE9535E40FB6BE939B8363F40000000E0FF1CFA3FB5BB8667E9535E40C611BFF0B7363F40000000E0FF1CFA3F1DA849ACE9535E40A83C8267B7363F4000000000EC63FA3F1AF228C5E9535E4079C75C2BB7363F4000000000EC63FA3F19105C10EA535E40F6097A51B6363F4000000040F63AFA3FEC2E2019EA535E40FCEA3533B6363F4000000040F63AFA3FE1560761EA535E4068944F0BB5363F4000000040F63AFA3F6306A962EA535E404A1C3503B5363F4000000040F63AFA3FC8010F9AEA535E40E0B878B7B3363F40000000A05DFEF93F6F4F0CA0EA535E4063A2C28AB3363F40000000204950FA3F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93F7D4166C2EA535E40EC2A4943B2363F40000000A05DFEF93F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 14:17:19.808143', '2025-06-04 14:17:19.808143', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271618', '8645782395347271619', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507110', 100001, '01020000A0E6100000110000005C29BAE4EE535E40E6B320BABE363F40000000803114FA3FF48E8D1FEE535E405D7ED048BE363F4000000040273DFA3F35C12168ED535E4034801A6BBD363F4000000060D7A8FA3FC291AA67ED535E4034D1616ABD363F4000000060D7A8FA3F661FF9BDEC535E40F3F97C22BC363F4000000020CDD1FA3F6FEEC6BAEC535E403B89F41ABC363F4000000020CDD1FA3F5229FF25EC535E40DC9CFE77BA363F40000000C0260FFB3F89078522EC535E403B6E446CBA363F400000000031E6FA3F7DE7ECA4EB535E4096D0F075B8363F4000000020FD52FB3F3A1249A3EB535E40A279126EB8363F4000000020FD52FB3F2D438E40EB535E405B4E9531B6363F40000000A01101FB3FDA515D3FEB535E4073760F29B6363F40000000A01101FB3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3F915FC3FCEA535E40FD13F4C8B3363F4000000020B2BAFA3F4004C9F9EA535E40924747A4B3363F4000000060BC91FA3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 11:17:05.096258', '2025-06-04 11:17:05.096258', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271590', '8645782395347271591', 1, 1);
INSERT INTO public.lane VALUES ('8642765198001700860', 100001, '01020000A0E61000001300000013D44175EB535E40D5BD045DB1363F4000000060BC91FA3F09A69A59EB535E403399368BB3363F4000000060BC91FA3FF66A9E28EB535E400E3B2667B5363F40000000A01101FB3F57A15320EB535E407F3AD4A5B5363F40000000A01101FB3FA1164BDDEA535E409CB9E03CB7363F40000000A01101FB3FC04AB2CCEA535E403D950690B7363F4000000000C307FB3F02DAD27AEA535E4095160AE5B8363F400000006068AEFA3F6D8B2D62EA535E40E31A533BB9363F400000006068AEFA3FC1916B03EA535E40FAA53451BA363F400000006068AEFA3FAC73A4E4E9535E40D6E2C09CBA363F400000006068AEFA3F7D3E537AE9535E407040E373BB363F40000000A07285FA3F6C522558E9535E40593606ACBB363F4000000060235EFA3FAE11A5E3E8535E40B290DC41BC363F40000000A02D35FA3F9C7CEAC0E8535E403AE51863BC363F400000002042E3F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F30506644E8535E40FFDFD6B2BC363F40000000E06068F93F8320AF23E8535E40BDA34ABDBC363F40000000607516F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 11:23:26.448437', '2025-06-04 11:23:26.448437', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271617', '8645782395347271616', 1, 1);
INSERT INTO public.lane VALUES ('8642765198001700857', 100001, '01020000A0E61000001300000013D44175EB535E40D5BD045DB1363F4000000060BC91FA3F09A69A59EB535E403399368BB3363F4000000060BC91FA3FF66A9E28EB535E400E3B2667B5363F40000000A01101FB3F57A15320EB535E407F3AD4A5B5363F40000000A01101FB3FA1164BDDEA535E409CB9E03CB7363F40000000A01101FB3FC04AB2CCEA535E403D950690B7363F4000000000C307FB3F02DAD27AEA535E4095160AE5B8363F400000006068AEFA3F6D8B2D62EA535E40E31A533BB9363F400000006068AEFA3FC1916B03EA535E40FAA53451BA363F400000006068AEFA3FAC73A4E4E9535E40D6E2C09CBA363F400000006068AEFA3F7D3E537AE9535E407040E373BB363F40000000A07285FA3F6C522558E9535E40593606ACBB363F4000000060235EFA3FAE11A5E3E8535E40B290DC41BC363F40000000A02D35FA3F9C7CEAC0E8535E403AE51863BC363F400000002042E3F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F30506644E8535E40FFDFD6B2BC363F40000000E06068F93F8320AF23E8535E40BDA34ABDBC363F40000000607516F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 11:27:02.368641', '2025-06-04 11:27:02.369638', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271617', '8645782395347271616', 1, 1);
INSERT INTO public.lane VALUES ('8642765198001700864', 100001, '01020000A0E6100000110000005C29BAE4EE535E40E6B320BABE363F40000000803114FA3FF48E8D1FEE535E405D7ED048BE363F4000000040273DFA3F35C12168ED535E4034801A6BBD363F4000000060D7A8FA3FC291AA67ED535E4034D1616ABD363F4000000060D7A8FA3F661FF9BDEC535E40F3F97C22BC363F4000000020CDD1FA3F6FEEC6BAEC535E403B89F41ABC363F4000000020CDD1FA3F5229FF25EC535E40DC9CFE77BA363F40000000C0260FFB3F89078522EC535E403B6E446CBA363F400000000031E6FA3F7DE7ECA4EB535E4096D0F075B8363F4000000020FD52FB3F3A1249A3EB535E40A279126EB8363F4000000020FD52FB3F2D438E40EB535E405B4E9531B6363F40000000A01101FB3FDA515D3FEB535E4073760F29B6363F40000000A01101FB3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3F915FC3FCEA535E40FD13F4C8B3363F4000000020B2BAFA3F4004C9F9EA535E40924747A4B3363F4000000060BC91FA3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 11:30:27.737096', '2025-06-04 11:30:27.737096', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271590', '8645782395347271591', 1, 1);
INSERT INTO public.lane VALUES ('8642743998043127808', 100001, '01020000A0E61000001300000013D44175EB535E40D5BD045DB1363F4000000060BC91FA3F09A69A59EB535E403399368BB3363F4000000060BC91FA3FF66A9E28EB535E400E3B2667B5363F40000000A01101FB3F57A15320EB535E407F3AD4A5B5363F40000000A01101FB3FA1164BDDEA535E409CB9E03CB7363F40000000A01101FB3FC04AB2CCEA535E403D950690B7363F4000000000C307FB3F02DAD27AEA535E4095160AE5B8363F400000006068AEFA3F6D8B2D62EA535E40E31A533BB9363F400000006068AEFA3FC1916B03EA535E40FAA53451BA363F400000006068AEFA3FAC73A4E4E9535E40D6E2C09CBA363F400000006068AEFA3F7D3E537AE9535E407040E373BB363F40000000A07285FA3F6C522558E9535E40593606ACBB363F4000000060235EFA3FAE11A5E3E8535E40B290DC41BC363F40000000A02D35FA3F9C7CEAC0E8535E403AE51863BC363F400000002042E3F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F30506644E8535E40FFDFD6B2BC363F40000000E06068F93F8320AF23E8535E40BDA34ABDBC363F40000000607516F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 11:30:31.384166', '2025-06-04 11:30:31.384166', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271617', '8645782395347271616', 1, 1);
INSERT INTO public.lane VALUES ('8642718640556212139', 100001, '01020000A0E61000001300000013D44175EB535E40D5BD045DB1363F4000000060BC91FA3F09A69A59EB535E403399368BB3363F4000000060BC91FA3FF66A9E28EB535E400E3B2667B5363F40000000A01101FB3F57A15320EB535E407F3AD4A5B5363F40000000A01101FB3FA1164BDDEA535E409CB9E03CB7363F40000000A01101FB3FC04AB2CCEA535E403D950690B7363F4000000000C307FB3F02DAD27AEA535E4095160AE5B8363F400000006068AEFA3F6D8B2D62EA535E40E31A533BB9363F400000006068AEFA3FC1916B03EA535E40FAA53451BA363F400000006068AEFA3FAC73A4E4E9535E40D6E2C09CBA363F400000006068AEFA3F7D3E537AE9535E407040E373BB363F40000000A07285FA3F6C522558E9535E40593606ACBB363F4000000060235EFA3FAE11A5E3E8535E40B290DC41BC363F40000000A02D35FA3F9C7CEAC0E8535E403AE51863BC363F400000002042E3F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F30506644E8535E40FFDFD6B2BC363F40000000E06068F93F8320AF23E8535E40BDA34ABDBC363F40000000607516F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 11:49:35.921439', '2025-06-04 11:49:35.921439', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271617', '8645782395347271616', 1, 1);
INSERT INTO public.lane VALUES ('8642698677548220394', 100001, '01020000A0E610000003000000183ECCA5EB535E40701ECDDFA4363F4000000080FD9EFA3F1691F679EB535E40F3608825B0363F4000000020B2BAFA3F13D44175EB535E40D5BD045DB1363F4000000060BC91FA3F', '2025-06-04 14:10:00.641913', '2025-06-04 14:10:00.641913', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271640', '8645782395347271639', 1, 1);
INSERT INTO public.lane VALUES ('8642698677548220376', 100001, '01020000A0E6100000110000005C29BAE4EE535E40E6B320BABE363F40000000803114FA3FF48E8D1FEE535E405D7ED048BE363F4000000040273DFA3F35C12168ED535E4034801A6BBD363F4000000060D7A8FA3FC291AA67ED535E4034D1616ABD363F4000000060D7A8FA3F661FF9BDEC535E40F3F97C22BC363F4000000020CDD1FA3F6FEEC6BAEC535E403B89F41ABC363F4000000020CDD1FA3F5229FF25EC535E40DC9CFE77BA363F40000000C0260FFB3F89078522EC535E403B6E446CBA363F400000000031E6FA3F7DE7ECA4EB535E4096D0F075B8363F4000000020FD52FB3F3A1249A3EB535E40A279126EB8363F4000000020FD52FB3F2D438E40EB535E405B4E9531B6363F40000000A01101FB3FDA515D3FEB535E4073760F29B6363F40000000A01101FB3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3F915FC3FCEA535E40FD13F4C8B3363F4000000020B2BAFA3F4004C9F9EA535E40924747A4B3363F4000000060BC91FA3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 14:10:01.273426', '2025-06-04 14:10:01.273426', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271590', '8645782395347271591', 1, 1);
INSERT INTO public.lane VALUES ('8642698677548220390', 100001, '01020000A0E610000003000000B20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F4096E203EB535E4028B1EAFAA5363F40000000600BCFFA3FAEF13109EB535E40D55809B0A4363F40000000C00776FA3F', '2025-06-04 14:10:01.885356', '2025-06-04 14:10:01.885356', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271633', '8645782395347271634', 1, 1);
INSERT INTO public.lane VALUES ('8642698677548220388', 100001, '01020000A0E61000001300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F307A2F3DE8535E4084AC16F4B8363F40000000E06068F93F36331E98E8535E40365884D7B8363F40000000604CBAF93F0A534ABEE8535E40D707E5BFB8363F40000000604CBAF93FC32F6C02E9535E4048665380B8363F40000000200AF4F93F4ABB313AE9535E40FB6BE939B8363F40000000E0FF1CFA3FB5BB8667E9535E40C611BFF0B7363F40000000E0FF1CFA3F1DA849ACE9535E40A83C8267B7363F4000000000EC63FA3F1AF228C5E9535E4079C75C2BB7363F4000000000EC63FA3F19105C10EA535E40F6097A51B6363F4000000040F63AFA3FEC2E2019EA535E40FCEA3533B6363F4000000040F63AFA3FE1560761EA535E4068944F0BB5363F4000000040F63AFA3F6306A962EA535E404A1C3503B5363F4000000040F63AFA3FC8010F9AEA535E40E0B878B7B3363F40000000A05DFEF93F6F4F0CA0EA535E4063A2C28AB3363F40000000204950FA3F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93F7D4166C2EA535E40EC2A4943B2363F40000000A05DFEF93F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 14:10:02.496877', '2025-06-04 14:10:02.496877', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271618', '8645782395347271619', 1, 1);
INSERT INTO public.lane VALUES ('8642698677548220369', 100001, '01020000A0E61000000300000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93F6FD844D3EA535E40E0A8A551B2363F4000000020DB16FA3FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 14:10:03.172442', '2025-06-04 14:10:03.172442', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271581', '8645782395347271582', 1, 1);
INSERT INTO public.lane VALUES ('8642698677548220413', 100001, '01020000A0E610000006000000E2EA72DDE3535E40C0E6F1BBB6363F400000004033F3F83FA711BEEDE5535E40BA3A8BD4B7363F40000000A014EDF83F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93FC5016651E7535E40FB8DCF94B8363F40000000A02255F93F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93F24ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F', '2025-06-04 14:10:03.785083', '2025-06-04 14:10:03.785083', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591814', '8645924713383591813', 2, 1);
INSERT INTO public.lane VALUES ('8642698677548220384', 100001, '01020000A0E61000001300000013D44175EB535E40D5BD045DB1363F4000000060BC91FA3F09A69A59EB535E403399368BB3363F4000000060BC91FA3FF66A9E28EB535E400E3B2667B5363F40000000A01101FB3F57A15320EB535E407F3AD4A5B5363F40000000A01101FB3FA1164BDDEA535E409CB9E03CB7363F40000000A01101FB3FC04AB2CCEA535E403D950690B7363F4000000000C307FB3F02DAD27AEA535E4095160AE5B8363F400000006068AEFA3F6D8B2D62EA535E40E31A533BB9363F400000006068AEFA3FC1916B03EA535E40FAA53451BA363F400000006068AEFA3FAC73A4E4E9535E40D6E2C09CBA363F400000006068AEFA3F7D3E537AE9535E407040E373BB363F40000000A07285FA3F6C522558E9535E40593606ACBB363F4000000060235EFA3FAE11A5E3E8535E40B290DC41BC363F40000000A02D35FA3F9C7CEAC0E8535E403AE51863BC363F400000002042E3F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F30506644E8535E40FFDFD6B2BC363F40000000E06068F93F8320AF23E8535E40BDA34ABDBC363F40000000607516F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 14:10:05.046668', '2025-06-04 14:10:05.046668', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271617', '8645782395347271616', 1, 1);
INSERT INTO public.lane VALUES ('8642698677548220414', 100001, '01020000A0E610000005000000932E26CBE3535E408A32ACC6B8363F40000000E034EFF83FDC552EA5E5535E40C594BFB0B9363F40000000808869F93F2F533A28E6535E40CB0F27F3B9363F40000000805F0DFA3F16DF046AE7535E40BE7629A8BA363F4000000040C7EAF93FC2227AAAE7535E40D6005ECCBA363F4000000000BD13FA3F', '2025-06-04 14:10:05.673031', '2025-06-04 14:10:05.673031', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591815', '8645924713383591814', 1, 1);
INSERT INTO public.lane VALUES ('8642698677548220398', 100001, '01020000A0E61000000300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F036CDAA1EE535E40114D1596BC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 14:10:06.305574', '2025-06-04 14:10:06.305574', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271659', '8645782395347271658', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646106', 100001, '01020000A0E6100000080000002E40F9C0F0535E40D801B4069F363F4000000040E17AF4BFDB3129C9F0535E406AAC4674A4363F4000000040E17AF4BF5E7D2DC9F0535E4017D56977A4363F4000000040E17AF4BF6D4175C7F0535E4046DB08F6A5363F4000000040E17AF4BFF30BA7B3F0535E40573C7981A7363F4000000040E17AF4BF86C47FB2F0535E401B2477EAA7363F4000000040E17AF4BF30F9FAB5F0535E40917BB501AA363F4000000040E17AF4BFAF053CB7F0535E4013467196AB363F4000000040E17AF4BF', '2025-06-04 17:28:38.000011', '2025-06-04 17:28:38.000011', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '1', '8642101470935646119', '8642101470935646118', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507080', 100001, '01020000A0E61000001400000048A3CD34EB535E40408843BAC8363F4000000080BF7BFA3FF99CCD40EB535E40BEA7CD93C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 11:30:22.934771', '2025-06-04 11:30:22.934771', 'virtual', 'null', 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507107', 100001, '01020000A0E61000001400000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93FDAFD1B95EA535E402A916AF6C5363F4000000040810CFA3F94BC0A8EEA535E40E29AF16CC5363F40000000808BE3F93F636EF973EA535E40B3BF1920C4363F40000000808BE3F93FFC1E9766EA535E40492FF8A1C3363F40000000C095BAF93F7FB7993AEA535E40A3C8465FC2363F40000000C095BAF93FA9708529EA535E404FD2CEF9C1363F40000000E073CBF93F84C401EAE9535E403E1B7FC3C0363F40000000608879F93F472B40D9E9535E404A58077FC0363F40000000A09250F93FC33B4784E9535E405172545CBF363F40000000A09250F93F0AB16A78E9535E402DC7383ABF363F40000000E09C27F93F460D8A0CE9535E409365CD37BE363F4000000060F948F93F15F0D508E9535E407B337430BE363F4000000060F948F93F4D9FB58CE8535E40224D1A75BD363F40000000206B3FF93F6AC2D585E8535E40BD6F516DBD363F40000000206B3FF93FD1487CD5E7535E40B7B219E7BC363F40000000C004F5F83F39F46C0FE8535E40228CF00DBD363F40000000607516F93FE6C4B4F5E7535E40B1321AF9BC363F40000000C004F5F83FD1487CD5E7535E40B7B219E7BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 11:30:23.537797', '2025-06-04 11:30:23.537797', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271583', '8645782395347271584', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507076', 100001, '01020000A0E6100000140000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F34611266EE535E40CD9D759AC0363F40000000805A70F93F20F45001EE535E401A1986BDC0363F40000000405099F93FF3D48DF1ED535E4044CCDBC7C0363F40000000805A70F93FB5F5488DED535E4097A8FF28C1363F40000000A0A7FAF93F8453A581ED535E409D9A2E38C1363F4000000020BCA8F93F7633A31FED535E40850D5EDAC1363F4000000040C67FF93F0DC6CF19ED535E4049C64BE6C1363F4000000040C67FF93F6E011DBDEC535E40E42023CBC2363F40000000E07B8DF93F6CA9D7BBEC535E40FCE7E0CEC2363F40000000E07B8DF93FE59B6D6EEC535E4054785BDFC3363F40000000205D08FA3FD73FE065EC535E40B9FE4603C4363F40000000205D08FA3F72F3322FEC535E409B2DB116C5363F400000004015B0F93F9C680121EC535E40E8E0B26DC5363F40000000801F87F93F287C3F00EC535E40D6A13567C6363F40000000801F87F93F592479F0EB535E406BAB6E02C7363F40000000801F87F93FD32B35E0EB535E40942780CAC7363F4000000040075DF93F150705E2EB535E40761A01C6C7363F4000000040075DF93FD32B35E0EB535E40942780CAC7363F4000000040075DF93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 11:30:24.743233', '2025-06-04 11:30:24.743233', 'virtual', NULL, 0, 'generate', 99, '0', '8645924713383591836', '8645924713383591853', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507114', 100001, '01020000A0E6100000160000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F908E8212EC535E4021E04854B3363F4000000020DB16FA3F6512B61EEC535E40036CD5E8B4363F40000000E04434FA3FF592C920EC535E402C6ADC0DB5363F40000000204F0BFA3FB4CBB73EEC535E40F6378C75B6363F400000002001EAF93F66F67E45EC535E40BA6C88B2B6363F40000000C0EC3BFA3FA8D59772EC535E4007E064F0B7363F400000002001EAF93FDD14707EEC535E409C325334B8363F40000000E0F612FA3FA97CD7B9EC535E40BFA7284DB9363F40000000E014B3F93F5938E6C8EC535E409BDAD588B9363F4000000020F62DFA3F79880713ED535E40004EB07EBA363F40000000A00ADCF93F81740A22ED535E40068B90A8BA363F40000000A00ADCF93F4C92BE7BED535E4011996678BB363F40000000602961F93F3CB70387ED535E407C0AED8DBB363F40000000602961F93F1AA4B0F0ED535E40A0B4B92FBC363F40000000005230F93F6B57F0F4ED535E40A07DC634BC363F40000000005230F93F15813D68EE535E40D573E997BC363F40000000405C07F93FBCCE3A6EEE535E40CF477C9BBC363F40000000405C07F93F390C6FA1EE535E409A020EABBC363F40000000405C07F93F77E66CA1EE535E409F9916ABBC363F400000008066DEF83F390C6FA1EE535E409A020EABBC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 11:30:25.341372', '2025-06-04 11:30:25.341372', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271614', '8645782395347271615', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507146', 100001, '01020000A0E610000006000000E2EA72DDE3535E40C0E6F1BBB6363F400000004033F3F83FA711BEEDE5535E40BA3A8BD4B7363F40000000A014EDF83F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93FC5016651E7535E40FB8DCF94B8363F40000000A02255F93F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93F24ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F', '2025-06-04 11:30:25.946111', '2025-06-04 11:30:25.946111', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591814', '8645924713383591813', 2, 1);
INSERT INTO public.lane VALUES ('8642875801999507104', 100001, '01020000A0E61000000300000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93F6FD844D3EA535E40E0A8A551B2363F4000000020DB16FA3FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 11:30:26.54479', '2025-06-04 11:30:26.54479', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271581', '8645782395347271582', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507072', 100001, '01020000A0E6100000030000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93FA5391CD7EB535E408E9DA1CCC7363F4000000000FD85F93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 11:30:27.142638', '2025-06-04 11:30:27.142638', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271613', '8645782395347271612', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507121', 100001, '01020000A0E61000001300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F307A2F3DE8535E4084AC16F4B8363F40000000E06068F93F36331E98E8535E40365884D7B8363F40000000604CBAF93F0A534ABEE8535E40D707E5BFB8363F40000000604CBAF93FC32F6C02E9535E4048665380B8363F40000000200AF4F93F4ABB313AE9535E40FB6BE939B8363F40000000E0FF1CFA3FB5BB8667E9535E40C611BFF0B7363F40000000E0FF1CFA3F1DA849ACE9535E40A83C8267B7363F4000000000EC63FA3F1AF228C5E9535E4079C75C2BB7363F4000000000EC63FA3F19105C10EA535E40F6097A51B6363F4000000040F63AFA3FEC2E2019EA535E40FCEA3533B6363F4000000040F63AFA3FE1560761EA535E4068944F0BB5363F4000000040F63AFA3F6306A962EA535E404A1C3503B5363F4000000040F63AFA3FC8010F9AEA535E40E0B878B7B3363F40000000A05DFEF93F6F4F0CA0EA535E4063A2C28AB3363F40000000204950FA3F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93F7D4166C2EA535E40EC2A4943B2363F40000000A05DFEF93F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 11:30:28.337126', '2025-06-04 11:30:28.337126', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271618', '8645782395347271619', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507147', 100001, '01020000A0E610000005000000932E26CBE3535E408A32ACC6B8363F40000000E034EFF83FDC552EA5E5535E40C594BFB0B9363F40000000808869F93F2F533A28E6535E40CB0F27F3B9363F40000000805F0DFA3F16DF046AE7535E40BE7629A8BA363F4000000040C7EAF93FC2227AAAE7535E40D6005ECCBA363F4000000000BD13FA3F', '2025-06-04 11:30:28.937055', '2025-06-04 11:30:28.937055', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591815', '8645924713383591814', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507127', 100001, '01020000A0E610000003000000183ECCA5EB535E40701ECDDFA4363F4000000080FD9EFA3F1691F679EB535E40F3608825B0363F4000000020B2BAFA3F13D44175EB535E40D5BD045DB1363F4000000060BC91FA3F', '2025-06-04 11:30:29.542124', '2025-06-04 11:30:29.542124', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271640', '8645782395347271639', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507126', 100001, '01020000A0E610000003000000EFCB6143EC535E404033DE0FA5363F40000000A0E94FFA3FC18E971FEC535E40057B3250B0363F4000000020DB16FA3F3E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F', '2025-06-04 11:30:30.765998', '2025-06-04 11:30:30.765998', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271639', '8645782395347271637', 2, 1);
INSERT INTO public.lane VALUES ('8642875801999507141', 100001, '01020000A0E610000004000000E25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83FC359A750F1535E40CEE61D19BE363F40000000608330F83FBE6DFC42F5535E407A502051C0363F4000000040500BF73F0AE9A281F5535E40E5BE5B74C0363F40000000001DD8F73F', '2025-06-04 11:30:31.9804', '2025-06-04 11:30:31.9804', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591798', '8645924713383591800', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507139', 100001, '01020000A0E610000006000000E647666FF5535E405BB4DF5EC2363F40000000C066EBF73F7AE31B3FF1535E409852C20CC0363F40000000605AD4F83F58054923EF535E4063E775DDBE363F40000000002F01FA3F229B589EEF535E408CA8F322BF363F4000000000585DF93F58054923EF535E4063E775DDBE363F40000000002F01FA3F5C29BAE4EE535E40E6B320BABE363F40000000803114FA3F', '2025-06-04 11:30:32.587397', '2025-06-04 11:30:32.587397', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591799', '8645924713383591876', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507138', 100001, '01020000A0E610000007000000DFE39D5AF5535E40AD120647C4363F40000000C08F47F73F6CB106E8F1535E40087F9160C2363F40000000809B68F73F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93FB743268DEF535E402091A20DC1363F40000000C076E2F83F11928B85EF535E40A3C25209C1363F400000000081B9F83F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93F4A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F', '2025-06-04 11:30:33.192772', '2025-06-04 11:30:33.192772', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591876', '8645924713383591870', 2, 1);
INSERT INTO public.lane VALUES ('8642875801999507149', 100001, '01020000A0E61000001800000047DB93E8EE535E40730DB76CC2363F40000000601F2BF83F4DB70866EE535E40D2818998C2363F40000000601F2BF83F6AE30936EE535E40903F67BEC2363F40000000201554F83FBDA3DD20EE535E40D833E4D5C2363F40000000601F2BF83FD24B2CF3ED535E40AE2DFA12C3363F40000000E00A7DF83FC81A3AE5ED535E406D324028C3363F40000000201554F83F180405C7ED535E401F378761C3363F40000000201554F83F54E6119CED535E406C624EBEC3363F4000000060B997F83F1E97C49BED535E4072A80FBFC3363F4000000060B997F83F326CBD74ED535E40A2110932C4363F40000000E0A4E9F83F51CAED5CED535E40079C3D81C4363F40000000E0A4E9F83FD4C7F54FED535E400CBC7EB4C4363F4000000020AFC0F83F991E292FED535E407D582346C5363F4000000060B997F83F5D6FC629ED535E40189C4260C5363F4000000060B997F83F144DCD09ED535E40D6DA751BC6363F4000000000D81CF83F917CD901ED535E40BE65FD4FC6363F4000000000D81CF83F70208CEEEC535E403BDC20F0C6363F4000000040E2F3F73FF28E5BE5EC535E40EDB0084CC7363F400000000002E4F73FEE6C37DDEC535E4088FCB9BCC7363F400000000002E4F73F282511D5EC535E40CFE2BD51C8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F4B51D3D3EC535E40E742297DC8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F5AD1FDD4EC535E40D43B9DAAC9363F40000000C02069F73F', '2025-06-04 11:30:33.790173', '2025-06-04 11:30:33.790173', 'virtual', '["non_motor_vehicle","walker"]', 0, 'generate', 99, '0', '8645924713383591843', '8645924713383591842', 1, 1);
INSERT INTO public.lane VALUES ('8642875801999507094', 100001, '01020000A0E610000005000000FBC65165EA535E406DB11ACCD8363F40000000802FC5F83F4C982E99EA535E400A403990C9363F40000000002485F93FEF8F5F8EEA535E409137BECBCC363F4000000040F573F93F4C982E99EA535E400A403990C9363F40000000002485F93F69FC209DEA535E40ED3D3963C8363F40000000C019AEF93F', '2025-06-04 11:30:34.387217', '2025-06-04 11:30:34.388214', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271285', '8645782395347271291', 2, 1);
INSERT INTO public.lane VALUES ('8642875801999507087', 100001, '01020000A0E610000004000000A22B20D3EB535E4004738C15C9363F40000000801134F93F9035A9BCEB535E40968224A2CE363F4000000060E101F93F31601A9DEB535E40D3CABFC1D7363F40000000605A8DF83F18F0CF98EB535E40D82935FFD8363F40000000A06464F83F', '2025-06-04 11:30:34.984155', '2025-06-04 11:30:34.984155', 'driving', 'null', 0, 'generate', 99, '0', '8645782395347271282', '8645782395347271280', 1, 1);
INSERT INTO public.lane VALUES ('8642718640556212202', 100001, '01020000A0E610000003000000183ECCA5EB535E40701ECDDFA4363F4000000080FD9EFA3F1691F679EB535E40F3608825B0363F4000000020B2BAFA3F13D44175EB535E40D5BD045DB1363F4000000060BC91FA3F', '2025-06-04 11:49:33.534668', '2025-06-04 11:49:33.534668', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271640', '8645782395347271639', 1, 1);
INSERT INTO public.lane VALUES ('8642718640556212198', 100001, '01020000A0E610000003000000B20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F4096E203EB535E4028B1EAFAA5363F40000000600BCFFA3FAEF13109EB535E40D55809B0A4363F40000000C00776FA3F', '2025-06-04 11:49:34.131705', '2025-06-04 11:49:34.131705', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271633', '8645782395347271634', 1, 1);
INSERT INTO public.lane VALUES ('8642718640556212178', 100001, '01020000A0E61000000300000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93F6FD844D3EA535E40E0A8A551B2363F4000000020DB16FA3FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 11:49:34.735278', '2025-06-04 11:49:34.736276', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271581', '8645782395347271582', 1, 1);
INSERT INTO public.lane VALUES ('8642718640556212185', 100001, '01020000A0E6100000110000005C29BAE4EE535E40E6B320BABE363F40000000803114FA3FF48E8D1FEE535E405D7ED048BE363F4000000040273DFA3F35C12168ED535E4034801A6BBD363F4000000060D7A8FA3FC291AA67ED535E4034D1616ABD363F4000000060D7A8FA3F661FF9BDEC535E40F3F97C22BC363F4000000020CDD1FA3F6FEEC6BAEC535E403B89F41ABC363F4000000020CDD1FA3F5229FF25EC535E40DC9CFE77BA363F40000000C0260FFB3F89078522EC535E403B6E446CBA363F400000000031E6FA3F7DE7ECA4EB535E4096D0F075B8363F4000000020FD52FB3F3A1249A3EB535E40A279126EB8363F4000000020FD52FB3F2D438E40EB535E405B4E9531B6363F40000000A01101FB3FDA515D3FEB535E4073760F29B6363F40000000A01101FB3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3F915FC3FCEA535E40FD13F4C8B3363F4000000020B2BAFA3F4004C9F9EA535E40924747A4B3363F4000000060BC91FA3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 11:49:35.329538', '2025-06-04 11:49:35.329538', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271590', '8645782395347271591', 1, 1);
INSERT INTO public.lane VALUES ('8642718640556212221', 100001, '01020000A0E610000006000000E2EA72DDE3535E40C0E6F1BBB6363F400000004033F3F83FA711BEEDE5535E40BA3A8BD4B7363F40000000A014EDF83F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93FC5016651E7535E40FB8DCF94B8363F40000000A02255F93F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93F24ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F', '2025-06-04 11:49:36.513894', '2025-06-04 11:49:36.513894', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591814', '8645924713383591813', 2, 1);
INSERT INTO public.lane VALUES ('8642718640556212222', 100001, '01020000A0E610000005000000932E26CBE3535E408A32ACC6B8363F40000000E034EFF83FDC552EA5E5535E40C594BFB0B9363F40000000808869F93F2F533A28E6535E40CB0F27F3B9363F40000000805F0DFA3F16DF046AE7535E40BE7629A8BA363F4000000040C7EAF93FC2227AAAE7535E40D6005ECCBA363F4000000000BD13FA3F', '2025-06-04 11:49:37.103728', '2025-06-04 11:49:37.103728', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591815', '8645924713383591814', 1, 1);
INSERT INTO public.lane VALUES ('8642718640556212206', 100001, '01020000A0E61000000300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F036CDAA1EE535E40114D1596BC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 11:49:37.689534', '2025-06-04 11:49:37.689534', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271659', '8645782395347271658', 1, 1);
INSERT INTO public.lane VALUES ('8642718640556212218', 100001, '01020000A0E61000000500000098DD0A96E7535E4082E472C3BC363F40000000C004F5F83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F6065498DE4535E40BE82042ABB363F40000000E05D4BF83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F3AED54B9E3535E40E891CFC3BA363F4000000000183AF83F', '2025-06-04 11:49:38.280008', '2025-06-04 11:49:38.280008', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591816', '8645924713383591818', 1, 1);
INSERT INTO public.lane VALUES ('8642718640556212181', 100001, '01020000A0E61000001400000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93FDAFD1B95EA535E402A916AF6C5363F4000000040810CFA3F94BC0A8EEA535E40E29AF16CC5363F40000000808BE3F93F636EF973EA535E40B3BF1920C4363F40000000808BE3F93FFC1E9766EA535E40492FF8A1C3363F40000000C095BAF93F7FB7993AEA535E40A3C8465FC2363F40000000C095BAF93FA9708529EA535E404FD2CEF9C1363F40000000E073CBF93F84C401EAE9535E403E1B7FC3C0363F40000000608879F93F472B40D9E9535E404A58077FC0363F40000000A09250F93FC33B4784E9535E405172545CBF363F40000000A09250F93F0AB16A78E9535E402DC7383ABF363F40000000E09C27F93F460D8A0CE9535E409365CD37BE363F4000000060F948F93F15F0D508E9535E407B337430BE363F4000000060F948F93F4D9FB58CE8535E40224D1A75BD363F40000000206B3FF93F6AC2D585E8535E40BD6F516DBD363F40000000206B3FF93FD1487CD5E7535E40B7B219E7BC363F40000000C004F5F83F39F46C0FE8535E40228CF00DBD363F40000000607516F93FE6C4B4F5E7535E40B1321AF9BC363F40000000C004F5F83FD1487CD5E7535E40B7B219E7BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 11:49:40.045772', '2025-06-04 11:49:40.045772', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271583', '8645782395347271584', 1, 1);
INSERT INTO public.lane VALUES ('8642718640556212210', 100001, '01020000A0E6100000030000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F15AD58D3E7535E40E7AE7BE4BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 11:49:40.631945', '2025-06-04 11:49:40.631945', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271662', '8645782395347271663', 1, 1);
INSERT INTO public.lane VALUES ('8642718640556212168', 100001, '01020000A0E610000005000000FBC65165EA535E406DB11ACCD8363F40000000802FC5F83F4C982E99EA535E400A403990C9363F40000000002485F93FEF8F5F8EEA535E409137BECBCC363F4000000040F573F93F4C982E99EA535E400A403990C9363F40000000002485F93F69FC209DEA535E40ED3D3963C8363F40000000C019AEF93F', '2025-06-04 11:49:41.809786', '2025-06-04 11:49:41.809786', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271285', '8645782395347271291', 2, 1);
INSERT INTO public.lane VALUES ('8642718640556212161', 100001, '01020000A0E610000004000000A22B20D3EB535E4004738C15C9363F40000000801134F93F9035A9BCEB535E40968224A2CE363F4000000060E101F93F31601A9DEB535E40D3CABFC1D7363F40000000605A8DF83F18F0CF98EB535E40D82935FFD8363F40000000A06464F83F', '2025-06-04 11:49:42.400978', '2025-06-04 11:49:42.400978', 'driving', 'null', 0, 'generate', 99, '0', '8645782395347271282', '8645782395347271280', 1, 1);
INSERT INTO public.lane VALUES ('8642718640556212169', 100001, '01020000A0E610000005000000E4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F71AAB530EB535E4033FB20F1C9363F4000000000D429FA3F77AFA426EB535E40566526EBCC363F40000000A09920FA3F71AAB530EB535E4033FB20F1C9363F4000000000D429FA3F48A3CD34EB535E40408843BAC8363F4000000080BF7BFA3F', '2025-06-04 11:49:42.99975', '2025-06-04 11:49:42.99975', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271283', '8645782395347271285', 1, 1);
INSERT INTO public.lane VALUES ('8642718640556212146', 100001, '01020000A0E6100000030000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93FA5391CD7EB535E408E9DA1CCC7363F4000000000FD85F93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 11:49:43.587746', '2025-06-04 11:49:43.587746', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271613', '8645782395347271612', 1, 1);
INSERT INTO public.lane VALUES ('8642718640556212189', 100001, '01020000A0E6100000160000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F908E8212EC535E4021E04854B3363F4000000020DB16FA3F6512B61EEC535E40036CD5E8B4363F40000000E04434FA3FF592C920EC535E402C6ADC0DB5363F40000000204F0BFA3FB4CBB73EEC535E40F6378C75B6363F400000002001EAF93F66F67E45EC535E40BA6C88B2B6363F40000000C0EC3BFA3FA8D59772EC535E4007E064F0B7363F400000002001EAF93FDD14707EEC535E409C325334B8363F40000000E0F612FA3FA97CD7B9EC535E40BFA7284DB9363F40000000E014B3F93F5938E6C8EC535E409BDAD588B9363F4000000020F62DFA3F79880713ED535E40004EB07EBA363F40000000A00ADCF93F81740A22ED535E40068B90A8BA363F40000000A00ADCF93F4C92BE7BED535E4011996678BB363F40000000602961F93F3CB70387ED535E407C0AED8DBB363F40000000602961F93F1AA4B0F0ED535E40A0B4B92FBC363F40000000005230F93F6B57F0F4ED535E40A07DC634BC363F40000000005230F93F15813D68EE535E40D573E997BC363F40000000405C07F93FBCCE3A6EEE535E40CF477C9BBC363F40000000405C07F93F390C6FA1EE535E409A020EABBC363F40000000405C07F93F77E66CA1EE535E409F9916ABBC363F400000008066DEF83F390C6FA1EE535E409A020EABBC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 11:49:44.173209', '2025-06-04 11:49:44.173209', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271614', '8645782395347271615', 1, 1);
INSERT INTO public.lane VALUES ('8642718640556212201', 100001, '01020000A0E610000003000000EFCB6143EC535E404033DE0FA5363F40000000A0E94FFA3FC18E971FEC535E40057B3250B0363F4000000020DB16FA3F3E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F', '2025-06-04 11:49:44.761747', '2025-06-04 11:49:44.761747', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271639', '8645782395347271637', 2, 1);
INSERT INTO public.lane VALUES ('8642718640556212224', 100001, '01020000A0E61000001800000047DB93E8EE535E40730DB76CC2363F40000000601F2BF83F4DB70866EE535E40D2818998C2363F40000000601F2BF83F6AE30936EE535E40903F67BEC2363F40000000201554F83FBDA3DD20EE535E40D833E4D5C2363F40000000601F2BF83FD24B2CF3ED535E40AE2DFA12C3363F40000000E00A7DF83FC81A3AE5ED535E406D324028C3363F40000000201554F83F180405C7ED535E401F378761C3363F40000000201554F83F54E6119CED535E406C624EBEC3363F4000000060B997F83F1E97C49BED535E4072A80FBFC3363F4000000060B997F83F326CBD74ED535E40A2110932C4363F40000000E0A4E9F83F51CAED5CED535E40079C3D81C4363F40000000E0A4E9F83FD4C7F54FED535E400CBC7EB4C4363F4000000020AFC0F83F991E292FED535E407D582346C5363F4000000060B997F83F5D6FC629ED535E40189C4260C5363F4000000060B997F83F144DCD09ED535E40D6DA751BC6363F4000000000D81CF83F917CD901ED535E40BE65FD4FC6363F4000000000D81CF83F70208CEEEC535E403BDC20F0C6363F4000000040E2F3F73FF28E5BE5EC535E40EDB0084CC7363F400000000002E4F73FEE6C37DDEC535E4088FCB9BCC7363F400000000002E4F73F282511D5EC535E40CFE2BD51C8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F4B51D3D3EC535E40E742297DC8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F5AD1FDD4EC535E40D43B9DAAC9363F40000000C02069F73F', '2025-06-04 11:49:45.347214', '2025-06-04 11:49:45.347214', 'virtual', '["non_motor_vehicle","walker"]', 0, 'generate', 99, '0', '8645924713383591843', '8645924713383591842', 1, 1);
INSERT INTO public.lane VALUES ('8642718640556212214', 100001, '01020000A0E610000006000000E647666FF5535E405BB4DF5EC2363F40000000C066EBF73F7AE31B3FF1535E409852C20CC0363F40000000605AD4F83F58054923EF535E4063E775DDBE363F40000000002F01FA3F229B589EEF535E408CA8F322BF363F4000000000585DF93F58054923EF535E4063E775DDBE363F40000000002F01FA3F5C29BAE4EE535E40E6B320BABE363F40000000803114FA3F', '2025-06-04 11:49:45.938599', '2025-06-04 11:49:45.938599', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591799', '8645924713383591876', 1, 1);
INSERT INTO public.lane VALUES ('8642718640556212213', 100001, '01020000A0E610000007000000DFE39D5AF5535E40AD120647C4363F40000000C08F47F73F6CB106E8F1535E40087F9160C2363F40000000809B68F73F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93FB743268DEF535E402091A20DC1363F40000000C076E2F83F11928B85EF535E40A3C25209C1363F400000000081B9F83F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93F4A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F', '2025-06-04 11:49:46.526331', '2025-06-04 11:49:46.526331', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591876', '8645924713383591870', 2, 1);
INSERT INTO public.lane VALUES ('8642718640556212216', 100001, '01020000A0E610000004000000E25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83FC359A750F1535E40CEE61D19BE363F40000000608330F83FBE6DFC42F5535E407A502051C0363F4000000040500BF73F0AE9A281F5535E40E5BE5B74C0363F40000000001DD8F73F', '2025-06-04 11:49:47.130171', '2025-06-04 11:49:47.130171', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591798', '8645924713383591800', 1, 1);
INSERT INTO public.lane VALUES ('8642718640556212175', 100001, '01020000A0E61000000600000044447194EA535E40DB050E5EF7363F4000000040D7F0F73FB25858AAEA535E407361B6FAF0363F400000000069EAF83F64EEBAB4EA535E40E0629EC5ED363F400000000069EAF83F572447B6EA535E4004DEAB51ED363F40000000206D0EF93F08121BF9EA535E4019D65215DA363F40000000603131F93FE4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F', '2025-06-04 11:49:47.727344', '2025-06-04 11:49:47.727344', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558709', '8645275692285558705', 1, 1);
INSERT INTO public.lane VALUES ('8642723176041676774', 100001, '01020000A0E610000003000000B20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F4096E203EB535E4028B1EAFAA5363F40000000600BCFFA3FAEF13109EB535E40D55809B0A4363F40000000C00776FA3F', '2025-06-04 11:39:42.639576', '2025-06-04 11:39:42.639576', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271633', '8645782395347271634', 1, 1);
INSERT INTO public.lane VALUES ('8642718640556212174', 100001, '01020000A0E610000006000000F9A0B8FAE9535E40341C183EF7363F40000000C0EB9EF73F3661F811EA535E40B4BD2CD9F0363F40000000009246F83FB0C08F1EEA535E403F018B31ED363F4000000020966AF83FD03C5D36EA535E40D83D9865E6363F40000000E0C22CF83F05E13A61EA535E4090574DFBD9363F40000000C0399CF83FFBC65165EA535E406DB11ACCD8363F40000000802FC5F83F', '2025-06-04 11:49:48.316105', '2025-06-04 11:49:48.316105', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645275692285558705', '8645275692285558706', 2, 1);
INSERT INTO public.lane VALUES ('8642718640556212171', 100001, '01020000A0E61000000600000018F0CF98EB535E40D82935FFD8363F40000000A06464F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73F33AD8255EB535E40049892E2EC363F40000000807640F83F062D0352EB535E40E5FAA4FEED363F40000000E09D11F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73FE8E1FC34EB535E408783C18BF7363F400000008030F0F73F', '2025-06-04 11:49:48.904947', '2025-06-04 11:49:48.904947', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558708', '8645275692285558707', 1, 1);
INSERT INTO public.lane VALUES ('8642735957864349655', 100001, '01020000A0E6100000110000005C29BAE4EE535E40E6B320BABE363F40000000803114FA3FF48E8D1FEE535E405D7ED048BE363F4000000040273DFA3F35C12168ED535E4034801A6BBD363F4000000060D7A8FA3FC291AA67ED535E4034D1616ABD363F4000000060D7A8FA3F661FF9BDEC535E40F3F97C22BC363F4000000020CDD1FA3F6FEEC6BAEC535E403B89F41ABC363F4000000020CDD1FA3F5229FF25EC535E40DC9CFE77BA363F40000000C0260FFB3F89078522EC535E403B6E446CBA363F400000000031E6FA3F7DE7ECA4EB535E4096D0F075B8363F4000000020FD52FB3F3A1249A3EB535E40A279126EB8363F4000000020FD52FB3F2D438E40EB535E405B4E9531B6363F40000000A01101FB3FDA515D3FEB535E4073760F29B6363F40000000A01101FB3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3F915FC3FCEA535E40FD13F4C8B3363F4000000020B2BAFA3F4004C9F9EA535E40924747A4B3363F4000000060BC91FA3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3F13D44175EB535E40D5BD045DB1363F4000000060BC91FA3F', '2025-06-04 11:36:15.438777', '2025-06-04 11:36:15.438777', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271590', '8645782395347271591', 1, 1);
INSERT INTO public.lane VALUES ('8642197643843338230', 100001, '01020000A0E61000000500000098DD0A96E7535E4082E472C3BC363F40000000C004F5F83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F6065498DE4535E40BE82042ABB363F40000000E05D4BF83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F3AED54B9E3535E40E891CFC3BA363F4000000000183AF83F', '2025-06-04 16:39:27.176643', '2025-06-04 16:39:27.176643', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591816', '8645924713383591818', 1, 1);
INSERT INTO public.lane VALUES ('8642735957864349666', 100001, '01020000A0E61000001300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F307A2F3DE8535E4084AC16F4B8363F40000000E06068F93F36331E98E8535E40365884D7B8363F40000000604CBAF93F0A534ABEE8535E40D707E5BFB8363F40000000604CBAF93FC32F6C02E9535E4048665380B8363F40000000200AF4F93F4ABB313AE9535E40FB6BE939B8363F40000000E0FF1CFA3FB5BB8667E9535E40C611BFF0B7363F40000000E0FF1CFA3F1DA849ACE9535E40A83C8267B7363F4000000000EC63FA3F1AF228C5E9535E4079C75C2BB7363F4000000000EC63FA3F19105C10EA535E40F6097A51B6363F4000000040F63AFA3FEC2E2019EA535E40FCEA3533B6363F4000000040F63AFA3FE1560761EA535E4068944F0BB5363F4000000040F63AFA3F6306A962EA535E404A1C3503B5363F4000000040F63AFA3FC8010F9AEA535E40E0B878B7B3363F40000000A05DFEF93F6F4F0CA0EA535E4063A2C28AB3363F40000000204950FA3F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93F7D4166C2EA535E40EC2A4943B2363F40000000A05DFEF93F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 11:36:16.06051', '2025-06-04 11:36:16.061476', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271618', '8645782395347271619', 1, 1);
INSERT INTO public.lane VALUES ('8642735957864349648', 100001, '01020000A0E61000000300000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93F6FD844D3EA535E40E0A8A551B2363F4000000020DB16FA3F13D44175EB535E40D5BD045DB1363F4000000060BC91FA3F', '2025-06-04 11:36:16.656192', '2025-06-04 11:36:16.656192', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271581', '8645782395347271582', 1, 1);
INSERT INTO public.lane VALUES ('8642735957864349663', 100001, '01020000A0E61000001300000013D44175EB535E40D5BD045DB1363F4000000060BC91FA3F09A69A59EB535E403399368BB3363F4000000060BC91FA3FF66A9E28EB535E400E3B2667B5363F40000000A01101FB3F57A15320EB535E407F3AD4A5B5363F40000000A01101FB3FA1164BDDEA535E409CB9E03CB7363F40000000A01101FB3FC04AB2CCEA535E403D950690B7363F4000000000C307FB3F02DAD27AEA535E4095160AE5B8363F400000006068AEFA3F6D8B2D62EA535E40E31A533BB9363F400000006068AEFA3FC1916B03EA535E40FAA53451BA363F400000006068AEFA3FAC73A4E4E9535E40D6E2C09CBA363F400000006068AEFA3F7D3E537AE9535E407040E373BB363F40000000A07285FA3F6C522558E9535E40593606ACBB363F4000000060235EFA3FAE11A5E3E8535E40B290DC41BC363F40000000A02D35FA3F9C7CEAC0E8535E403AE51863BC363F400000002042E3F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F30506644E8535E40FFDFD6B2BC363F40000000E06068F93F8320AF23E8535E40BDA34ABDBC363F40000000607516F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 11:36:17.250634', '2025-06-04 11:36:17.250634', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271617', '8645782395347271616', 1, 1);
INSERT INTO public.lane VALUES ('8642735957864349693', 100001, '01020000A0E610000006000000E2EA72DDE3535E40C0E6F1BBB6363F400000004033F3F83FA711BEEDE5535E40BA3A8BD4B7363F40000000A014EDF83F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93FC5016651E7535E40FB8DCF94B8363F40000000A02255F93F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93F24ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F', '2025-06-04 11:36:17.83925', '2025-06-04 11:36:17.83925', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591814', '8645924713383591813', 2, 1);
INSERT INTO public.lane VALUES ('8642735957864349694', 100001, '01020000A0E610000005000000932E26CBE3535E408A32ACC6B8363F40000000E034EFF83FDC552EA5E5535E40C594BFB0B9363F40000000808869F93F2F533A28E6535E40CB0F27F3B9363F40000000805F0DFA3F16DF046AE7535E40BE7629A8BA363F4000000040C7EAF93FC2227AAAE7535E40D6005ECCBA363F4000000000BD13FA3F', '2025-06-04 11:36:18.432373', '2025-06-04 11:36:18.432373', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591815', '8645924713383591814', 1, 1);
INSERT INTO public.lane VALUES ('8642735957864349678', 100001, '01020000A0E61000000300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F036CDAA1EE535E40114D1596BC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 11:36:19.021988', '2025-06-04 11:36:19.021988', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271659', '8645782395347271658', 1, 1);
INSERT INTO public.lane VALUES ('8642735957864349670', 100001, '01020000A0E61000000300000013D44175EB535E40D5BD045DB1363F4000000060BC91FA3F4096E203EB535E4028B1EAFAA5363F40000000600BCFFA3F183ECCA5EB535E40701ECDDFA4363F4000000080FD9EFA3F', '2025-06-04 11:36:19.6069', '2025-06-04 11:36:19.607899', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271633', '8645782395347271634', 1, 1);
INSERT INTO public.lane VALUES ('8642735957864349674', 100001, '01020000A0E610000003000000183ECCA5EB535E40701ECDDFA4363F4000000080FD9EFA3F1691F679EB535E40F3608825B0363F4000000020B2BAFA3F13D44175EB535E40D5BD045DB1363F4000000060BC91FA3F', '2025-06-04 11:36:20.193714', '2025-06-04 11:36:20.193714', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271640', '8645782395347271639', 1, 1);
INSERT INTO public.lane VALUES ('8642735957864349673', 100001, '01020000A0E610000003000000EFCB6143EC535E404033DE0FA5363F40000000A0E94FFA3FC18E971FEC535E40057B3250B0363F4000000020DB16FA3F3E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F', '2025-06-04 11:36:20.779046', '2025-06-04 11:36:20.779046', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271639', '8645782395347271637', 2, 1);
INSERT INTO public.lane VALUES ('8642735957864349659', 100001, '01020000A0E6100000160000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F908E8212EC535E4021E04854B3363F4000000020DB16FA3F6512B61EEC535E40036CD5E8B4363F40000000E04434FA3FF592C920EC535E402C6ADC0DB5363F40000000204F0BFA3FB4CBB73EEC535E40F6378C75B6363F400000002001EAF93F66F67E45EC535E40BA6C88B2B6363F40000000C0EC3BFA3FA8D59772EC535E4007E064F0B7363F400000002001EAF93FDD14707EEC535E409C325334B8363F40000000E0F612FA3FA97CD7B9EC535E40BFA7284DB9363F40000000E014B3F93F5938E6C8EC535E409BDAD588B9363F4000000020F62DFA3F79880713ED535E40004EB07EBA363F40000000A00ADCF93F81740A22ED535E40068B90A8BA363F40000000A00ADCF93F4C92BE7BED535E4011996678BB363F40000000602961F93F3CB70387ED535E407C0AED8DBB363F40000000602961F93F1AA4B0F0ED535E40A0B4B92FBC363F40000000005230F93F6B57F0F4ED535E40A07DC634BC363F40000000005230F93F15813D68EE535E40D573E997BC363F40000000405C07F93FBCCE3A6EEE535E40CF477C9BBC363F40000000405C07F93F390C6FA1EE535E409A020EABBC363F40000000405C07F93F77E66CA1EE535E409F9916ABBC363F400000008066DEF83F390C6FA1EE535E409A020EABBC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 11:36:21.362343', '2025-06-04 11:36:21.362343', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271614', '8645782395347271615', 1, 1);
INSERT INTO public.lane VALUES ('8642735957864349615', 100001, '01020000A0E6100000030000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93FA5391CD7EB535E408E9DA1CCC7363F4000000000FD85F93F00F31CD3EB535E4081278815C9363F40000000801134F93F', '2025-06-04 11:36:21.946661', '2025-06-04 11:36:21.946661', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271613', '8645782395347271612', 1, 1);
INSERT INTO public.lane VALUES ('8642735957864349688', 100001, '01020000A0E610000004000000E25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83FC359A750F1535E40CEE61D19BE363F40000000608330F83FBE6DFC42F5535E407A502051C0363F4000000040500BF73F0AE9A281F5535E40E5BE5B74C0363F40000000001DD8F73F', '2025-06-04 11:36:22.530452', '2025-06-04 11:36:22.530452', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591798', '8645924713383591800', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646083', 100001, '01020000A0E61000000B00000019CEFD21F2535E40146D2948B5363F4000000040E17AF4BFF9CAA201F3535E4062AFF9B6B5363F4000000040E17AF4BFC61239F1F3535E40C7518698B5363F4000000040E17AF4BF70664F5DF4535E4014C1BB39B5363F4000000040E17AF4BFEAFA8CABF4535E403F5080BEB3363F4000000040E17AF4BFE7A528B8F4535E40DAA2B822B2363F4000000040E17AF4BF805030C6F4535E4066695B58AD363F4000000040E17AF4BFAB92BECCF4535E40D7D5429BAC363F4000000040E17AF4BF8759D2CBF4535E40A8141DC4AC363F4000000040E17AF4BFAB92BECCF4535E40D7D5429BAC363F4000000040E17AF4BF2CBA25D4F4535E40DEEE913FAB363F4000000040E17AF4BF', '2025-06-04 17:28:38.580355', '2025-06-04 17:28:38.580355', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '1', '8642101470935646090', '8642101470935646092', 1, 1);
INSERT INTO public.lane VALUES ('8642660435159416787', 100001, '01020000A0E6100000110000005C29BAE4EE535E40E6B320BABE363F40000000803114FA3FF48E8D1FEE535E405D7ED048BE363F4000000040273DFA3F35C12168ED535E4034801A6BBD363F4000000060D7A8FA3FC291AA67ED535E4034D1616ABD363F4000000060D7A8FA3F661FF9BDEC535E40F3F97C22BC363F4000000020CDD1FA3F6FEEC6BAEC535E403B89F41ABC363F4000000020CDD1FA3F5229FF25EC535E40DC9CFE77BA363F40000000C0260FFB3F89078522EC535E403B6E446CBA363F400000000031E6FA3F7DE7ECA4EB535E4096D0F075B8363F4000000020FD52FB3F3A1249A3EB535E40A279126EB8363F4000000020FD52FB3F2D438E40EB535E405B4E9531B6363F40000000A01101FB3FDA515D3FEB535E4073760F29B6363F40000000A01101FB3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3F915FC3FCEA535E40FD13F4C8B3363F4000000020B2BAFA3F4004C9F9EA535E40924747A4B3363F4000000060BC91FA3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3F13D44175EB535E40D5BD045DB1363F4000000060BC91FA3F', '2025-06-04 14:17:20.420342', '2025-06-04 14:17:20.420342', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271590', '8645782395347271591', 1, 1);
INSERT INTO public.lane VALUES ('8642735957864349623', 100001, '01020000A0E610000014000000A22B20D3EB535E4004738C15C9363F40000000801134F93FF99CCD40EB535E40BEA7CD93C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 11:36:23.113041', '2025-06-04 11:36:23.113041', 'virtual', 'null', 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8642735957864349686', 100001, '01020000A0E610000006000000E647666FF5535E405BB4DF5EC2363F40000000C066EBF73F7AE31B3FF1535E409852C20CC0363F40000000605AD4F83F58054923EF535E4063E775DDBE363F40000000002F01FA3F229B589EEF535E408CA8F322BF363F4000000000585DF93F58054923EF535E4063E775DDBE363F40000000002F01FA3F5C29BAE4EE535E40E6B320BABE363F40000000803114FA3F', '2025-06-04 11:36:23.700408', '2025-06-04 11:36:23.700408', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591799', '8645924713383591876', 1, 1);
INSERT INTO public.lane VALUES ('8642735957864349618', 100001, '01020000A0E6100000140000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F34611266EE535E40CD9D759AC0363F40000000805A70F93F20F45001EE535E401A1986BDC0363F40000000405099F93FF3D48DF1ED535E4044CCDBC7C0363F40000000805A70F93FB5F5488DED535E4097A8FF28C1363F40000000A0A7FAF93F8453A581ED535E409D9A2E38C1363F4000000020BCA8F93F7633A31FED535E40850D5EDAC1363F4000000040C67FF93F0DC6CF19ED535E4049C64BE6C1363F4000000040C67FF93F6E011DBDEC535E40E42023CBC2363F40000000E07B8DF93F6CA9D7BBEC535E40FCE7E0CEC2363F40000000E07B8DF93FE59B6D6EEC535E4054785BDFC3363F40000000205D08FA3FD73FE065EC535E40B9FE4603C4363F40000000205D08FA3F72F3322FEC535E409B2DB116C5363F400000004015B0F93F9C680121EC535E40E8E0B26DC5363F40000000801F87F93F287C3F00EC535E40D6A13567C6363F40000000801F87F93F592479F0EB535E406BAB6E02C7363F40000000801F87F93FD32B35E0EB535E40942780CAC7363F4000000040075DF93F150705E2EB535E40761A01C6C7363F4000000040075DF93FD32B35E0EB535E40942780CAC7363F4000000040075DF93F00F31CD3EB535E4081278815C9363F40000000801134F93F', '2025-06-04 11:36:24.289804', '2025-06-04 11:36:24.289804', 'virtual', NULL, 0, 'generate', 99, '0', '8645924713383591836', '8645924713383591853', 1, 1);
INSERT INTO public.lane VALUES ('8642735957864349696', 100001, '01020000A0E61000001800000047DB93E8EE535E40730DB76CC2363F40000000601F2BF83F4DB70866EE535E40D2818998C2363F40000000601F2BF83F6AE30936EE535E40903F67BEC2363F40000000201554F83FBDA3DD20EE535E40D833E4D5C2363F40000000601F2BF83FD24B2CF3ED535E40AE2DFA12C3363F40000000E00A7DF83FC81A3AE5ED535E406D324028C3363F40000000201554F83F180405C7ED535E401F378761C3363F40000000201554F83F54E6119CED535E406C624EBEC3363F4000000060B997F83F1E97C49BED535E4072A80FBFC3363F4000000060B997F83F326CBD74ED535E40A2110932C4363F40000000E0A4E9F83F51CAED5CED535E40079C3D81C4363F40000000E0A4E9F83FD4C7F54FED535E400CBC7EB4C4363F4000000020AFC0F83F991E292FED535E407D582346C5363F4000000060B997F83F5D6FC629ED535E40189C4260C5363F4000000060B997F83F144DCD09ED535E40D6DA751BC6363F4000000000D81CF83F917CD901ED535E40BE65FD4FC6363F4000000000D81CF83F70208CEEEC535E403BDC20F0C6363F4000000040E2F3F73FF28E5BE5EC535E40EDB0084CC7363F400000000002E4F73FEE6C37DDEC535E4088FCB9BCC7363F400000000002E4F73F282511D5EC535E40CFE2BD51C8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F4B51D3D3EC535E40E742297DC8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F5AD1FDD4EC535E40D43B9DAAC9363F40000000C02069F73F', '2025-06-04 11:36:24.875971', '2025-06-04 11:36:24.875971', 'virtual', '["non_motor_vehicle","walker"]', 0, 'generate', 99, '0', '8645924713383591843', '8645924713383591842', 1, 1);
INSERT INTO public.lane VALUES ('8642735957864349685', 100001, '01020000A0E610000007000000DFE39D5AF5535E40AD120647C4363F40000000C08F47F73F6CB106E8F1535E40087F9160C2363F40000000809B68F73F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93FB743268DEF535E402091A20DC1363F40000000C076E2F83F11928B85EF535E40A3C25209C1363F400000000081B9F83F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93F4A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F', '2025-06-04 11:36:25.460997', '2025-06-04 11:36:25.460997', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591876', '8645924713383591870', 2, 1);
INSERT INTO public.lane VALUES ('8642735957864349630', 100001, '01020000A0E61000000400000048A3CD34EB535E40408843BAC8363F4000000080BF7BFA3F9035A9BCEB535E40968224A2CE363F4000000060E101F93F31601A9DEB535E40D3CABFC1D7363F40000000605A8DF83FE4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F', '2025-06-04 11:36:26.628779', '2025-06-04 11:36:26.629777', 'driving', 'null', 0, 'generate', 99, '0', '8645782395347271282', '8645782395347271280', 1, 1);
INSERT INTO public.lane VALUES ('8642735957864349641', 100001, '01020000A0E610000006000000E4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73F33AD8255EB535E40049892E2EC363F40000000807640F83F062D0352EB535E40E5FAA4FEED363F40000000E09D11F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73FE8E1FC34EB535E408783C18BF7363F400000008030F0F73F', '2025-06-04 11:36:27.212279', '2025-06-04 11:36:27.212279', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558708', '8645275692285558707', 1, 1);
INSERT INTO public.lane VALUES ('8642735957864349690', 100001, '01020000A0E61000000500000098DD0A96E7535E4082E472C3BC363F40000000C004F5F83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F6065498DE4535E40BE82042ABB363F40000000E05D4BF83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F3AED54B9E3535E40E891CFC3BA363F4000000000183AF83F', '2025-06-04 11:36:27.793628', '2025-06-04 11:36:27.793628', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591816', '8645924713383591818', 1, 1);
INSERT INTO public.lane VALUES ('8642735957864349626', 100001, '01020000A0E610000015000000C2227AAAE7535E40D6005ECCBA363F4000000000BD13FA3F3314AF66E8535E4065ABD0E2BA363F40000000A02D35FA3FDC0073FAE8535E4017B46047BB363F4000000060235EFA3FA58A3D0FE9535E40FF2A2A5CBB363F4000000060235EFA3F59EF5BA0E9535E40CFA63C1DBC363F40000000A07285FA3F8E3B5EAEE9535E40BD70F134BC363F40000000A07285FA3F5A84D939EA535E40752A8D56BD363F40000000A07285FA3FA7F8553FEA535E4087EC5B64BD363F400000006068AEFA3FF63ED9BDEA535E401B8FF1DFBE363F400000006036C1FA3F20CBB0C1EA535E40A46EB3EDBE363F400000006036C1FA3FA0275426EB535E40F7BEB19AC0363F4000000060B307FB3FF7F68B32EB535E40622757D9C0363F40000000A0BDDEFA3FFF78F176EB535E400267E283C2363F4000000040C3F7FA3FFA430D88EB535E40D8BC1C09C3363F4000000080CDCEFA3F743F9DAEEB535E40305CBD8DC4363F40000000C0D7A5FA3F95304FBEEB535E407DD77C69C5363F4000000040EC53FA3F710142CDEB535E404114BAB5C6363F40000000C00002FA3F951065D5EB535E405E4619C0C7363F4000000000FD85F93F6A97E3D3EB535E40C90E7DB9C7363F4000000000FD85F93F951065D5EB535E405E4619C0C7363F4000000000FD85F93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 11:36:28.376444', '2025-06-04 11:36:28.376444', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271661', '8645782395347271660', 1, 1);
INSERT INTO public.lane VALUES ('8642735957864349644', 100001, '01020000A0E610000006000000F9A0B8FAE9535E40341C183EF7363F40000000C0EB9EF73F3661F811EA535E40B4BD2CD9F0363F40000000009246F83FB0C08F1EEA535E403F018B31ED363F4000000020966AF83FD03C5D36EA535E40D83D9865E6363F40000000E0C22CF83F05E13A61EA535E4090574DFBD9363F40000000C0399CF83FFBC65165EA535E406DB11ACCD8363F40000000802FC5F83F', '2025-06-04 11:36:28.959901', '2025-06-04 11:36:28.959901', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645275692285558705', '8645275692285558706', 2, 1);
INSERT INTO public.lane VALUES ('8642735957864349637', 100001, '01020000A0E610000005000000FBC65165EA535E406DB11ACCD8363F40000000802FC5F83F4C982E99EA535E400A403990C9363F40000000002485F93FEF8F5F8EEA535E409137BECBCC363F4000000040F573F93F4C982E99EA535E400A403990C9363F40000000002485F93F69FC209DEA535E40ED3D3963C8363F40000000C019AEF93F', '2025-06-04 11:36:29.53945', '2025-06-04 11:36:29.53945', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271285', '8645782395347271291', 2, 1);
INSERT INTO public.lane VALUES ('8642735957864349651', 100001, '01020000A0E61000001400000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93FDAFD1B95EA535E402A916AF6C5363F4000000040810CFA3F94BC0A8EEA535E40E29AF16CC5363F40000000808BE3F93F636EF973EA535E40B3BF1920C4363F40000000808BE3F93FFC1E9766EA535E40492FF8A1C3363F40000000C095BAF93F7FB7993AEA535E40A3C8465FC2363F40000000C095BAF93FA9708529EA535E404FD2CEF9C1363F40000000E073CBF93F84C401EAE9535E403E1B7FC3C0363F40000000608879F93F472B40D9E9535E404A58077FC0363F40000000A09250F93FC33B4784E9535E405172545CBF363F40000000A09250F93F0AB16A78E9535E402DC7383ABF363F40000000E09C27F93F460D8A0CE9535E409365CD37BE363F4000000060F948F93F15F0D508E9535E407B337430BE363F4000000060F948F93F4D9FB58CE8535E40224D1A75BD363F40000000206B3FF93F6AC2D585E8535E40BD6F516DBD363F40000000206B3FF93FD1487CD5E7535E40B7B219E7BC363F40000000C004F5F83F39F46C0FE8535E40228CF00DBD363F40000000607516F93FE6C4B4F5E7535E40B1321AF9BC363F40000000C004F5F83FD1487CD5E7535E40B7B219E7BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 11:36:30.125534', '2025-06-04 11:36:30.125534', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271583', '8645782395347271584', 1, 1);
INSERT INTO public.lane VALUES ('8642735957864349645', 100001, '01020000A0E61000000600000044447194EA535E40DB050E5EF7363F4000000040D7F0F73FB25858AAEA535E407361B6FAF0363F400000000069EAF83F64EEBAB4EA535E40E0629EC5ED363F400000000069EAF83F572447B6EA535E4004DEAB51ED363F40000000206D0EF93F08121BF9EA535E4019D65215DA363F40000000603131F93FE4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F', '2025-06-04 11:36:30.720612', '2025-06-04 11:36:30.720612', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558709', '8645275692285558705', 1, 1);
INSERT INTO public.lane VALUES ('8642735957864349682', 100001, '01020000A0E6100000030000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F15AD58D3E7535E40E7AE7BE4BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 11:36:31.308514', '2025-06-04 11:36:31.308514', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271662', '8645782395347271663', 1, 1);
INSERT INTO public.lane VALUES ('8642723176041676754', 100001, '01020000A0E61000000300000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93F6FD844D3EA535E40E0A8A551B2363F4000000020DB16FA3FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 11:39:43.268745', '2025-06-04 11:39:43.268745', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271581', '8645782395347271582', 1, 1);
INSERT INTO public.lane VALUES ('8642723176041676772', 100001, '01020000A0E61000001300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F307A2F3DE8535E4084AC16F4B8363F40000000E06068F93F36331E98E8535E40365884D7B8363F40000000604CBAF93F0A534ABEE8535E40D707E5BFB8363F40000000604CBAF93FC32F6C02E9535E4048665380B8363F40000000200AF4F93F4ABB313AE9535E40FB6BE939B8363F40000000E0FF1CFA3FB5BB8667E9535E40C611BFF0B7363F40000000E0FF1CFA3F1DA849ACE9535E40A83C8267B7363F4000000000EC63FA3F1AF228C5E9535E4079C75C2BB7363F4000000000EC63FA3F19105C10EA535E40F6097A51B6363F4000000040F63AFA3FEC2E2019EA535E40FCEA3533B6363F4000000040F63AFA3FE1560761EA535E4068944F0BB5363F4000000040F63AFA3F6306A962EA535E404A1C3503B5363F4000000040F63AFA3FC8010F9AEA535E40E0B878B7B3363F40000000A05DFEF93F6F4F0CA0EA535E4063A2C28AB3363F40000000204950FA3F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93F7D4166C2EA535E40EC2A4943B2363F40000000A05DFEF93F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 11:39:43.886732', '2025-06-04 11:39:43.886732', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271618', '8645782395347271619', 1, 1);
INSERT INTO public.lane VALUES ('8642723176041676737', 100001, '01020000A0E610000004000000A22B20D3EB535E4004738C15C9363F40000000801134F93F9035A9BCEB535E40968224A2CE363F4000000060E101F93F31601A9DEB535E40D3CABFC1D7363F40000000605A8DF83F18F0CF98EB535E40D82935FFD8363F40000000A06464F83F', '2025-06-04 11:39:59.036549', '2025-06-04 11:39:59.036549', 'driving', 'null', 0, 'generate', 99, '0', '8645782395347271282', '8645782395347271280', 1, 1);
INSERT INTO public.lane VALUES ('8642660435159416810', 100001, '01020000A0E61000000300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F036CDAA1EE535E40114D1596BC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 14:17:23.959597', '2025-06-04 14:17:23.960594', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271659', '8645782395347271658', 1, 1);
INSERT INTO public.lane VALUES ('8642660435159416744', 100001, '01020000A0E6100000030000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93FA5391CD7EB535E408E9DA1CCC7363F4000000000FD85F93F48A3CD34EB535E40408843BAC8363F4000000080BF7BFA3F', '2025-06-04 14:17:21.611235', '2025-06-04 14:17:21.611235', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271613', '8645782395347271612', 1, 1);
INSERT INTO public.lane VALUES ('8642660435159416757', 100001, '01020000A0E610000015000000C2227AAAE7535E40D6005ECCBA363F4000000000BD13FA3F3314AF66E8535E4065ABD0E2BA363F40000000A02D35FA3FDC0073FAE8535E4017B46047BB363F4000000060235EFA3FA58A3D0FE9535E40FF2A2A5CBB363F4000000060235EFA3F59EF5BA0E9535E40CFA63C1DBC363F40000000A07285FA3F8E3B5EAEE9535E40BD70F134BC363F40000000A07285FA3F5A84D939EA535E40752A8D56BD363F40000000A07285FA3FA7F8553FEA535E4087EC5B64BD363F400000006068AEFA3FF63ED9BDEA535E401B8FF1DFBE363F400000006036C1FA3F20CBB0C1EA535E40A46EB3EDBE363F400000006036C1FA3FA0275426EB535E40F7BEB19AC0363F4000000060B307FB3FF7F68B32EB535E40622757D9C0363F40000000A0BDDEFA3FFF78F176EB535E400267E283C2363F4000000040C3F7FA3FFA430D88EB535E40D8BC1C09C3363F4000000080CDCEFA3F743F9DAEEB535E40305CBD8DC4363F40000000C0D7A5FA3F95304FBEEB535E407DD77C69C5363F4000000040EC53FA3F710142CDEB535E404114BAB5C6363F40000000C00002FA3F951065D5EB535E405E4619C0C7363F4000000000FD85F93F6A97E3D3EB535E40C90E7DB9C7363F4000000000FD85F93F951065D5EB535E405E4619C0C7363F4000000000FD85F93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 14:17:24.551238', '2025-06-04 14:17:24.551238', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271661', '8645782395347271660', 1, 1);
INSERT INTO public.lane VALUES ('8642660435159416753', 100001, '01020000A0E61000001400000048A3CD34EB535E40408843BAC8363F4000000080BF7BFA3FF99CCD40EB535E40BEA7CD93C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 14:17:25.139115', '2025-06-04 14:17:25.139115', 'virtual', 'null', 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8642660435159416749', 100001, '01020000A0E6100000140000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F34611266EE535E40CD9D759AC0363F40000000805A70F93F20F45001EE535E401A1986BDC0363F40000000405099F93FF3D48DF1ED535E4044CCDBC7C0363F40000000805A70F93FB5F5488DED535E4097A8FF28C1363F40000000A0A7FAF93F8453A581ED535E409D9A2E38C1363F4000000020BCA8F93F7633A31FED535E40850D5EDAC1363F4000000040C67FF93F0DC6CF19ED535E4049C64BE6C1363F4000000040C67FF93F6E011DBDEC535E40E42023CBC2363F40000000E07B8DF93F6CA9D7BBEC535E40FCE7E0CEC2363F40000000E07B8DF93FE59B6D6EEC535E4054785BDFC3363F40000000205D08FA3FD73FE065EC535E40B9FE4603C4363F40000000205D08FA3F72F3322FEC535E409B2DB116C5363F400000004015B0F93F9C680121EC535E40E8E0B26DC5363F40000000801F87F93F287C3F00EC535E40D6A13567C6363F40000000801F87F93F592479F0EB535E406BAB6E02C7363F40000000801F87F93FD32B35E0EB535E40942780CAC7363F4000000040075DF93F150705E2EB535E40761A01C6C7363F4000000040075DF93FD32B35E0EB535E40942780CAC7363F4000000040075DF93F48A3CD34EB535E40408843BAC8363F4000000080BF7BFA3F', '2025-06-04 14:17:28.047952', '2025-06-04 14:17:28.047952', 'virtual', NULL, 0, 'generate', 99, '0', '8645924713383591836', '8645924713383591853', 1, 1);
INSERT INTO public.lane VALUES ('8642660435159416739', 100001, '01020000A0E61000000300000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93F6FD844D3EA535E40E0A8A551B2363F4000000020DB16FA3F13D44175EB535E40D5BD045DB1363F4000000060BC91FA3F', '2025-06-04 14:17:30.960862', '2025-06-04 14:17:30.960862', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271581', '8645782395347271582', 1, 1);
INSERT INTO public.lane VALUES ('8642660435159416795', 100001, '01020000A0E61000001300000013D44175EB535E40D5BD045DB1363F4000000060BC91FA3F09A69A59EB535E403399368BB3363F4000000060BC91FA3FF66A9E28EB535E400E3B2667B5363F40000000A01101FB3F57A15320EB535E407F3AD4A5B5363F40000000A01101FB3FA1164BDDEA535E409CB9E03CB7363F40000000A01101FB3FC04AB2CCEA535E403D950690B7363F4000000000C307FB3F02DAD27AEA535E4095160AE5B8363F400000006068AEFA3F6D8B2D62EA535E40E31A533BB9363F400000006068AEFA3FC1916B03EA535E40FAA53451BA363F400000006068AEFA3FAC73A4E4E9535E40D6E2C09CBA363F400000006068AEFA3F7D3E537AE9535E407040E373BB363F40000000A07285FA3F6C522558E9535E40593606ACBB363F4000000060235EFA3FAE11A5E3E8535E40B290DC41BC363F40000000A02D35FA3F9C7CEAC0E8535E403AE51863BC363F400000002042E3F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F30506644E8535E40FFDFD6B2BC363F40000000E06068F93F8320AF23E8535E40BDA34ABDBC363F40000000607516F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 14:17:21.022862', '2025-06-04 14:17:21.022862', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271617', '8645782395347271616', 1, 1);
INSERT INTO public.lane VALUES ('8642660435159416825', 100001, '01020000A0E610000006000000E2EA72DDE3535E40C0E6F1BBB6363F400000004033F3F83FA711BEEDE5535E40BA3A8BD4B7363F40000000A014EDF83F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93FC5016651E7535E40FB8DCF94B8363F40000000A02255F93F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93F24ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F', '2025-06-04 14:17:22.204584', '2025-06-04 14:17:22.204584', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591814', '8645924713383591813', 2, 1);
INSERT INTO public.lane VALUES ('8642660435159416791', 100001, '01020000A0E6100000160000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F908E8212EC535E4021E04854B3363F4000000020DB16FA3F6512B61EEC535E40036CD5E8B4363F40000000E04434FA3FF592C920EC535E402C6ADC0DB5363F40000000204F0BFA3FB4CBB73EEC535E40F6378C75B6363F400000002001EAF93F66F67E45EC535E40BA6C88B2B6363F40000000C0EC3BFA3FA8D59772EC535E4007E064F0B7363F400000002001EAF93FDD14707EEC535E409C325334B8363F40000000E0F612FA3FA97CD7B9EC535E40BFA7284DB9363F40000000E014B3F93F5938E6C8EC535E409BDAD588B9363F4000000020F62DFA3F79880713ED535E40004EB07EBA363F40000000A00ADCF93F81740A22ED535E40068B90A8BA363F40000000A00ADCF93F4C92BE7BED535E4011996678BB363F40000000602961F93F3CB70387ED535E407C0AED8DBB363F40000000602961F93F1AA4B0F0ED535E40A0B4B92FBC363F40000000005230F93F6B57F0F4ED535E40A07DC634BC363F40000000005230F93F15813D68EE535E40D573E997BC363F40000000405C07F93FBCCE3A6EEE535E40CF477C9BBC363F40000000405C07F93F390C6FA1EE535E409A020EABBC363F40000000405C07F93F77E66CA1EE535E409F9916ABBC363F400000008066DEF83F390C6FA1EE535E409A020EABBC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 14:17:22.796915', '2025-06-04 14:17:22.796915', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271614', '8645782395347271615', 1, 1);
INSERT INTO public.lane VALUES ('8642660435159416826', 100001, '01020000A0E610000005000000932E26CBE3535E408A32ACC6B8363F40000000E034EFF83FDC552EA5E5535E40C594BFB0B9363F40000000808869F93F2F533A28E6535E40CB0F27F3B9363F40000000805F0DFA3F16DF046AE7535E40BE7629A8BA363F4000000040C7EAF93FC2227AAAE7535E40D6005ECCBA363F4000000000BD13FA3F', '2025-06-04 14:17:23.380347', '2025-06-04 14:17:23.380347', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591815', '8645924713383591814', 1, 1);
INSERT INTO public.lane VALUES ('8642660435159416820', 100001, '01020000A0E610000004000000E25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83FC359A750F1535E40CEE61D19BE363F40000000608330F83FBE6DFC42F5535E407A502051C0363F4000000040500BF73F0AE9A281F5535E40E5BE5B74C0363F40000000001DD8F73F', '2025-06-04 14:17:25.723082', '2025-06-04 14:17:25.723082', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591798', '8645924713383591800', 1, 1);
INSERT INTO public.lane VALUES ('8642660435159416782', 100001, '01020000A0E61000001400000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93FDAFD1B95EA535E402A916AF6C5363F4000000040810CFA3F94BC0A8EEA535E40E29AF16CC5363F40000000808BE3F93F636EF973EA535E40B3BF1920C4363F40000000808BE3F93FFC1E9766EA535E40492FF8A1C3363F40000000C095BAF93F7FB7993AEA535E40A3C8465FC2363F40000000C095BAF93FA9708529EA535E404FD2CEF9C1363F40000000E073CBF93F84C401EAE9535E403E1B7FC3C0363F40000000608879F93F472B40D9E9535E404A58077FC0363F40000000A09250F93FC33B4784E9535E405172545CBF363F40000000A09250F93F0AB16A78E9535E402DC7383ABF363F40000000E09C27F93F460D8A0CE9535E409365CD37BE363F4000000060F948F93F15F0D508E9535E407B337430BE363F4000000060F948F93F4D9FB58CE8535E40224D1A75BD363F40000000206B3FF93F6AC2D585E8535E40BD6F516DBD363F40000000206B3FF93FD1487CD5E7535E40B7B219E7BC363F40000000C004F5F83F39F46C0FE8535E40228CF00DBD363F40000000607516F93FE6C4B4F5E7535E40B1321AF9BC363F40000000C004F5F83FD1487CD5E7535E40B7B219E7BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 14:17:26.304205', '2025-06-04 14:17:26.304205', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271583', '8645782395347271584', 1, 1);
INSERT INTO public.lane VALUES ('8642660435159416814', 100001, '01020000A0E6100000030000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F15AD58D3E7535E40E7AE7BE4BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 14:17:26.885954', '2025-06-04 14:17:26.885954', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271662', '8645782395347271663', 1, 1);
INSERT INTO public.lane VALUES ('8642660435159416818', 100001, '01020000A0E610000006000000E647666FF5535E405BB4DF5EC2363F40000000C066EBF73F7AE31B3FF1535E409852C20CC0363F40000000605AD4F83F58054923EF535E4063E775DDBE363F40000000002F01FA3F229B589EEF535E408CA8F322BF363F4000000000585DF93F58054923EF535E4063E775DDBE363F40000000002F01FA3F5C29BAE4EE535E40E6B320BABE363F40000000803114FA3F', '2025-06-04 14:17:27.45983', '2025-06-04 14:17:27.45983', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591799', '8645924713383591876', 1, 1);
INSERT INTO public.lane VALUES ('8642660435159416817', 100001, '01020000A0E610000007000000DFE39D5AF5535E40AD120647C4363F40000000C08F47F73F6CB106E8F1535E40087F9160C2363F40000000809B68F73F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93FB743268DEF535E402091A20DC1363F40000000C076E2F83F11928B85EF535E40A3C25209C1363F400000000081B9F83F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93F4A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F', '2025-06-04 14:17:28.643831', '2025-06-04 14:17:28.643831', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591876', '8645924713383591870', 2, 1);
INSERT INTO public.lane VALUES ('8642660435159416802', 100001, '01020000A0E610000003000000B20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F4096E203EB535E4028B1EAFAA5363F40000000600BCFFA3F183ECCA5EB535E40701ECDDFA4363F4000000080FD9EFA3F', '2025-06-04 14:17:29.219163', '2025-06-04 14:17:29.219163', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271633', '8645782395347271634', 1, 1);
INSERT INTO public.lane VALUES ('8642660435159416806', 100001, '01020000A0E610000003000000183ECCA5EB535E40701ECDDFA4363F4000000080FD9EFA3F1691F679EB535E40F3608825B0363F4000000020B2BAFA3F13D44175EB535E40D5BD045DB1363F4000000060BC91FA3F', '2025-06-04 14:17:29.800614', '2025-06-04 14:17:29.800614', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271640', '8645782395347271639', 1, 1);
INSERT INTO public.lane VALUES ('8642660435159416805', 100001, '01020000A0E610000003000000EFCB6143EC535E404033DE0FA5363F40000000A0E94FFA3FC18E971FEC535E40057B3250B0363F4000000020DB16FA3F3E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F', '2025-06-04 14:17:30.377052', '2025-06-04 14:17:30.377052', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271639', '8645782395347271637', 2, 1);
INSERT INTO public.lane VALUES ('8642660435159416822', 100001, '01020000A0E61000000500000098DD0A96E7535E4082E472C3BC363F40000000C004F5F83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F6065498DE4535E40BE82042ABB363F40000000E05D4BF83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F3AED54B9E3535E40E891CFC3BA363F4000000000183AF83F', '2025-06-04 14:17:31.547939', '2025-06-04 14:17:31.547939', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591816', '8645924713383591818', 1, 1);
INSERT INTO public.lane VALUES ('8642660435159416828', 100001, '01020000A0E61000001800000047DB93E8EE535E40730DB76CC2363F40000000601F2BF83F4DB70866EE535E40D2818998C2363F40000000601F2BF83F6AE30936EE535E40903F67BEC2363F40000000201554F83FBDA3DD20EE535E40D833E4D5C2363F40000000601F2BF83FD24B2CF3ED535E40AE2DFA12C3363F40000000E00A7DF83FC81A3AE5ED535E406D324028C3363F40000000201554F83F180405C7ED535E401F378761C3363F40000000201554F83F54E6119CED535E406C624EBEC3363F4000000060B997F83F1E97C49BED535E4072A80FBFC3363F4000000060B997F83F326CBD74ED535E40A2110932C4363F40000000E0A4E9F83F51CAED5CED535E40079C3D81C4363F40000000E0A4E9F83FD4C7F54FED535E400CBC7EB4C4363F4000000020AFC0F83F991E292FED535E407D582346C5363F4000000060B997F83F5D6FC629ED535E40189C4260C5363F4000000060B997F83F144DCD09ED535E40D6DA751BC6363F4000000000D81CF83F917CD901ED535E40BE65FD4FC6363F4000000000D81CF83F70208CEEEC535E403BDC20F0C6363F4000000040E2F3F73FF28E5BE5EC535E40EDB0084CC7363F400000000002E4F73FEE6C37DDEC535E4088FCB9BCC7363F400000000002E4F73F282511D5EC535E40CFE2BD51C8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F4B51D3D3EC535E40E742297DC8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F5AD1FDD4EC535E40D43B9DAAC9363F40000000C02069F73F', '2025-06-04 14:17:32.12862', '2025-06-04 14:17:32.12862', 'virtual', '["non_motor_vehicle","walker"]', 0, 'generate', 99, '0', '8645924713383591843', '8645924713383591842', 1, 1);
INSERT INTO public.lane VALUES ('8642660435159416768', 100001, '01020000A0E610000005000000FBC65165EA535E406DB11ACCD8363F40000000802FC5F83F4C982E99EA535E400A403990C9363F40000000002485F93FEF8F5F8EEA535E409137BECBCC363F4000000040F573F93F4C982E99EA535E400A403990C9363F40000000002485F93F69FC209DEA535E40ED3D3963C8363F40000000C019AEF93F', '2025-06-04 14:17:32.702651', '2025-06-04 14:17:32.702651', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271285', '8645782395347271291', 2, 1);
INSERT INTO public.lane VALUES ('8642660435159416769', 100001, '01020000A0E610000005000000E4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F71AAB530EB535E4033FB20F1C9363F4000000000D429FA3F77AFA426EB535E40566526EBCC363F40000000A09920FA3F71AAB530EB535E4033FB20F1C9363F4000000000D429FA3F48A3CD34EB535E40408843BAC8363F4000000080BF7BFA3F', '2025-06-04 14:17:33.282725', '2025-06-04 14:17:33.282725', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271283', '8645782395347271285', 1, 1);
INSERT INTO public.lane VALUES ('8642660435159416761', 100001, '01020000A0E610000004000000A22B20D3EB535E4004738C15C9363F40000000801134F93F9035A9BCEB535E40968224A2CE363F4000000060E101F93F31601A9DEB535E40D3CABFC1D7363F40000000605A8DF83FE4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F', '2025-06-04 14:17:33.871385', '2025-06-04 14:17:33.871385', 'driving', 'null', 0, 'generate', 99, '0', '8645782395347271282', '8645782395347271280', 1, 1);
INSERT INTO public.lane VALUES ('8642660435159416774', 100001, '01020000A0E610000006000000F9A0B8FAE9535E40341C183EF7363F40000000C0EB9EF73F3661F811EA535E40B4BD2CD9F0363F40000000009246F83FB0C08F1EEA535E403F018B31ED363F4000000020966AF83FD03C5D36EA535E40D83D9865E6363F40000000E0C22CF83F05E13A61EA535E4090574DFBD9363F40000000C0399CF83FFBC65165EA535E406DB11ACCD8363F40000000802FC5F83F', '2025-06-04 14:17:34.452116', '2025-06-04 14:17:34.452116', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645275692285558705', '8645275692285558706', 2, 1);
INSERT INTO public.lane VALUES ('8642660435159416771', 100001, '01020000A0E61000000600000018F0CF98EB535E40D82935FFD8363F40000000A06464F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73F33AD8255EB535E40049892E2EC363F40000000807640F83F062D0352EB535E40E5FAA4FEED363F40000000E09D11F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73FE8E1FC34EB535E408783C18BF7363F400000008030F0F73F', '2025-06-04 14:17:35.023393', '2025-06-04 14:17:35.023393', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558708', '8645275692285558707', 1, 1);
INSERT INTO public.lane VALUES ('8642660435159416775', 100001, '01020000A0E61000000600000044447194EA535E40DB050E5EF7363F4000000040D7F0F73FB25858AAEA535E407361B6FAF0363F400000000069EAF83F64EEBAB4EA535E40E0629EC5ED363F400000000069EAF83F572447B6EA535E4004DEAB51ED363F40000000206D0EF93F08121BF9EA535E4019D65215DA363F40000000603131F93FE4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F', '2025-06-04 14:17:35.59635', '2025-06-04 14:17:35.59635', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558709', '8645275692285558705', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646196', 100001, '01020000A0E610000004000000E25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83FC359A750F1535E40CEE61D19BE363F40000000608330F83FBE6DFC42F5535E407A502051C0363F4000000040500BF73F0AE9A281F5535E40E5BE5B74C0363F40000000001DD8F73F', '2025-06-04 16:39:51.052915', '2025-06-04 16:39:51.052915', 'driving', '["all_motor_vehicle"]', 0, 'generate', 0, '0', '8645924713383591798', '8645924713383591800', 1, 1);
INSERT INTO public.lane VALUES ('8642391707645640628', 100001, '01020000A0E6100000140000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F34611266EE535E40CD9D759AC0363F40000000805A70F93F20F45001EE535E401A1986BDC0363F40000000405099F93FF3D48DF1ED535E4044CCDBC7C0363F40000000805A70F93FB5F5488DED535E4097A8FF28C1363F40000000A0A7FAF93F8453A581ED535E409D9A2E38C1363F4000000020BCA8F93F7633A31FED535E40850D5EDAC1363F4000000040C67FF93F0DC6CF19ED535E4049C64BE6C1363F4000000040C67FF93F6E011DBDEC535E40E42023CBC2363F40000000E07B8DF93F6CA9D7BBEC535E40FCE7E0CEC2363F40000000E07B8DF93FE59B6D6EEC535E4054785BDFC3363F40000000205D08FA3FD73FE065EC535E40B9FE4603C4363F40000000205D08FA3F72F3322FEC535E409B2DB116C5363F400000004015B0F93F9C680121EC535E40E8E0B26DC5363F40000000801F87F93F287C3F00EC535E40D6A13567C6363F40000000801F87F93F592479F0EB535E406BAB6E02C7363F40000000801F87F93FD32B35E0EB535E40942780CAC7363F4000000040075DF93F150705E2EB535E40761A01C6C7363F4000000040075DF93FD32B35E0EB535E40942780CAC7363F4000000040075DF93F48A3CD34EB535E40408843BAC8363F4000000080BF7BFA3F', '2025-06-04 14:25:47.210335', '2025-06-04 14:25:47.211331', 'virtual', NULL, 0, 'generate', 99, '0', '8645924713383591836', '8645924713383591853', 1, 1);
INSERT INTO public.lane VALUES ('8642391707645640636', 100001, '01020000A0E610000015000000C2227AAAE7535E40D6005ECCBA363F4000000000BD13FA3F3314AF66E8535E4065ABD0E2BA363F40000000A02D35FA3FDC0073FAE8535E4017B46047BB363F4000000060235EFA3FA58A3D0FE9535E40FF2A2A5CBB363F4000000060235EFA3F59EF5BA0E9535E40CFA63C1DBC363F40000000A07285FA3F8E3B5EAEE9535E40BD70F134BC363F40000000A07285FA3F5A84D939EA535E40752A8D56BD363F40000000A07285FA3FA7F8553FEA535E4087EC5B64BD363F400000006068AEFA3FF63ED9BDEA535E401B8FF1DFBE363F400000006036C1FA3F20CBB0C1EA535E40A46EB3EDBE363F400000006036C1FA3FA0275426EB535E40F7BEB19AC0363F4000000060B307FB3FF7F68B32EB535E40622757D9C0363F40000000A0BDDEFA3FFF78F176EB535E400267E283C2363F4000000040C3F7FA3FFA430D88EB535E40D8BC1C09C3363F4000000080CDCEFA3F743F9DAEEB535E40305CBD8DC4363F40000000C0D7A5FA3F95304FBEEB535E407DD77C69C5363F4000000040EC53FA3F710142CDEB535E404114BAB5C6363F40000000C00002FA3F951065D5EB535E405E4619C0C7363F4000000000FD85F93F6A97E3D3EB535E40C90E7DB9C7363F4000000000FD85F93F951065D5EB535E405E4619C0C7363F4000000000FD85F93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 14:39:47.722943', '2025-06-04 14:39:47.722943', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271661', '8645782395347271660', 1, 1);
INSERT INTO public.lane VALUES ('8642391707645640632', 100001, '01020000A0E61000001400000048A3CD34EB535E40408843BAC8363F4000000080BF7BFA3FF99CCD40EB535E40BEA7CD93C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 14:39:48.349012', '2025-06-04 14:39:48.349012', 'virtual', 'null', 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8642391707645640623', 100001, '01020000A0E6100000030000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93FA5391CD7EB535E408E9DA1CCC7363F4000000000FD85F93F48A3CD34EB535E40408843BAC8363F4000000080BF7BFA3F', '2025-06-04 14:39:48.978134', '2025-06-04 14:39:48.978134', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271613', '8645782395347271612', 1, 1);
INSERT INTO public.lane VALUES ('8642391707645640618', 100001, '01020000A0E610000004000000A22B20D3EB535E4004738C15C9363F40000000801134F93F9035A9BCEB535E40968224A2CE363F4000000060E101F93F31601A9DEB535E40D3CABFC1D7363F40000000605A8DF83FE4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F', '2025-06-04 14:31:32.798032', '2025-06-04 14:31:32.798032', 'driving', 'null', 0, 'generate', 99, '0', '8645782395347271282', '8645782395347271280', 1, 1);
INSERT INTO public.lane VALUES ('8642391707645640613', 100001, '01020000A0E610000004000000A22B20D3EB535E4004738C15C9363F40000000801134F93F9035A9BCEB535E40968224A2CE363F4000000060E101F93F31601A9DEB535E40D3CABFC1D7363F40000000605A8DF83FE4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F', '2025-06-04 14:38:07.498751', '2025-06-04 14:38:07.498751', 'driving', 'null', 0, 'generate', 99, '0', '8645782395347271282', '8645782395347271280', 1, 1);
INSERT INTO public.lane VALUES ('8642391707645640650', 100001, '01020000A0E61000000600000018F0CF98EB535E40D82935FFD8363F40000000A06464F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73F33AD8255EB535E40049892E2EC363F40000000807640F83F062D0352EB535E40E5FAA4FEED363F40000000E09D11F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73FE8E1FC34EB535E408783C18BF7363F400000008030F0F73F', '2025-06-04 14:39:42.030642', '2025-06-04 14:39:42.030642', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558708', '8645275692285558707', 1, 1);
INSERT INTO public.lane VALUES ('8642391707645640653', 100001, '01020000A0E610000006000000F9A0B8FAE9535E40341C183EF7363F40000000C0EB9EF73F3661F811EA535E40B4BD2CD9F0363F40000000009246F83FB0C08F1EEA535E403F018B31ED363F4000000020966AF83FD03C5D36EA535E40D83D9865E6363F40000000E0C22CF83F05E13A61EA535E4090574DFBD9363F40000000C0399CF83FFBC65165EA535E406DB11ACCD8363F40000000802FC5F83F', '2025-06-04 14:39:42.672105', '2025-06-04 14:39:42.672105', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645275692285558705', '8645275692285558706', 2, 1);
INSERT INTO public.lane VALUES ('8642391707645640654', 100001, '01020000A0E61000000600000044447194EA535E40DB050E5EF7363F4000000040D7F0F73FB25858AAEA535E407361B6FAF0363F400000000069EAF83F64EEBAB4EA535E40E0629EC5ED363F400000000069EAF83F572447B6EA535E4004DEAB51ED363F40000000206D0EF93F08121BF9EA535E4019D65215DA363F40000000603131F93FE4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F', '2025-06-04 14:39:43.301159', '2025-06-04 14:39:43.301159', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558709', '8645275692285558705', 1, 1);
INSERT INTO public.lane VALUES ('8642391707645640648', 100001, '01020000A0E610000005000000E4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F71AAB530EB535E4033FB20F1C9363F4000000000D429FA3F77AFA426EB535E40566526EBCC363F40000000A09920FA3F71AAB530EB535E4033FB20F1C9363F4000000000D429FA3F48A3CD34EB535E40408843BAC8363F4000000080BF7BFA3F', '2025-06-04 14:39:43.930845', '2025-06-04 14:39:43.930845', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271283', '8645782395347271285', 1, 1);
INSERT INTO public.lane VALUES ('8642391707645640647', 100001, '01020000A0E610000005000000FBC65165EA535E406DB11ACCD8363F40000000802FC5F83F4C982E99EA535E400A403990C9363F40000000002485F93FEF8F5F8EEA535E409137BECBCC363F4000000040F573F93F4C982E99EA535E400A403990C9363F40000000002485F93F69FC209DEA535E40ED3D3963C8363F40000000C019AEF93F', '2025-06-04 14:39:44.555232', '2025-06-04 14:39:44.555232', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271285', '8645782395347271291', 2, 1);
INSERT INTO public.lane VALUES ('8642348861051895808', 100001, '01020000A0E610000004000000A22B20D3EB535E4004738C15C9363F40000000801134F93F9035A9BCEB535E40968224A2CE363F4000000060E101F93F31601A9DEB535E40D3CABFC1D7363F40000000605A8DF83F18F0CF98EB535E40D82935FFD8363F40000000A06464F83F', '2025-06-04 14:39:45.189162', '2025-06-04 14:39:45.189162', 'driving', 'null', 0, 'generate', 99, '0', '8645782395347271282', '8645782395347271280', 1, 1);
INSERT INTO public.lane VALUES ('8642391707645640704', 100001, '01020000A0E61000001800000047DB93E8EE535E40730DB76CC2363F40000000601F2BF83F4DB70866EE535E40D2818998C2363F40000000601F2BF83F6AE30936EE535E40903F67BEC2363F40000000201554F83FBDA3DD20EE535E40D833E4D5C2363F40000000601F2BF83FD24B2CF3ED535E40AE2DFA12C3363F40000000E00A7DF83FC81A3AE5ED535E406D324028C3363F40000000201554F83F180405C7ED535E401F378761C3363F40000000201554F83F54E6119CED535E406C624EBEC3363F4000000060B997F83F1E97C49BED535E4072A80FBFC3363F4000000060B997F83F326CBD74ED535E40A2110932C4363F40000000E0A4E9F83F51CAED5CED535E40079C3D81C4363F40000000E0A4E9F83FD4C7F54FED535E400CBC7EB4C4363F4000000020AFC0F83F991E292FED535E407D582346C5363F4000000060B997F83F5D6FC629ED535E40189C4260C5363F4000000060B997F83F144DCD09ED535E40D6DA751BC6363F4000000000D81CF83F917CD901ED535E40BE65FD4FC6363F4000000000D81CF83F70208CEEEC535E403BDC20F0C6363F4000000040E2F3F73FF28E5BE5EC535E40EDB0084CC7363F400000000002E4F73FEE6C37DDEC535E4088FCB9BCC7363F400000000002E4F73F282511D5EC535E40CFE2BD51C8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F4B51D3D3EC535E40E742297DC8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F5AD1FDD4EC535E40D43B9DAAC9363F40000000C02069F73F', '2025-06-04 14:39:45.822871', '2025-06-04 14:39:45.822871', 'virtual', '["non_motor_vehicle","walker"]', 0, 'generate', 99, '0', '8645924713383591843', '8645924713383591842', 1, 1);
INSERT INTO public.lane VALUES ('8642391707645640660', 100001, '01020000A0E61000001400000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93FDAFD1B95EA535E402A916AF6C5363F4000000040810CFA3F94BC0A8EEA535E40E29AF16CC5363F40000000808BE3F93F636EF973EA535E40B3BF1920C4363F40000000808BE3F93FFC1E9766EA535E40492FF8A1C3363F40000000C095BAF93F7FB7993AEA535E40A3C8465FC2363F40000000C095BAF93FA9708529EA535E404FD2CEF9C1363F40000000E073CBF93F84C401EAE9535E403E1B7FC3C0363F40000000608879F93F472B40D9E9535E404A58077FC0363F40000000A09250F93FC33B4784E9535E405172545CBF363F40000000A09250F93F0AB16A78E9535E402DC7383ABF363F40000000E09C27F93F460D8A0CE9535E409365CD37BE363F4000000060F948F93F15F0D508E9535E407B337430BE363F4000000060F948F93F4D9FB58CE8535E40224D1A75BD363F40000000206B3FF93F6AC2D585E8535E40BD6F516DBD363F40000000206B3FF93FD1487CD5E7535E40B7B219E7BC363F40000000C004F5F83F39F46C0FE8535E40228CF00DBD363F40000000607516F93FE6C4B4F5E7535E40B1321AF9BC363F40000000C004F5F83FD1487CD5E7535E40B7B219E7BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 14:39:46.466351', '2025-06-04 14:39:46.466351', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271583', '8645782395347271584', 1, 1);
INSERT INTO public.lane VALUES ('8642391707645640657', 100001, '01020000A0E61000000300000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93F6FD844D3EA535E40E0A8A551B2363F4000000020DB16FA3FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 14:39:47.094932', '2025-06-04 14:39:47.094932', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271581', '8645782395347271582', 1, 1);
INSERT INTO public.lane VALUES ('8642391707645640698', 100001, '01020000A0E61000000500000098DD0A96E7535E4082E472C3BC363F40000000C004F5F83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F6065498DE4535E40BE82042ABB363F40000000E05D4BF83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F3AED54B9E3535E40E891CFC3BA363F4000000000183AF83F', '2025-06-04 14:39:49.599492', '2025-06-04 14:39:49.599492', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591816', '8645924713383591818', 1, 1);
INSERT INTO public.lane VALUES ('8642391707645640696', 100001, '01020000A0E610000004000000E25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83FC359A750F1535E40CEE61D19BE363F40000000608330F83FBE6DFC42F5535E407A502051C0363F4000000040500BF73F0AE9A281F5535E40E5BE5B74C0363F40000000001DD8F73F', '2025-06-04 14:39:50.226623', '2025-06-04 14:39:50.226623', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591798', '8645924713383591800', 1, 1);
INSERT INTO public.lane VALUES ('8642391707645640694', 100001, '01020000A0E610000006000000E647666FF5535E405BB4DF5EC2363F40000000C066EBF73F7AE31B3FF1535E409852C20CC0363F40000000605AD4F83F58054923EF535E4063E775DDBE363F40000000002F01FA3F229B589EEF535E408CA8F322BF363F4000000000585DF93F58054923EF535E4063E775DDBE363F40000000002F01FA3F5C29BAE4EE535E40E6B320BABE363F40000000803114FA3F', '2025-06-04 14:39:50.848634', '2025-06-04 14:39:50.848634', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591799', '8645924713383591876', 1, 1);
INSERT INTO public.lane VALUES ('8642391707645640693', 100001, '01020000A0E610000007000000DFE39D5AF5535E40AD120647C4363F40000000C08F47F73F6CB106E8F1535E40087F9160C2363F40000000809B68F73F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93FB743268DEF535E402091A20DC1363F40000000C076E2F83F11928B85EF535E40A3C25209C1363F400000000081B9F83F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93F4A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F', '2025-06-04 14:39:51.470122', '2025-06-04 14:39:51.470122', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591876', '8645924713383591870', 2, 1);
INSERT INTO public.lane VALUES ('8642391707645640690', 100001, '01020000A0E6100000030000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F15AD58D3E7535E40E7AE7BE4BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 14:39:52.098655', '2025-06-04 14:39:52.098655', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271662', '8645782395347271663', 1, 1);
INSERT INTO public.lane VALUES ('8642391707645640686', 100001, '01020000A0E61000000300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F036CDAA1EE535E40114D1596BC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 14:39:52.727708', '2025-06-04 14:39:52.727708', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271659', '8645782395347271658', 1, 1);
INSERT INTO public.lane VALUES ('8642391707645640672', 100001, '01020000A0E61000001300000013D44175EB535E40D5BD045DB1363F4000000060BC91FA3F09A69A59EB535E403399368BB3363F4000000060BC91FA3FF66A9E28EB535E400E3B2667B5363F40000000A01101FB3F57A15320EB535E407F3AD4A5B5363F40000000A01101FB3FA1164BDDEA535E409CB9E03CB7363F40000000A01101FB3FC04AB2CCEA535E403D950690B7363F4000000000C307FB3F02DAD27AEA535E4095160AE5B8363F400000006068AEFA3F6D8B2D62EA535E40E31A533BB9363F400000006068AEFA3FC1916B03EA535E40FAA53451BA363F400000006068AEFA3FAC73A4E4E9535E40D6E2C09CBA363F400000006068AEFA3F7D3E537AE9535E407040E373BB363F40000000A07285FA3F6C522558E9535E40593606ACBB363F4000000060235EFA3FAE11A5E3E8535E40B290DC41BC363F40000000A02D35FA3F9C7CEAC0E8535E403AE51863BC363F400000002042E3F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F30506644E8535E40FFDFD6B2BC363F40000000E06068F93F8320AF23E8535E40BDA34ABDBC363F40000000607516F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 14:39:53.348818', '2025-06-04 14:39:53.348818', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271617', '8645782395347271616', 1, 1);
INSERT INTO public.lane VALUES ('8642391707645640668', 100001, '01020000A0E6100000160000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F908E8212EC535E4021E04854B3363F4000000020DB16FA3F6512B61EEC535E40036CD5E8B4363F40000000E04434FA3FF592C920EC535E402C6ADC0DB5363F40000000204F0BFA3FB4CBB73EEC535E40F6378C75B6363F400000002001EAF93F66F67E45EC535E40BA6C88B2B6363F40000000C0EC3BFA3FA8D59772EC535E4007E064F0B7363F400000002001EAF93FDD14707EEC535E409C325334B8363F40000000E0F612FA3FA97CD7B9EC535E40BFA7284DB9363F40000000E014B3F93F5938E6C8EC535E409BDAD588B9363F4000000020F62DFA3F79880713ED535E40004EB07EBA363F40000000A00ADCF93F81740A22ED535E40068B90A8BA363F40000000A00ADCF93F4C92BE7BED535E4011996678BB363F40000000602961F93F3CB70387ED535E407C0AED8DBB363F40000000602961F93F1AA4B0F0ED535E40A0B4B92FBC363F40000000005230F93F6B57F0F4ED535E40A07DC634BC363F40000000005230F93F15813D68EE535E40D573E997BC363F40000000405C07F93FBCCE3A6EEE535E40CF477C9BBC363F40000000405C07F93F390C6FA1EE535E409A020EABBC363F40000000405C07F93F77E66CA1EE535E409F9916ABBC363F400000008066DEF83F390C6FA1EE535E409A020EABBC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 14:39:53.9827', '2025-06-04 14:39:53.9827', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271614', '8645782395347271615', 1, 1);
INSERT INTO public.lane VALUES ('8642348861051895781', 100001, '01020000A0E610000003000000EFCB6143EC535E404033DE0FA5363F40000000A0E94FFA3FC18E971FEC535E40057B3250B0363F4000000020DB16FA3F3E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F', '2025-06-04 15:54:47.742394', '2025-06-04 15:54:47.742394', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271639', '8645782395347271637', 2, 1);
INSERT INTO public.lane VALUES ('8642348861051895778', 100001, '01020000A0E610000003000000B20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F4096E203EB535E4028B1EAFAA5363F40000000600BCFFA3FAEF13109EB535E40D55809B0A4363F40000000C00776FA3F', '2025-06-04 15:54:48.341789', '2025-06-04 15:54:48.341789', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271633', '8645782395347271634', 1, 1);
INSERT INTO public.lane VALUES ('8642391707645640664', 100001, '01020000A0E6100000110000005C29BAE4EE535E40E6B320BABE363F40000000803114FA3FF48E8D1FEE535E405D7ED048BE363F4000000040273DFA3F35C12168ED535E4034801A6BBD363F4000000060D7A8FA3FC291AA67ED535E4034D1616ABD363F4000000060D7A8FA3F661FF9BDEC535E40F3F97C22BC363F4000000020CDD1FA3F6FEEC6BAEC535E403B89F41ABC363F4000000020CDD1FA3F5229FF25EC535E40DC9CFE77BA363F40000000C0260FFB3F89078522EC535E403B6E446CBA363F400000000031E6FA3F7DE7ECA4EB535E4096D0F075B8363F4000000020FD52FB3F3A1249A3EB535E40A279126EB8363F4000000020FD52FB3F2D438E40EB535E405B4E9531B6363F40000000A01101FB3FDA515D3FEB535E4073760F29B6363F40000000A01101FB3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3F915FC3FCEA535E40FD13F4C8B3363F4000000020B2BAFA3F4004C9F9EA535E40924747A4B3363F4000000060BC91FA3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 14:39:54.607729', '2025-06-04 14:39:54.607729', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271590', '8645782395347271591', 1, 1);
INSERT INTO public.lane VALUES ('8642391707645640702', 100001, '01020000A0E610000005000000932E26CBE3535E408A32ACC6B8363F40000000E034EFF83FDC552EA5E5535E40C594BFB0B9363F40000000808869F93F2F533A28E6535E40CB0F27F3B9363F40000000805F0DFA3F16DF046AE7535E40BE7629A8BA363F4000000040C7EAF93FC2227AAAE7535E40D6005ECCBA363F4000000000BD13FA3F', '2025-06-04 14:39:55.238042', '2025-06-04 14:39:55.238042', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591815', '8645924713383591814', 1, 1);
INSERT INTO public.lane VALUES ('8642391707645640701', 100001, '01020000A0E610000006000000E2EA72DDE3535E40C0E6F1BBB6363F400000004033F3F83FA711BEEDE5535E40BA3A8BD4B7363F40000000A014EDF83F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93FC5016651E7535E40FB8DCF94B8363F40000000A02255F93F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93F24ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F', '2025-06-04 14:39:55.858414', '2025-06-04 14:39:55.858414', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591814', '8645924713383591813', 2, 1);
INSERT INTO public.lane VALUES ('8642391707645640682', 100001, '01020000A0E610000003000000183ECCA5EB535E40701ECDDFA4363F4000000080FD9EFA3F1691F679EB535E40F3608825B0363F4000000020B2BAFA3F13D44175EB535E40D5BD045DB1363F4000000060BC91FA3F', '2025-06-04 14:39:56.478872', '2025-06-04 14:39:56.478872', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271640', '8645782395347271639', 1, 1);
INSERT INTO public.lane VALUES ('8642391707645640681', 100001, '01020000A0E610000003000000EFCB6143EC535E404033DE0FA5363F40000000A0E94FFA3FC18E971FEC535E40057B3250B0363F4000000020DB16FA3F3E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F', '2025-06-04 14:39:57.098915', '2025-06-04 14:39:57.098915', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271639', '8645782395347271637', 2, 1);
INSERT INTO public.lane VALUES ('8642391707645640678', 100001, '01020000A0E610000003000000B20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F4096E203EB535E4028B1EAFAA5363F40000000600BCFFA3FAEF13109EB535E40D55809B0A4363F40000000C00776FA3F', '2025-06-04 14:39:57.719825', '2025-06-04 14:39:57.719825', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271633', '8645782395347271634', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646194', 100001, '01020000A0E610000006000000E647666FF5535E405BB4DF5EC2363F40000000C066EBF73F7AE31B3FF1535E409852C20CC0363F40000000605AD4F83F58054923EF535E4063E775DDBE363F40000000002F01FA3F229B589EEF535E408CA8F322BF363F4000000000585DF93F58054923EF535E4063E775DDBE363F40000000002F01FA3F5C29BAE4EE535E40E6B320BABE363F40000000803114FA3F', '2025-06-04 16:39:51.938875', '2025-06-04 16:39:51.938875', 'driving', 'all_motor_vehicle', 0, 'generate', 0, '0', '8645924713383591799', '8645924713383591876', 1, 1);
INSERT INTO public.lane VALUES ('8642391707645640676', 100001, '01020000A0E61000001300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F307A2F3DE8535E4084AC16F4B8363F40000000E06068F93F36331E98E8535E40365884D7B8363F40000000604CBAF93F0A534ABEE8535E40D707E5BFB8363F40000000604CBAF93FC32F6C02E9535E4048665380B8363F40000000200AF4F93F4ABB313AE9535E40FB6BE939B8363F40000000E0FF1CFA3FB5BB8667E9535E40C611BFF0B7363F40000000E0FF1CFA3F1DA849ACE9535E40A83C8267B7363F4000000000EC63FA3F1AF228C5E9535E4079C75C2BB7363F4000000000EC63FA3F19105C10EA535E40F6097A51B6363F4000000040F63AFA3FEC2E2019EA535E40FCEA3533B6363F4000000040F63AFA3FE1560761EA535E4068944F0BB5363F4000000040F63AFA3F6306A962EA535E404A1C3503B5363F4000000040F63AFA3FC8010F9AEA535E40E0B878B7B3363F40000000A05DFEF93F6F4F0CA0EA535E4063A2C28AB3363F40000000204950FA3F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93F7D4166C2EA535E40EC2A4943B2363F40000000A05DFEF93F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 14:39:58.337683', '2025-06-04 14:39:58.337683', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271618', '8645782395347271619', 1, 1);
INSERT INTO public.lane VALUES ('8642348861051895801', 100001, '01020000A0E610000006000000E2EA72DDE3535E40C0E6F1BBB6363F400000004033F3F83FA711BEEDE5535E40BA3A8BD4B7363F40000000A014EDF83F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93FC5016651E7535E40FB8DCF94B8363F40000000A02255F93F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93F24ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F', '2025-06-04 15:54:34.501153', '2025-06-04 15:54:34.501153', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591814', '8645924713383591813', 2, 1);
INSERT INTO public.lane VALUES ('8642348861051895733', 100001, '01020000A0E61000001400000048A3CD34EB535E40408843BAC8363F4000000080BF7BFA3FF99CCD40EB535E40BEA7CD93C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 14:45:23.417509', '2025-06-04 14:45:23.417509', 'virtual', 'null', 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8642348861051895764', 100001, '01020000A0E6100000110000005C29BAE4EE535E40E6B320BABE363F40000000803114FA3FF48E8D1FEE535E405D7ED048BE363F4000000040273DFA3F35C12168ED535E4034801A6BBD363F4000000060D7A8FA3FC291AA67ED535E4034D1616ABD363F4000000060D7A8FA3F661FF9BDEC535E40F3F97C22BC363F4000000020CDD1FA3F6FEEC6BAEC535E403B89F41ABC363F4000000020CDD1FA3F5229FF25EC535E40DC9CFE77BA363F40000000C0260FFB3F89078522EC535E403B6E446CBA363F400000000031E6FA3F7DE7ECA4EB535E4096D0F075B8363F4000000020FD52FB3F3A1249A3EB535E40A279126EB8363F4000000020FD52FB3F2D438E40EB535E405B4E9531B6363F40000000A01101FB3FDA515D3FEB535E4073760F29B6363F40000000A01101FB3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3F915FC3FCEA535E40FD13F4C8B3363F4000000020B2BAFA3F4004C9F9EA535E40924747A4B3363F4000000060BC91FA3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 15:54:35.112084', '2025-06-04 15:54:35.112084', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271590', '8645782395347271591', 1, 1);
INSERT INTO public.lane VALUES ('8642348861051895757', 100001, '01020000A0E61000000300000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93F6FD844D3EA535E40E0A8A551B2363F4000000020DB16FA3FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 15:54:42.342284', '2025-06-04 15:54:42.342284', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271581', '8645782395347271582', 1, 1);
INSERT INTO public.lane VALUES ('8642348861051895722', 100001, '01020000A0E61000001400000048A3CD34EB535E40408843BAC8363F4000000080BF7BFA3FF99CCD40EB535E40BEA7CD93C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 14:54:16.926381', '2025-06-04 14:54:16.926381', 'virtual', 'null', 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8642315944422539264', 100001, '01020000A0E61000001400000048A3CD34EB535E40408843BAC8363F4000000080BF7BFA3FF99CCD40EB535E40BEA7CD93C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 14:59:00.407876', '2025-06-04 14:59:00.407876', 'virtual', 'null', 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8642305877019197440', 100001, '01020000A0E61000001400000048A3CD34EB535E40408843BAC8363F4000000080BF7BFA3FF99CCD40EB535E40BEA7CD93C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 15:03:09.741394', '2025-06-04 15:03:09.741394', 'virtual', 'null', 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8642296977846960128', 100001, '01020000A0E61000001400000048A3CD34EB535E40408843BAC8363F4000000080BF7BFA3FF99CCD40EB535E40BEA7CD93C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 15:15:35.144988', '2025-06-04 15:15:35.144988', 'virtual', 'null', 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8642272238835335168', 100001, '01020000A0E61000001400000048A3CD34EB535E40408843BAC8363F4000000080BF7BFA3FF99CCD40EB535E40BEA7CD93C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F5C29BAE4EE535E40E6B320BABE363F40000000803114FA3F', '2025-06-04 15:19:44.241773', '2025-06-04 15:19:44.241773', 'virtual', 'null', 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8642272238835335163', 100001, '01020000A0E61000001400000048A3CD34EB535E40408843BAC8363F4000000080BF7BFA3FF99CCD40EB535E40BEA7CD93C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F5C29BAE4EE535E40E6B320BABE363F40000000803114FA3F', '2025-06-04 15:21:40.486678', '2025-06-04 15:21:40.486678', 'virtual', 'null', 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8642272238835335158', 100001, '01020000A0E61000001400000048A3CD34EB535E40408843BAC8363F4000000080BF7BFA3FF99CCD40EB535E40BEA7CD93C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F5C29BAE4EE535E40E6B320BABE363F40000000803114FA3F', '2025-06-04 15:30:18.909784', '2025-06-04 15:30:18.909784', 'virtual', 'null', 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8642272238835335153', 100001, '01020000A0E61000001400000048A3CD34EB535E40408843BAC8363F4000000080BF7BFA3FF99CCD40EB535E40BEA7CD93C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F5C29BAE4EE535E40E6B320BABE363F40000000803114FA3F', '2025-06-04 15:46:50.32825', '2025-06-04 15:46:50.329246', 'virtual', 'null', 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8642272238835335149', 100001, '01020000A0E61000001400000048A3CD34EB535E40408843BAC8363F4000000080BF7BFA3FF99CCD40EB535E40BEA7CD93C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F5C29BAE4EE535E40E6B320BABE363F40000000803114FA3F', '2025-06-04 15:51:12.2259', '2025-06-04 15:51:12.226897', 'virtual', 'null', 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8642348861051895776', 100001, '01020000A0E61000001300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F307A2F3DE8535E4084AC16F4B8363F40000000E06068F93F36331E98E8535E40365884D7B8363F40000000604CBAF93F0A534ABEE8535E40D707E5BFB8363F40000000604CBAF93FC32F6C02E9535E4048665380B8363F40000000200AF4F93F4ABB313AE9535E40FB6BE939B8363F40000000E0FF1CFA3FB5BB8667E9535E40C611BFF0B7363F40000000E0FF1CFA3F1DA849ACE9535E40A83C8267B7363F4000000000EC63FA3F1AF228C5E9535E4079C75C2BB7363F4000000000EC63FA3F19105C10EA535E40F6097A51B6363F4000000040F63AFA3FEC2E2019EA535E40FCEA3533B6363F4000000040F63AFA3FE1560761EA535E4068944F0BB5363F4000000040F63AFA3F6306A962EA535E404A1C3503B5363F4000000040F63AFA3FC8010F9AEA535E40E0B878B7B3363F40000000A05DFEF93F6F4F0CA0EA535E4063A2C28AB3363F40000000204950FA3F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93F7D4166C2EA535E40EC2A4943B2363F40000000A05DFEF93F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 15:54:33.897388', '2025-06-04 15:54:33.897388', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271618', '8645782395347271619', 1, 1);
INSERT INTO public.lane VALUES ('8642348861051895772', 100001, '01020000A0E61000001300000013D44175EB535E40D5BD045DB1363F4000000060BC91FA3F09A69A59EB535E403399368BB3363F4000000060BC91FA3FF66A9E28EB535E400E3B2667B5363F40000000A01101FB3F57A15320EB535E407F3AD4A5B5363F40000000A01101FB3FA1164BDDEA535E409CB9E03CB7363F40000000A01101FB3FC04AB2CCEA535E403D950690B7363F4000000000C307FB3F02DAD27AEA535E4095160AE5B8363F400000006068AEFA3F6D8B2D62EA535E40E31A533BB9363F400000006068AEFA3FC1916B03EA535E40FAA53451BA363F400000006068AEFA3FAC73A4E4E9535E40D6E2C09CBA363F400000006068AEFA3F7D3E537AE9535E407040E373BB363F40000000A07285FA3F6C522558E9535E40593606ACBB363F4000000060235EFA3FAE11A5E3E8535E40B290DC41BC363F40000000A02D35FA3F9C7CEAC0E8535E403AE51863BC363F400000002042E3F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F30506644E8535E40FFDFD6B2BC363F40000000E06068F93F8320AF23E8535E40BDA34ABDBC363F40000000607516F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 15:54:35.721576', '2025-06-04 15:54:35.721576', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271617', '8645782395347271616', 1, 1);
INSERT INTO public.lane VALUES ('8642348861051895768', 100001, '01020000A0E6100000160000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F908E8212EC535E4021E04854B3363F4000000020DB16FA3F6512B61EEC535E40036CD5E8B4363F40000000E04434FA3FF592C920EC535E402C6ADC0DB5363F40000000204F0BFA3FB4CBB73EEC535E40F6378C75B6363F400000002001EAF93F66F67E45EC535E40BA6C88B2B6363F40000000C0EC3BFA3FA8D59772EC535E4007E064F0B7363F400000002001EAF93FDD14707EEC535E409C325334B8363F40000000E0F612FA3FA97CD7B9EC535E40BFA7284DB9363F40000000E014B3F93F5938E6C8EC535E409BDAD588B9363F4000000020F62DFA3F79880713ED535E40004EB07EBA363F40000000A00ADCF93F81740A22ED535E40068B90A8BA363F40000000A00ADCF93F4C92BE7BED535E4011996678BB363F40000000602961F93F3CB70387ED535E407C0AED8DBB363F40000000602961F93F1AA4B0F0ED535E40A0B4B92FBC363F40000000005230F93F6B57F0F4ED535E40A07DC634BC363F40000000005230F93F15813D68EE535E40D573E997BC363F40000000405C07F93FBCCE3A6EEE535E40CF477C9BBC363F40000000405C07F93F390C6FA1EE535E409A020EABBC363F40000000405C07F93F77E66CA1EE535E409F9916ABBC363F400000008066DEF83F390C6FA1EE535E409A020EABBC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 15:54:36.328163', '2025-06-04 15:54:36.328163', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271614', '8645782395347271615', 1, 1);
INSERT INTO public.lane VALUES ('8642348861051895802', 100001, '01020000A0E610000005000000932E26CBE3535E408A32ACC6B8363F40000000E034EFF83FDC552EA5E5535E40C594BFB0B9363F40000000808869F93F2F533A28E6535E40CB0F27F3B9363F40000000805F0DFA3F16DF046AE7535E40BE7629A8BA363F4000000040C7EAF93FC2227AAAE7535E40D6005ECCBA363F4000000000BD13FA3F', '2025-06-04 15:54:36.934144', '2025-06-04 15:54:36.934144', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591815', '8645924713383591814', 1, 1);
INSERT INTO public.lane VALUES ('8642348861051895786', 100001, '01020000A0E61000000300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F036CDAA1EE535E40114D1596BC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 15:54:37.535327', '2025-06-04 15:54:37.535327', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271659', '8645782395347271658', 1, 1);
INSERT INTO public.lane VALUES ('8642348861051895798', 100001, '01020000A0E61000000500000098DD0A96E7535E4082E472C3BC363F40000000C004F5F83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F6065498DE4535E40BE82042ABB363F40000000E05D4BF83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F3AED54B9E3535E40E891CFC3BA363F4000000000183AF83F', '2025-06-04 15:54:38.135237', '2025-06-04 15:54:38.135237', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591816', '8645924713383591818', 1, 1);
INSERT INTO public.lane VALUES ('8642348861051895796', 100001, '01020000A0E610000004000000E25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83FC359A750F1535E40CEE61D19BE363F40000000608330F83FBE6DFC42F5535E407A502051C0363F4000000040500BF73F0AE9A281F5535E40E5BE5B74C0363F40000000001DD8F73F', '2025-06-04 15:54:38.73723', '2025-06-04 15:54:38.73723', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591798', '8645924713383591800', 1, 1);
INSERT INTO public.lane VALUES ('8642348861051895790', 100001, '01020000A0E6100000030000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F15AD58D3E7535E40E7AE7BE4BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 15:54:39.338994', '2025-06-04 15:54:39.338994', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271662', '8645782395347271663', 1, 1);
INSERT INTO public.lane VALUES ('8642348861051895794', 100001, '01020000A0E610000006000000E647666FF5535E405BB4DF5EC2363F40000000C066EBF73F7AE31B3FF1535E409852C20CC0363F40000000605AD4F83F58054923EF535E4063E775DDBE363F40000000002F01FA3F229B589EEF535E408CA8F322BF363F4000000000585DF93F58054923EF535E4063E775DDBE363F40000000002F01FA3F5C29BAE4EE535E40E6B320BABE363F40000000803114FA3F', '2025-06-04 15:54:39.939891', '2025-06-04 15:54:39.939891', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591799', '8645924713383591876', 1, 1);
INSERT INTO public.lane VALUES ('8642348861051895793', 100001, '01020000A0E610000007000000DFE39D5AF5535E40AD120647C4363F40000000C08F47F73F6CB106E8F1535E40087F9160C2363F40000000809B68F73F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93FB743268DEF535E402091A20DC1363F40000000C076E2F83F11928B85EF535E40A3C25209C1363F400000000081B9F83F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93F4A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F', '2025-06-04 15:54:40.538286', '2025-06-04 15:54:40.538286', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591876', '8645924713383591870', 2, 1);
INSERT INTO public.lane VALUES ('8642348861051895804', 100001, '01020000A0E61000001800000047DB93E8EE535E40730DB76CC2363F40000000601F2BF83F4DB70866EE535E40D2818998C2363F40000000601F2BF83F6AE30936EE535E40903F67BEC2363F40000000201554F83FBDA3DD20EE535E40D833E4D5C2363F40000000601F2BF83FD24B2CF3ED535E40AE2DFA12C3363F40000000E00A7DF83FC81A3AE5ED535E406D324028C3363F40000000201554F83F180405C7ED535E401F378761C3363F40000000201554F83F54E6119CED535E406C624EBEC3363F4000000060B997F83F1E97C49BED535E4072A80FBFC3363F4000000060B997F83F326CBD74ED535E40A2110932C4363F40000000E0A4E9F83F51CAED5CED535E40079C3D81C4363F40000000E0A4E9F83FD4C7F54FED535E400CBC7EB4C4363F4000000020AFC0F83F991E292FED535E407D582346C5363F4000000060B997F83F5D6FC629ED535E40189C4260C5363F4000000060B997F83F144DCD09ED535E40D6DA751BC6363F4000000000D81CF83F917CD901ED535E40BE65FD4FC6363F4000000000D81CF83F70208CEEEC535E403BDC20F0C6363F4000000040E2F3F73FF28E5BE5EC535E40EDB0084CC7363F400000000002E4F73FEE6C37DDEC535E4088FCB9BCC7363F400000000002E4F73F282511D5EC535E40CFE2BD51C8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F4B51D3D3EC535E40E742297DC8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F5AD1FDD4EC535E40D43B9DAAC9363F40000000C02069F73F', '2025-06-04 15:54:41.140069', '2025-06-04 15:54:41.140069', 'virtual', '["non_motor_vehicle","walker"]', 0, 'generate', 99, '0', '8645924713383591843', '8645924713383591842', 1, 1);
INSERT INTO public.lane VALUES ('8642348861051895760', 100001, '01020000A0E61000001400000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93FDAFD1B95EA535E402A916AF6C5363F4000000040810CFA3F94BC0A8EEA535E40E29AF16CC5363F40000000808BE3F93F636EF973EA535E40B3BF1920C4363F40000000808BE3F93FFC1E9766EA535E40492FF8A1C3363F40000000C095BAF93F7FB7993AEA535E40A3C8465FC2363F40000000C095BAF93FA9708529EA535E404FD2CEF9C1363F40000000E073CBF93F84C401EAE9535E403E1B7FC3C0363F40000000608879F93F472B40D9E9535E404A58077FC0363F40000000A09250F93FC33B4784E9535E405172545CBF363F40000000A09250F93F0AB16A78E9535E402DC7383ABF363F40000000E09C27F93F460D8A0CE9535E409365CD37BE363F4000000060F948F93F15F0D508E9535E407B337430BE363F4000000060F948F93F4D9FB58CE8535E40224D1A75BD363F40000000206B3FF93F6AC2D585E8535E40BD6F516DBD363F40000000206B3FF93FD1487CD5E7535E40B7B219E7BC363F40000000C004F5F83F39F46C0FE8535E40228CF00DBD363F40000000607516F93FE6C4B4F5E7535E40B1321AF9BC363F40000000C004F5F83FD1487CD5E7535E40B7B219E7BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 15:54:41.74378', '2025-06-04 15:54:41.74378', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271583', '8645782395347271584', 1, 1);
INSERT INTO public.lane VALUES ('8642348861051895737', 100001, '01020000A0E610000015000000C2227AAAE7535E40D6005ECCBA363F4000000000BD13FA3F3314AF66E8535E4065ABD0E2BA363F40000000A02D35FA3FDC0073FAE8535E4017B46047BB363F4000000060235EFA3FA58A3D0FE9535E40FF2A2A5CBB363F4000000060235EFA3F59EF5BA0E9535E40CFA63C1DBC363F40000000A07285FA3F8E3B5EAEE9535E40BD70F134BC363F40000000A07285FA3F5A84D939EA535E40752A8D56BD363F40000000A07285FA3FA7F8553FEA535E4087EC5B64BD363F400000006068AEFA3FF63ED9BDEA535E401B8FF1DFBE363F400000006036C1FA3F20CBB0C1EA535E40A46EB3EDBE363F400000006036C1FA3FA0275426EB535E40F7BEB19AC0363F4000000060B307FB3FF7F68B32EB535E40622757D9C0363F40000000A0BDDEFA3FFF78F176EB535E400267E283C2363F4000000040C3F7FA3FFA430D88EB535E40D8BC1C09C3363F4000000080CDCEFA3F743F9DAEEB535E40305CBD8DC4363F40000000C0D7A5FA3F95304FBEEB535E407DD77C69C5363F4000000040EC53FA3F710142CDEB535E404114BAB5C6363F40000000C00002FA3F951065D5EB535E405E4619C0C7363F4000000000FD85F93F6A97E3D3EB535E40C90E7DB9C7363F4000000000FD85F93F951065D5EB535E405E4619C0C7363F4000000000FD85F93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 15:54:42.939459', '2025-06-04 15:54:42.939459', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271661', '8645782395347271660', 1, 1);
INSERT INTO public.lane VALUES ('8642348861051895730', 100001, '01020000A0E6100000140000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F34611266EE535E40CD9D759AC0363F40000000805A70F93F20F45001EE535E401A1986BDC0363F40000000405099F93FF3D48DF1ED535E4044CCDBC7C0363F40000000805A70F93FB5F5488DED535E4097A8FF28C1363F40000000A0A7FAF93F8453A581ED535E409D9A2E38C1363F4000000020BCA8F93F7633A31FED535E40850D5EDAC1363F4000000040C67FF93F0DC6CF19ED535E4049C64BE6C1363F4000000040C67FF93F6E011DBDEC535E40E42023CBC2363F40000000E07B8DF93F6CA9D7BBEC535E40FCE7E0CEC2363F40000000E07B8DF93FE59B6D6EEC535E4054785BDFC3363F40000000205D08FA3FD73FE065EC535E40B9FE4603C4363F40000000205D08FA3F72F3322FEC535E409B2DB116C5363F400000004015B0F93F9C680121EC535E40E8E0B26DC5363F40000000801F87F93F287C3F00EC535E40D6A13567C6363F40000000801F87F93F592479F0EB535E406BAB6E02C7363F40000000801F87F93FD32B35E0EB535E40942780CAC7363F4000000040075DF93F150705E2EB535E40761A01C6C7363F4000000040075DF93FD32B35E0EB535E40942780CAC7363F4000000040075DF93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 15:54:43.541545', '2025-06-04 15:54:43.541545', 'virtual', NULL, 0, 'generate', 99, '0', '8645924713383591836', '8645924713383591853', 1, 1);
INSERT INTO public.lane VALUES ('8642348861051895726', 100001, '01020000A0E6100000030000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93FA5391CD7EB535E408E9DA1CCC7363F4000000000FD85F93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 15:54:44.139806', '2025-06-04 15:54:44.139806', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271613', '8645782395347271612', 1, 1);
INSERT INTO public.lane VALUES ('8642197643843338240', 100001, '01020000A0E61000001400000048A3CD34EB535E40408843BAC8363F4000000080BF7BFA3FF99CCD40EB535E40BEA7CD93C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 15:54:44.737529', '2025-06-04 15:54:44.737529', 'virtual', 'null', 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8642348861051895748', 100001, '01020000A0E610000005000000E4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F71AAB530EB535E4033FB20F1C9363F4000000000D429FA3F77AFA426EB535E40566526EBCC363F40000000A09920FA3F71AAB530EB535E4033FB20F1C9363F4000000000D429FA3F48A3CD34EB535E40408843BAC8363F4000000080BF7BFA3F', '2025-06-04 15:54:45.340105', '2025-06-04 15:54:45.340105', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271283', '8645782395347271285', 1, 1);
INSERT INTO public.lane VALUES ('8642348861051895747', 100001, '01020000A0E610000005000000FBC65165EA535E406DB11ACCD8363F40000000802FC5F83F4C982E99EA535E400A403990C9363F40000000002485F93FEF8F5F8EEA535E409137BECBCC363F4000000040F573F93F4C982E99EA535E400A403990C9363F40000000002485F93F69FC209DEA535E40ED3D3963C8363F40000000C019AEF93F', '2025-06-04 15:54:45.935348', '2025-06-04 15:54:45.935348', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271285', '8645782395347271291', 2, 1);
INSERT INTO public.lane VALUES ('8642348861051895740', 100001, '01020000A0E610000004000000A22B20D3EB535E4004738C15C9363F40000000801134F93F9035A9BCEB535E40968224A2CE363F4000000060E101F93F31601A9DEB535E40D3CABFC1D7363F40000000605A8DF83F18F0CF98EB535E40D82935FFD8363F40000000A06464F83F', '2025-06-04 15:54:46.537143', '2025-06-04 15:54:46.537143', 'driving', 'null', 0, 'generate', 99, '0', '8645782395347271282', '8645782395347271280', 1, 1);
INSERT INTO public.lane VALUES ('8642348861051895782', 100001, '01020000A0E610000003000000183ECCA5EB535E40701ECDDFA4363F4000000080FD9EFA3F1691F679EB535E40F3608825B0363F4000000020B2BAFA3F13D44175EB535E40D5BD045DB1363F4000000060BC91FA3F', '2025-06-04 15:54:47.139531', '2025-06-04 15:54:47.139531', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271640', '8645782395347271639', 1, 1);
INSERT INTO public.lane VALUES ('8642348861051895754', 100001, '01020000A0E61000000600000044447194EA535E40DB050E5EF7363F4000000040D7F0F73FB25858AAEA535E407361B6FAF0363F400000000069EAF83F64EEBAB4EA535E40E0629EC5ED363F400000000069EAF83F572447B6EA535E4004DEAB51ED363F40000000206D0EF93F08121BF9EA535E4019D65215DA363F40000000603131F93FE4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F', '2025-06-04 15:54:48.931628', '2025-06-04 15:54:48.931628', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558709', '8645275692285558705', 1, 1);
INSERT INTO public.lane VALUES ('8642348861051895753', 100001, '01020000A0E610000006000000F9A0B8FAE9535E40341C183EF7363F40000000C0EB9EF73F3661F811EA535E40B4BD2CD9F0363F40000000009246F83FB0C08F1EEA535E403F018B31ED363F4000000020966AF83FD03C5D36EA535E40D83D9865E6363F40000000E0C22CF83F05E13A61EA535E4090574DFBD9363F40000000C0399CF83FFBC65165EA535E406DB11ACCD8363F40000000802FC5F83F', '2025-06-04 15:54:49.521749', '2025-06-04 15:54:49.521749', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645275692285558705', '8645275692285558706', 2, 1);
INSERT INTO public.lane VALUES ('8642348861051895750', 100001, '01020000A0E61000000600000018F0CF98EB535E40D82935FFD8363F40000000A06464F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73F33AD8255EB535E40049892E2EC363F40000000807640F83F062D0352EB535E40E5FAA4FEED363F40000000E09D11F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73FE8E1FC34EB535E408783C18BF7363F400000008030F0F73F', '2025-06-04 15:54:50.112267', '2025-06-04 15:54:50.112267', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558708', '8645275692285558707', 1, 1);
INSERT INTO public.lane VALUES ('8642197643843338210', 100001, '01020000A0E610000003000000B20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F4096E203EB535E4028B1EAFAA5363F40000000600BCFFA3FAEF13109EB535E40D55809B0A4363F40000000C00776FA3F', '2025-06-04 16:39:19.057212', '2025-06-04 16:39:19.057212', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271633', '8645782395347271634', 1, 1);
INSERT INTO public.lane VALUES ('8642197643843338214', 100001, '01020000A0E610000003000000183ECCA5EB535E40701ECDDFA4363F4000000080FD9EFA3F1691F679EB535E40F3608825B0363F4000000020B2BAFA3F13D44175EB535E40D5BD045DB1363F4000000060BC91FA3F', '2025-06-04 16:39:19.689533', '2025-06-04 16:39:19.690531', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271640', '8645782395347271639', 1, 1);
INSERT INTO public.lane VALUES ('8642197643843338234', 100001, '01020000A0E610000005000000932E26CBE3535E408A32ACC6B8363F40000000E034EFF83FDC552EA5E5535E40C594BFB0B9363F40000000808869F93F2F533A28E6535E40CB0F27F3B9363F40000000805F0DFA3F16DF046AE7535E40BE7629A8BA363F4000000040C7EAF93FC2227AAAE7535E40D6005ECCBA363F4000000000BD13FA3F', '2025-06-04 16:39:23.437089', '2025-06-04 16:39:23.437089', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591815', '8645924713383591814', 1, 1);
INSERT INTO public.lane VALUES ('8642197643843338204', 100001, '01020000A0E61000001300000013D44175EB535E40D5BD045DB1363F4000000060BC91FA3F09A69A59EB535E403399368BB3363F4000000060BC91FA3FF66A9E28EB535E400E3B2667B5363F40000000A01101FB3F57A15320EB535E407F3AD4A5B5363F40000000A01101FB3FA1164BDDEA535E409CB9E03CB7363F40000000A01101FB3FC04AB2CCEA535E403D950690B7363F4000000000C307FB3F02DAD27AEA535E4095160AE5B8363F400000006068AEFA3F6D8B2D62EA535E40E31A533BB9363F400000006068AEFA3FC1916B03EA535E40FAA53451BA363F400000006068AEFA3FAC73A4E4E9535E40D6E2C09CBA363F400000006068AEFA3F7D3E537AE9535E407040E373BB363F40000000A07285FA3F6C522558E9535E40593606ACBB363F4000000060235EFA3FAE11A5E3E8535E40B290DC41BC363F40000000A02D35FA3F9C7CEAC0E8535E403AE51863BC363F400000002042E3F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F30506644E8535E40FFDFD6B2BC363F40000000E06068F93F8320AF23E8535E40BDA34ABDBC363F40000000607516F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 15:59:49.738273', '2025-06-04 15:59:49.738273', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271617', '8645782395347271616', 1, 1);
INSERT INTO public.lane VALUES ('8642197643843338154', 100001, '01020000A0E61000001300000013D44175EB535E40D5BD045DB1363F4000000060BC91FA3F09A69A59EB535E403399368BB3363F4000000060BC91FA3FF66A9E28EB535E400E3B2667B5363F40000000A01101FB3F57A15320EB535E407F3AD4A5B5363F40000000A01101FB3FA1164BDDEA535E409CB9E03CB7363F40000000A01101FB3FC04AB2CCEA535E403D950690B7363F4000000000C307FB3F02DAD27AEA535E4095160AE5B8363F400000006068AEFA3F6D8B2D62EA535E40E31A533BB9363F400000006068AEFA3FC1916B03EA535E40FAA53451BA363F400000006068AEFA3FAC73A4E4E9535E40D6E2C09CBA363F400000006068AEFA3F7D3E537AE9535E407040E373BB363F40000000A07285FA3F6C522558E9535E40593606ACBB363F4000000060235EFA3FAE11A5E3E8535E40B290DC41BC363F40000000A02D35FA3F9C7CEAC0E8535E403AE51863BC363F400000002042E3F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F30506644E8535E40FFDFD6B2BC363F40000000E06068F93F8320AF23E8535E40BDA34ABDBC363F40000000607516F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 16:15:44.838346', '2025-06-04 16:15:44.838346', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271617', '8645782395347271616', 1, 1);
INSERT INTO public.lane VALUES ('8642135968112967680', 100001, '01020000A0E61000001300000013D44175EB535E40D5BD045DB1363F4000000060BC91FA3F09A69A59EB535E403399368BB3363F4000000060BC91FA3FF66A9E28EB535E400E3B2667B5363F40000000A01101FB3F57A15320EB535E407F3AD4A5B5363F40000000A01101FB3FA1164BDDEA535E409CB9E03CB7363F40000000A01101FB3FC04AB2CCEA535E403D950690B7363F4000000000C307FB3F02DAD27AEA535E4095160AE5B8363F400000006068AEFA3F6D8B2D62EA535E40E31A533BB9363F400000006068AEFA3FC1916B03EA535E40FAA53451BA363F400000006068AEFA3FAC73A4E4E9535E40D6E2C09CBA363F400000006068AEFA3F7D3E537AE9535E407040E373BB363F40000000A07285FA3F6C522558E9535E40593606ACBB363F4000000060235EFA3FAE11A5E3E8535E40B290DC41BC363F40000000A02D35FA3F9C7CEAC0E8535E403AE51863BC363F400000002042E3F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F30506644E8535E40FFDFD6B2BC363F40000000E06068F93F8320AF23E8535E40BDA34ABDBC363F40000000607516F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 16:38:01.720243', '2025-06-04 16:38:01.720243', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271617', '8645782395347271616', 1, 1);
INSERT INTO public.lane VALUES ('8642197643843338190', 100001, '01020000A0E61000000300000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93F6FD844D3EA535E40E0A8A551B2363F4000000020DB16FA3FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 16:39:20.945829', '2025-06-04 16:39:20.945829', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271581', '8645782395347271582', 1, 1);
INSERT INTO public.lane VALUES ('8642197643843338208', 100001, '01020000A0E61000001300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F307A2F3DE8535E4084AC16F4B8363F40000000E06068F93F36331E98E8535E40365884D7B8363F40000000604CBAF93F0A534ABEE8535E40D707E5BFB8363F40000000604CBAF93FC32F6C02E9535E4048665380B8363F40000000200AF4F93F4ABB313AE9535E40FB6BE939B8363F40000000E0FF1CFA3FB5BB8667E9535E40C611BFF0B7363F40000000E0FF1CFA3F1DA849ACE9535E40A83C8267B7363F4000000000EC63FA3F1AF228C5E9535E4079C75C2BB7363F4000000000EC63FA3F19105C10EA535E40F6097A51B6363F4000000040F63AFA3FEC2E2019EA535E40FCEA3533B6363F4000000040F63AFA3FE1560761EA535E4068944F0BB5363F4000000040F63AFA3F6306A962EA535E404A1C3503B5363F4000000040F63AFA3FC8010F9AEA535E40E0B878B7B3363F40000000A05DFEF93F6F4F0CA0EA535E4063A2C28AB3363F40000000204950FA3F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93F7D4166C2EA535E40EC2A4943B2363F40000000A05DFEF93F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 16:39:20.313513', '2025-06-04 16:39:20.313513', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271618', '8645782395347271619', 1, 1);
INSERT INTO public.lane VALUES ('8642197643843338187', 100001, '01020000A0E61000000600000044447194EA535E40DB050E5EF7363F4000000040D7F0F73FB25858AAEA535E407361B6FAF0363F400000000069EAF83F64EEBAB4EA535E40E0629EC5ED363F400000000069EAF83F572447B6EA535E4004DEAB51ED363F40000000206D0EF93F08121BF9EA535E4019D65215DA363F40000000603131F93FE4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F', '2025-06-04 16:39:21.569829', '2025-06-04 16:39:21.569829', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558709', '8645275692285558705', 1, 1);
INSERT INTO public.lane VALUES ('8642197643843338186', 100001, '01020000A0E610000006000000F9A0B8FAE9535E40341C183EF7363F40000000C0EB9EF73F3661F811EA535E40B4BD2CD9F0363F40000000009246F83FB0C08F1EEA535E403F018B31ED363F4000000020966AF83FD03C5D36EA535E40D83D9865E6363F40000000E0C22CF83F05E13A61EA535E4090574DFBD9363F40000000C0399CF83FFBC65165EA535E406DB11ACCD8363F40000000802FC5F83F', '2025-06-04 16:39:22.195434', '2025-06-04 16:39:22.195434', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645275692285558705', '8645275692285558706', 2, 1);
INSERT INTO public.lane VALUES ('8642197643843338183', 100001, '01020000A0E61000000600000018F0CF98EB535E40D82935FFD8363F40000000A06464F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73F33AD8255EB535E40049892E2EC363F40000000807640F83F062D0352EB535E40E5FAA4FEED363F40000000E09D11F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73FE8E1FC34EB535E408783C18BF7363F400000008030F0F73F', '2025-06-04 16:39:22.818216', '2025-06-04 16:39:22.819216', 'driving', 'null', 0, 'generate', 99, '0', '8645275692285558708', '8645275692285558707', 1, 1);
INSERT INTO public.lane VALUES ('8642197643843338218', 100001, '01020000A0E61000000300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F036CDAA1EE535E40114D1596BC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 16:39:24.061013', '2025-06-04 16:39:24.061013', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271659', '8645782395347271658', 1, 1);
INSERT INTO public.lane VALUES ('8642197643843338166', 100001, '01020000A0E61000001400000048A3CD34EB535E40408843BAC8363F4000000080BF7BFA3FF99CCD40EB535E40BEA7CD93C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 16:39:24.691329', '2025-06-04 16:39:24.691329', 'virtual', 'null', 0, 'generate', 99, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8642197643843338222', 100001, '01020000A0E6100000030000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F15AD58D3E7535E40E7AE7BE4BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 16:39:25.3141', '2025-06-04 16:39:25.3141', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271662', '8645782395347271663', 1, 1);
INSERT INTO public.lane VALUES ('8642197643843338193', 100001, '01020000A0E61000001400000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93FDAFD1B95EA535E402A916AF6C5363F4000000040810CFA3F94BC0A8EEA535E40E29AF16CC5363F40000000808BE3F93F636EF973EA535E40B3BF1920C4363F40000000808BE3F93FFC1E9766EA535E40492FF8A1C3363F40000000C095BAF93F7FB7993AEA535E40A3C8465FC2363F40000000C095BAF93FA9708529EA535E404FD2CEF9C1363F40000000E073CBF93F84C401EAE9535E403E1B7FC3C0363F40000000608879F93F472B40D9E9535E404A58077FC0363F40000000A09250F93FC33B4784E9535E405172545CBF363F40000000A09250F93F0AB16A78E9535E402DC7383ABF363F40000000E09C27F93F460D8A0CE9535E409365CD37BE363F4000000060F948F93F15F0D508E9535E407B337430BE363F4000000060F948F93F4D9FB58CE8535E40224D1A75BD363F40000000206B3FF93F6AC2D585E8535E40BD6F516DBD363F40000000206B3FF93FD1487CD5E7535E40B7B219E7BC363F40000000C004F5F83F39F46C0FE8535E40228CF00DBD363F40000000607516F93FE6C4B4F5E7535E40B1321AF9BC363F40000000C004F5F83FD1487CD5E7535E40B7B219E7BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 16:39:25.937813', '2025-06-04 16:39:25.937813', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271583', '8645782395347271584', 1, 1);
INSERT INTO public.lane VALUES ('8642197643843338170', 100001, '01020000A0E610000015000000C2227AAAE7535E40D6005ECCBA363F4000000000BD13FA3F3314AF66E8535E4065ABD0E2BA363F40000000A02D35FA3FDC0073FAE8535E4017B46047BB363F4000000060235EFA3FA58A3D0FE9535E40FF2A2A5CBB363F4000000060235EFA3F59EF5BA0E9535E40CFA63C1DBC363F40000000A07285FA3F8E3B5EAEE9535E40BD70F134BC363F40000000A07285FA3F5A84D939EA535E40752A8D56BD363F40000000A07285FA3FA7F8553FEA535E4087EC5B64BD363F400000006068AEFA3FF63ED9BDEA535E401B8FF1DFBE363F400000006036C1FA3F20CBB0C1EA535E40A46EB3EDBE363F400000006036C1FA3FA0275426EB535E40F7BEB19AC0363F4000000060B307FB3FF7F68B32EB535E40622757D9C0363F40000000A0BDDEFA3FFF78F176EB535E400267E283C2363F4000000040C3F7FA3FFA430D88EB535E40D8BC1C09C3363F4000000080CDCEFA3F743F9DAEEB535E40305CBD8DC4363F40000000C0D7A5FA3F95304FBEEB535E407DD77C69C5363F4000000040EC53FA3F710142CDEB535E404114BAB5C6363F40000000C00002FA3F951065D5EB535E405E4619C0C7363F4000000000FD85F93F6A97E3D3EB535E40C90E7DB9C7363F4000000000FD85F93F951065D5EB535E405E4619C0C7363F4000000000FD85F93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 16:39:26.560102', '2025-06-04 16:39:26.560102', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271661', '8645782395347271660', 1, 1);
INSERT INTO public.lane VALUES ('8642197643843338162', 100001, '01020000A0E6100000140000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F34611266EE535E40CD9D759AC0363F40000000805A70F93F20F45001EE535E401A1986BDC0363F40000000405099F93FF3D48DF1ED535E4044CCDBC7C0363F40000000805A70F93FB5F5488DED535E4097A8FF28C1363F40000000A0A7FAF93F8453A581ED535E409D9A2E38C1363F4000000020BCA8F93F7633A31FED535E40850D5EDAC1363F4000000040C67FF93F0DC6CF19ED535E4049C64BE6C1363F4000000040C67FF93F6E011DBDEC535E40E42023CBC2363F40000000E07B8DF93F6CA9D7BBEC535E40FCE7E0CEC2363F40000000E07B8DF93FE59B6D6EEC535E4054785BDFC3363F40000000205D08FA3FD73FE065EC535E40B9FE4603C4363F40000000205D08FA3F72F3322FEC535E409B2DB116C5363F400000004015B0F93F9C680121EC535E40E8E0B26DC5363F40000000801F87F93F287C3F00EC535E40D6A13567C6363F40000000801F87F93F592479F0EB535E406BAB6E02C7363F40000000801F87F93FD32B35E0EB535E40942780CAC7363F4000000040075DF93F150705E2EB535E40761A01C6C7363F4000000040075DF93FD32B35E0EB535E40942780CAC7363F4000000040075DF93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 16:39:27.791442', '2025-06-04 16:39:27.791442', 'virtual', NULL, 0, 'generate', 99, '0', '8645924713383591836', '8645924713383591853', 1, 1);
INSERT INTO public.lane VALUES ('8642197643843338201', 100001, '01020000A0E6100000160000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F908E8212EC535E4021E04854B3363F4000000020DB16FA3F6512B61EEC535E40036CD5E8B4363F40000000E04434FA3FF592C920EC535E402C6ADC0DB5363F40000000204F0BFA3FB4CBB73EEC535E40F6378C75B6363F400000002001EAF93F66F67E45EC535E40BA6C88B2B6363F40000000C0EC3BFA3FA8D59772EC535E4007E064F0B7363F400000002001EAF93FDD14707EEC535E409C325334B8363F40000000E0F612FA3FA97CD7B9EC535E40BFA7284DB9363F40000000E014B3F93F5938E6C8EC535E409BDAD588B9363F4000000020F62DFA3F79880713ED535E40004EB07EBA363F40000000A00ADCF93F81740A22ED535E40068B90A8BA363F40000000A00ADCF93F4C92BE7BED535E4011996678BB363F40000000602961F93F3CB70387ED535E407C0AED8DBB363F40000000602961F93F1AA4B0F0ED535E40A0B4B92FBC363F40000000005230F93F6B57F0F4ED535E40A07DC634BC363F40000000005230F93F15813D68EE535E40D573E997BC363F40000000405C07F93FBCCE3A6EEE535E40CF477C9BBC363F40000000405C07F93F390C6FA1EE535E409A020EABBC363F40000000405C07F93F77E66CA1EE535E409F9916ABBC363F400000008066DEF83F390C6FA1EE535E409A020EABBC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 16:39:28.403927', '2025-06-04 16:39:28.403927', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271614', '8645782395347271615', 1, 1);
INSERT INTO public.lane VALUES ('8642197643843338213', 100001, '01020000A0E610000003000000EFCB6143EC535E404033DE0FA5363F40000000A0E94FFA3FC18E971FEC535E40057B3250B0363F4000000020DB16FA3F3E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F', '2025-06-04 16:39:29.020199', '2025-06-04 16:39:29.020199', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271639', '8645782395347271637', 2, 1);
INSERT INTO public.lane VALUES ('8642197643843338236', 100001, '01020000A0E61000001800000047DB93E8EE535E40730DB76CC2363F40000000601F2BF83F4DB70866EE535E40D2818998C2363F40000000601F2BF83F6AE30936EE535E40903F67BEC2363F40000000201554F83FBDA3DD20EE535E40D833E4D5C2363F40000000601F2BF83FD24B2CF3ED535E40AE2DFA12C3363F40000000E00A7DF83FC81A3AE5ED535E406D324028C3363F40000000201554F83F180405C7ED535E401F378761C3363F40000000201554F83F54E6119CED535E406C624EBEC3363F4000000060B997F83F1E97C49BED535E4072A80FBFC3363F4000000060B997F83F326CBD74ED535E40A2110932C4363F40000000E0A4E9F83F51CAED5CED535E40079C3D81C4363F40000000E0A4E9F83FD4C7F54FED535E400CBC7EB4C4363F4000000020AFC0F83F991E292FED535E407D582346C5363F4000000060B997F83F5D6FC629ED535E40189C4260C5363F4000000060B997F83F144DCD09ED535E40D6DA751BC6363F4000000000D81CF83F917CD901ED535E40BE65FD4FC6363F4000000000D81CF83F70208CEEEC535E403BDC20F0C6363F4000000040E2F3F73FF28E5BE5EC535E40EDB0084CC7363F400000000002E4F73FEE6C37DDEC535E4088FCB9BCC7363F400000000002E4F73F282511D5EC535E40CFE2BD51C8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F4B51D3D3EC535E40E742297DC8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F5AD1FDD4EC535E40D43B9DAAC9363F40000000C02069F73F', '2025-06-04 16:39:29.638422', '2025-06-04 16:39:29.638422', 'virtual', '["non_motor_vehicle","walker"]', 0, 'generate', 99, '0', '8645924713383591843', '8645924713383591842', 1, 1);
INSERT INTO public.lane VALUES ('8642197643843338226', 100001, '01020000A0E610000006000000E647666FF5535E405BB4DF5EC2363F40000000C066EBF73F7AE31B3FF1535E409852C20CC0363F40000000605AD4F83F58054923EF535E4063E775DDBE363F40000000002F01FA3F229B589EEF535E408CA8F322BF363F4000000000585DF93F58054923EF535E4063E775DDBE363F40000000002F01FA3F5C29BAE4EE535E40E6B320BABE363F40000000803114FA3F', '2025-06-04 16:39:30.258762', '2025-06-04 16:39:30.258762', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591799', '8645924713383591876', 1, 1);
INSERT INTO public.lane VALUES ('8642197643843338225', 100001, '01020000A0E610000007000000DFE39D5AF5535E40AD120647C4363F40000000C08F47F73F6CB106E8F1535E40087F9160C2363F40000000809B68F73F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93FB743268DEF535E402091A20DC1363F40000000C076E2F83F11928B85EF535E40A3C25209C1363F400000000081B9F83F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93F4A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F', '2025-06-04 16:39:30.876366', '2025-06-04 16:39:30.876366', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591876', '8645924713383591870', 2, 1);
INSERT INTO public.lane VALUES ('8642197643843338228', 100001, '01020000A0E610000004000000E25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83FC359A750F1535E40CEE61D19BE363F40000000608330F83FBE6DFC42F5535E407A502051C0363F4000000040500BF73F0AE9A281F5535E40E5BE5B74C0363F40000000001DD8F73F', '2025-06-04 16:39:31.491439', '2025-06-04 16:39:31.491439', 'driving', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645924713383591798', '8645924713383591800', 1, 1);
INSERT INTO public.lane VALUES ('8642197643843338197', 100001, '01020000A0E6100000110000005C29BAE4EE535E40E6B320BABE363F40000000803114FA3FF48E8D1FEE535E405D7ED048BE363F4000000040273DFA3F35C12168ED535E4034801A6BBD363F4000000060D7A8FA3FC291AA67ED535E4034D1616ABD363F4000000060D7A8FA3F661FF9BDEC535E40F3F97C22BC363F4000000020CDD1FA3F6FEEC6BAEC535E403B89F41ABC363F4000000020CDD1FA3F5229FF25EC535E40DC9CFE77BA363F40000000C0260FFB3F89078522EC535E403B6E446CBA363F400000000031E6FA3F7DE7ECA4EB535E4096D0F075B8363F4000000020FD52FB3F3A1249A3EB535E40A279126EB8363F4000000020FD52FB3F2D438E40EB535E405B4E9531B6363F40000000A01101FB3FDA515D3FEB535E4073760F29B6363F40000000A01101FB3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3F915FC3FCEA535E40FD13F4C8B3363F4000000020B2BAFA3F4004C9F9EA535E40924747A4B3363F4000000060BC91FA3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 16:39:32.104382', '2025-06-04 16:39:32.104382', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271590', '8645782395347271591', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646208', 100001, '01020000A0E61000001300000013D44175EB535E40D5BD045DB1363F4000000060BC91FA3F09A69A59EB535E403399368BB3363F4000000060BC91FA3FF66A9E28EB535E400E3B2667B5363F40000000A01101FB3F57A15320EB535E407F3AD4A5B5363F40000000A01101FB3FA1164BDDEA535E409CB9E03CB7363F40000000A01101FB3FC04AB2CCEA535E403D950690B7363F4000000000C307FB3F02DAD27AEA535E4095160AE5B8363F400000006068AEFA3F6D8B2D62EA535E40E31A533BB9363F400000006068AEFA3FC1916B03EA535E40FAA53451BA363F400000006068AEFA3FAC73A4E4E9535E40D6E2C09CBA363F400000006068AEFA3F7D3E537AE9535E407040E373BB363F40000000A07285FA3F6C522558E9535E40593606ACBB363F4000000060235EFA3FAE11A5E3E8535E40B290DC41BC363F40000000A02D35FA3F9C7CEAC0E8535E403AE51863BC363F400000002042E3F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F30506644E8535E40FFDFD6B2BC363F40000000E06068F93F8320AF23E8535E40BDA34ABDBC363F40000000607516F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 16:39:32.724718', '2025-06-04 16:39:32.724718', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271617', '8645782395347271616', 1, 1);
INSERT INTO public.lane VALUES ('8642197643843338158', 100001, '01020000A0E6100000030000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93FA5391CD7EB535E408E9DA1CCC7363F4000000000FD85F93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 16:39:33.345085', '2025-06-04 16:39:33.345085', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 99, '0', '8645782395347271613', '8645782395347271612', 1, 1);
INSERT INTO public.lane VALUES ('8642197643843338233', 100001, '01020000A0E610000006000000E2EA72DDE3535E40C0E6F1BBB6363F400000004033F3F83FA711BEEDE5535E40BA3A8BD4B7363F40000000A014EDF83F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93FC5016651E7535E40FB8DCF94B8363F40000000A02255F93F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93F24ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F', '2025-06-04 16:39:33.972135', '2025-06-04 16:39:33.972135', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645924713383591814', '8645924713383591813', 2, 1);
INSERT INTO public.lane VALUES ('8642197643843338180', 100001, '01020000A0E610000005000000FBC65165EA535E406DB11ACCD8363F40000000802FC5F83F4C982E99EA535E400A403990C9363F40000000002485F93FEF8F5F8EEA535E409137BECBCC363F4000000040F573F93F4C982E99EA535E400A403990C9363F40000000002485F93F69FC209DEA535E40ED3D3963C8363F40000000C019AEF93F', '2025-06-04 16:39:34.593796', '2025-06-04 16:39:34.593796', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271285', '8645782395347271291', 2, 1);
INSERT INTO public.lane VALUES ('8642197643843338181', 100001, '01020000A0E610000005000000E4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F71AAB530EB535E4033FB20F1C9363F4000000000D429FA3F77AFA426EB535E40566526EBCC363F40000000A09920FA3F71AAB530EB535E4033FB20F1C9363F4000000000D429FA3F48A3CD34EB535E40408843BAC8363F4000000080BF7BFA3F', '2025-06-04 16:39:35.210797', '2025-06-04 16:39:35.210797', 'driving', 'all_motor_vehicle', 0, 'generate', 99, '0', '8645782395347271283', '8645782395347271285', 1, 1);
INSERT INTO public.lane VALUES ('8642197643843338173', 100001, '01020000A0E610000004000000A22B20D3EB535E4004738C15C9363F40000000801134F93F9035A9BCEB535E40968224A2CE363F4000000060E101F93F31601A9DEB535E40D3CABFC1D7363F40000000605A8DF83F18F0CF98EB535E40D82935FFD8363F40000000A06464F83F', '2025-06-04 16:39:35.827443', '2025-06-04 16:39:35.827443', 'driving', 'null', 0, 'generate', 99, '0', '8645782395347271282', '8645782395347271280', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646204', 100001, '01020000A0E61000001800000047DB93E8EE535E40730DB76CC2363F40000000601F2BF83F4DB70866EE535E40D2818998C2363F40000000601F2BF83F6AE30936EE535E40903F67BEC2363F40000000201554F83FBDA3DD20EE535E40D833E4D5C2363F40000000601F2BF83FD24B2CF3ED535E40AE2DFA12C3363F40000000E00A7DF83FC81A3AE5ED535E406D324028C3363F40000000201554F83F180405C7ED535E401F378761C3363F40000000201554F83F54E6119CED535E406C624EBEC3363F4000000060B997F83F1E97C49BED535E4072A80FBFC3363F4000000060B997F83F326CBD74ED535E40A2110932C4363F40000000E0A4E9F83F51CAED5CED535E40079C3D81C4363F40000000E0A4E9F83FD4C7F54FED535E400CBC7EB4C4363F4000000020AFC0F83F991E292FED535E407D582346C5363F4000000060B997F83F5D6FC629ED535E40189C4260C5363F4000000060B997F83F144DCD09ED535E40D6DA751BC6363F4000000000D81CF83F917CD901ED535E40BE65FD4FC6363F4000000000D81CF83F70208CEEEC535E403BDC20F0C6363F4000000040E2F3F73FF28E5BE5EC535E40EDB0084CC7363F400000000002E4F73FEE6C37DDEC535E4088FCB9BCC7363F400000000002E4F73F282511D5EC535E40CFE2BD51C8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F4B51D3D3EC535E40E742297DC8363F40000000400CBBF73FBCD7BDD3EC535E40E732B488C8363F40000000400CBBF73F5AD1FDD4EC535E40D43B9DAAC9363F40000000C02069F73F', '2025-06-04 16:39:48.922376', '2025-06-04 16:39:48.922376', 'virtual', '["non_motor_vehicle","walker"]', 0, 'generate', 0, '0', '8645924713383591843', '8645924713383591842', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646202', 100001, '01020000A0E610000005000000932E26CBE3535E408A32ACC6B8363F40000000E034EFF83FDC552EA5E5535E40C594BFB0B9363F40000000808869F93F2F533A28E6535E40CB0F27F3B9363F40000000805F0DFA3F16DF046AE7535E40BE7629A8BA363F4000000040C7EAF93FC2227AAAE7535E40D6005ECCBA363F4000000000BD13FA3F', '2025-06-04 16:39:49.807551', '2025-06-04 16:39:49.807551', 'driving', 'all_motor_vehicle', 0, 'generate', 0, '0', '8645924713383591815', '8645924713383591814', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646201', 100001, '01020000A0E610000006000000E2EA72DDE3535E40C0E6F1BBB6363F400000004033F3F83FA711BEEDE5535E40BA3A8BD4B7363F40000000A014EDF83F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93FC5016651E7535E40FB8DCF94B8363F40000000A02255F93F81AEFC80E7535E40B9684CB1B8363F40000000A02255F93F24ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F', '2025-06-04 16:39:49.807551', '2025-06-04 16:39:49.807551', 'driving', 'all_motor_vehicle', 0, 'generate', 0, '0', '8645924713383591814', '8645924713383591813', 2, 1);
INSERT INTO public.lane VALUES ('8642101470935646198', 100001, '01020000A0E61000000500000098DD0A96E7535E4082E472C3BC363F40000000C004F5F83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F6065498DE4535E40BE82042ABB363F40000000E05D4BF83FB8C3A0F8E3535E408F1D54E2BA363F40000000A05374F83F3AED54B9E3535E40E891CFC3BA363F4000000000183AF83F', '2025-06-04 16:39:50.494959', '2025-06-04 16:39:50.494959', 'driving', '["all_motor_vehicle"]', 0, 'generate', 0, '0', '8645924713383591816', '8645924713383591818', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646193', 100001, '01020000A0E610000007000000DFE39D5AF5535E40AD120647C4363F40000000C08F47F73F6CB106E8F1535E40087F9160C2363F40000000809B68F73F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93FB743268DEF535E402091A20DC1363F40000000C076E2F83F11928B85EF535E40A3C25209C1363F400000000081B9F83F2EF13625EF535E40BB953CD6C0363F40000000806C0BF93F4A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F', '2025-06-04 16:39:51.939845', '2025-06-04 16:39:51.939845', 'driving', '["all_motor_vehicle"]', 0, 'generate', 0, '0', '8645924713383591876', '8645924713383591870', 2, 1);
INSERT INTO public.lane VALUES ('8642101470935646190', 100001, '01020000A0E6100000030000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F15AD58D3E7535E40E7AE7BE4BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 16:39:52.533909', '2025-06-04 16:39:52.533909', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 0, '0', '8645782395347271662', '8645782395347271663', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646186', 100001, '01020000A0E61000000300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F036CDAA1EE535E40114D1596BC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 16:39:53.259623', '2025-06-04 16:39:53.259623', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 0, '0', '8645782395347271659', '8645782395347271658', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646182', 100001, '01020000A0E610000003000000183ECCA5EB535E40701ECDDFA4363F4000000080FD9EFA3F1691F679EB535E40F3608825B0363F4000000020B2BAFA3F13D44175EB535E40D5BD045DB1363F4000000060BC91FA3F', '2025-06-04 16:39:54.27038', '2025-06-04 16:39:54.27038', 'driving', '["all_motor_vehicle"]', 0, 'generate', 0, '0', '8645782395347271640', '8645782395347271639', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646181', 100001, '01020000A0E610000003000000EFCB6143EC535E404033DE0FA5363F40000000A0E94FFA3FC18E971FEC535E40057B3250B0363F4000000020DB16FA3F3E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F', '2025-06-04 16:39:54.27038', '2025-06-04 16:39:54.27038', 'driving', '["all_motor_vehicle"]', 0, 'generate', 0, '0', '8645782395347271639', '8645782395347271637', 2, 1);
INSERT INTO public.lane VALUES ('8642101470935646178', 100001, '01020000A0E610000003000000B20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F4096E203EB535E4028B1EAFAA5363F40000000600BCFFA3FAEF13109EB535E40D55809B0A4363F40000000C00776FA3F', '2025-06-04 16:39:54.865523', '2025-06-04 16:39:54.865523', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 0, '0', '8645782395347271633', '8645782395347271634', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646176', 100001, '01020000A0E61000001300000024ABDEBEE7535E4072E068D6B8363F4000000000E66FF93F307A2F3DE8535E4084AC16F4B8363F40000000E06068F93F36331E98E8535E40365884D7B8363F40000000604CBAF93F0A534ABEE8535E40D707E5BFB8363F40000000604CBAF93FC32F6C02E9535E4048665380B8363F40000000200AF4F93F4ABB313AE9535E40FB6BE939B8363F40000000E0FF1CFA3FB5BB8667E9535E40C611BFF0B7363F40000000E0FF1CFA3F1DA849ACE9535E40A83C8267B7363F4000000000EC63FA3F1AF228C5E9535E4079C75C2BB7363F4000000000EC63FA3F19105C10EA535E40F6097A51B6363F4000000040F63AFA3FEC2E2019EA535E40FCEA3533B6363F4000000040F63AFA3FE1560761EA535E4068944F0BB5363F4000000040F63AFA3F6306A962EA535E404A1C3503B5363F4000000040F63AFA3FC8010F9AEA535E40E0B878B7B3363F40000000A05DFEF93F6F4F0CA0EA535E4063A2C28AB3363F40000000204950FA3F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93F7D4166C2EA535E40EC2A4943B2363F40000000A05DFEF93F9E86AAC3EA535E4057104C33B2363F40000000E067D5F93FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 16:39:55.423798', '2025-06-04 16:39:55.423798', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 0, '0', '8645782395347271618', '8645782395347271619', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646172', 100001, '01020000A0E61000001300000013D44175EB535E40D5BD045DB1363F4000000060BC91FA3F09A69A59EB535E403399368BB3363F4000000060BC91FA3FF66A9E28EB535E400E3B2667B5363F40000000A01101FB3F57A15320EB535E407F3AD4A5B5363F40000000A01101FB3FA1164BDDEA535E409CB9E03CB7363F40000000A01101FB3FC04AB2CCEA535E403D950690B7363F4000000000C307FB3F02DAD27AEA535E4095160AE5B8363F400000006068AEFA3F6D8B2D62EA535E40E31A533BB9363F400000006068AEFA3FC1916B03EA535E40FAA53451BA363F400000006068AEFA3FAC73A4E4E9535E40D6E2C09CBA363F400000006068AEFA3F7D3E537AE9535E407040E373BB363F40000000A07285FA3F6C522558E9535E40593606ACBB363F4000000060235EFA3FAE11A5E3E8535E40B290DC41BC363F40000000A02D35FA3F9C7CEAC0E8535E403AE51863BC363F400000002042E3F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F30506644E8535E40FFDFD6B2BC363F40000000E06068F93F8320AF23E8535E40BDA34ABDBC363F40000000607516F93F7D574BD4E7535E409F1BBBC0BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 16:39:56.120331', '2025-06-04 16:39:56.120331', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 0, '0', '8645782395347271617', '8645782395347271616', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646168', 100001, '01020000A0E6100000160000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93F908E8212EC535E4021E04854B3363F4000000020DB16FA3F6512B61EEC535E40036CD5E8B4363F40000000E04434FA3FF592C920EC535E402C6ADC0DB5363F40000000204F0BFA3FB4CBB73EEC535E40F6378C75B6363F400000002001EAF93F66F67E45EC535E40BA6C88B2B6363F40000000C0EC3BFA3FA8D59772EC535E4007E064F0B7363F400000002001EAF93FDD14707EEC535E409C325334B8363F40000000E0F612FA3FA97CD7B9EC535E40BFA7284DB9363F40000000E014B3F93F5938E6C8EC535E409BDAD588B9363F4000000020F62DFA3F79880713ED535E40004EB07EBA363F40000000A00ADCF93F81740A22ED535E40068B90A8BA363F40000000A00ADCF93F4C92BE7BED535E4011996678BB363F40000000602961F93F3CB70387ED535E407C0AED8DBB363F40000000602961F93F1AA4B0F0ED535E40A0B4B92FBC363F40000000005230F93F6B57F0F4ED535E40A07DC634BC363F40000000005230F93F15813D68EE535E40D573E997BC363F40000000405C07F93FBCCE3A6EEE535E40CF477C9BBC363F40000000405C07F93F390C6FA1EE535E409A020EABBC363F40000000405C07F93F77E66CA1EE535E409F9916ABBC363F400000008066DEF83F390C6FA1EE535E409A020EABBC363F40000000405C07F93FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 16:39:56.810182', '2025-06-04 16:39:56.810182', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 0, '0', '8645782395347271614', '8645782395347271615', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646164', 100001, '01020000A0E6100000110000005C29BAE4EE535E40E6B320BABE363F40000000803114FA3FF48E8D1FEE535E405D7ED048BE363F4000000040273DFA3F35C12168ED535E4034801A6BBD363F4000000060D7A8FA3FC291AA67ED535E4034D1616ABD363F4000000060D7A8FA3F661FF9BDEC535E40F3F97C22BC363F4000000020CDD1FA3F6FEEC6BAEC535E403B89F41ABC363F4000000020CDD1FA3F5229FF25EC535E40DC9CFE77BA363F40000000C0260FFB3F89078522EC535E403B6E446CBA363F400000000031E6FA3F7DE7ECA4EB535E4096D0F075B8363F4000000020FD52FB3F3A1249A3EB535E40A279126EB8363F4000000020FD52FB3F2D438E40EB535E405B4E9531B6363F40000000A01101FB3FDA515D3FEB535E4073760F29B6363F40000000A01101FB3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3F915FC3FCEA535E40FD13F4C8B3363F4000000020B2BAFA3F4004C9F9EA535E40924747A4B3363F4000000060BC91FA3F3D9BA6E6EA535E403A24B550B2363F4000000020DB16FA3FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 16:39:57.503844', '2025-06-04 16:39:57.503844', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 0, '0', '8645782395347271590', '8645782395347271591', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646160', 100001, '01020000A0E61000001400000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93FDAFD1B95EA535E402A916AF6C5363F4000000040810CFA3F94BC0A8EEA535E40E29AF16CC5363F40000000808BE3F93F636EF973EA535E40B3BF1920C4363F40000000808BE3F93FFC1E9766EA535E40492FF8A1C3363F40000000C095BAF93F7FB7993AEA535E40A3C8465FC2363F40000000C095BAF93FA9708529EA535E404FD2CEF9C1363F40000000E073CBF93F84C401EAE9535E403E1B7FC3C0363F40000000608879F93F472B40D9E9535E404A58077FC0363F40000000A09250F93FC33B4784E9535E405172545CBF363F40000000A09250F93F0AB16A78E9535E402DC7383ABF363F40000000E09C27F93F460D8A0CE9535E409365CD37BE363F4000000060F948F93F15F0D508E9535E407B337430BE363F4000000060F948F93F4D9FB58CE8535E40224D1A75BD363F40000000206B3FF93F6AC2D585E8535E40BD6F516DBD363F40000000206B3FF93FD1487CD5E7535E40B7B219E7BC363F40000000C004F5F83F39F46C0FE8535E40228CF00DBD363F40000000607516F93FE6C4B4F5E7535E40B1321AF9BC363F40000000C004F5F83FD1487CD5E7535E40B7B219E7BC363F40000000C004F5F83F98DD0A96E7535E4082E472C3BC363F40000000C004F5F83F', '2025-06-04 16:39:58.220153', '2025-06-04 16:39:58.220153', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 0, '0', '8645782395347271583', '8645782395347271584', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646157', 100001, '01020000A0E61000000300000069FC209DEA535E40ED3D3963C8363F40000000C019AEF93F6FD844D3EA535E40E0A8A551B2363F4000000020DB16FA3FB20B5AD6EA535E40E7F2510CB1363F40000000E0F99BF93F', '2025-06-04 16:39:58.852312', '2025-06-04 16:39:58.852312', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 0, '0', '8645782395347271581', '8645782395347271582', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646154', 100001, '01020000A0E61000000600000044447194EA535E40DB050E5EF7363F4000000040D7F0F73FB25858AAEA535E407361B6FAF0363F400000000069EAF83F64EEBAB4EA535E40E0629EC5ED363F400000000069EAF83F572447B6EA535E4004DEAB51ED363F40000000206D0EF93F08121BF9EA535E4019D65215DA363F40000000603131F93FE4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F', '2025-06-04 16:39:59.776356', '2025-06-04 16:39:59.776356', 'driving', 'null', 0, 'generate', 0, '0', '8645275692285558709', '8645275692285558705', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646153', 100001, '01020000A0E610000006000000F9A0B8FAE9535E40341C183EF7363F40000000C0EB9EF73F3661F811EA535E40B4BD2CD9F0363F40000000009246F83FB0C08F1EEA535E403F018B31ED363F4000000020966AF83FD03C5D36EA535E40D83D9865E6363F40000000E0C22CF83F05E13A61EA535E4090574DFBD9363F40000000C0399CF83FFBC65165EA535E406DB11ACCD8363F40000000802FC5F83F', '2025-06-04 16:39:59.776356', '2025-06-04 16:39:59.776356', 'driving', 'all_motor_vehicle', 0, 'generate', 0, '0', '8645275692285558705', '8645275692285558706', 2, 1);
INSERT INTO public.lane VALUES ('8642101470935646150', 100001, '01020000A0E61000000600000018F0CF98EB535E40D82935FFD8363F40000000A06464F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73F33AD8255EB535E40049892E2EC363F40000000807640F83F062D0352EB535E40E5FAA4FEED363F40000000E09D11F83FAE0FCF38EB535E402F77384AF6363F40000000C015E5F73FE8E1FC34EB535E408783C18BF7363F400000008030F0F73F', '2025-06-04 16:40:00.32122', '2025-06-04 16:40:00.32122', 'driving', 'null', 0, 'generate', 0, '0', '8645275692285558708', '8645275692285558707', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646148', 100001, '01020000A0E610000005000000E4A13BFDEA535E40EA5256E5D8363F40000000A03B08F93F71AAB530EB535E4033FB20F1C9363F4000000000D429FA3F77AFA426EB535E40566526EBCC363F40000000A09920FA3F71AAB530EB535E4033FB20F1C9363F4000000000D429FA3F48A3CD34EB535E40408843BAC8363F4000000080BF7BFA3F', '2025-06-04 16:40:01.227938', '2025-06-04 16:40:01.227938', 'driving', 'all_motor_vehicle', 0, 'generate', 0, '0', '8645782395347271283', '8645782395347271285', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646147', 100001, '01020000A0E610000005000000FBC65165EA535E406DB11ACCD8363F40000000802FC5F83F4C982E99EA535E400A403990C9363F40000000002485F93FEF8F5F8EEA535E409137BECBCC363F4000000040F573F93F4C982E99EA535E400A403990C9363F40000000002485F93F69FC209DEA535E40ED3D3963C8363F40000000C019AEF93F', '2025-06-04 16:40:01.227938', '2025-06-04 16:40:01.227938', 'driving', 'all_motor_vehicle', 0, 'generate', 0, '0', '8645782395347271285', '8645782395347271291', 2, 1);
INSERT INTO public.lane VALUES ('8642101470935646140', 100001, '01020000A0E610000004000000A22B20D3EB535E4004738C15C9363F40000000801134F93F9035A9BCEB535E40968224A2CE363F4000000060E101F93F31601A9DEB535E40D3CABFC1D7363F40000000605A8DF83F18F0CF98EB535E40D82935FFD8363F40000000A06464F83F', '2025-06-04 16:40:02.036349', '2025-06-04 16:40:02.036349', 'driving', 'null', 0, 'generate', 0, '0', '8645782395347271282', '8645782395347271280', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646137', 100001, '01020000A0E610000015000000C2227AAAE7535E40D6005ECCBA363F4000000000BD13FA3F3314AF66E8535E4065ABD0E2BA363F40000000A02D35FA3FDC0073FAE8535E4017B46047BB363F4000000060235EFA3FA58A3D0FE9535E40FF2A2A5CBB363F4000000060235EFA3F59EF5BA0E9535E40CFA63C1DBC363F40000000A07285FA3F8E3B5EAEE9535E40BD70F134BC363F40000000A07285FA3F5A84D939EA535E40752A8D56BD363F40000000A07285FA3FA7F8553FEA535E4087EC5B64BD363F400000006068AEFA3FF63ED9BDEA535E401B8FF1DFBE363F400000006036C1FA3F20CBB0C1EA535E40A46EB3EDBE363F400000006036C1FA3FA0275426EB535E40F7BEB19AC0363F4000000060B307FB3FF7F68B32EB535E40622757D9C0363F40000000A0BDDEFA3FFF78F176EB535E400267E283C2363F4000000040C3F7FA3FFA430D88EB535E40D8BC1C09C3363F4000000080CDCEFA3F743F9DAEEB535E40305CBD8DC4363F40000000C0D7A5FA3F95304FBEEB535E407DD77C69C5363F4000000040EC53FA3F710142CDEB535E404114BAB5C6363F40000000C00002FA3F951065D5EB535E405E4619C0C7363F4000000000FD85F93F6A97E3D3EB535E40C90E7DB9C7363F4000000000FD85F93F951065D5EB535E405E4619C0C7363F4000000000FD85F93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 16:40:02.685611', '2025-06-04 16:40:02.685611', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 0, '0', '8645782395347271661', '8645782395347271660', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646133', 100001, '01020000A0E61000001400000048A3CD34EB535E40408843BAC8363F4000000080BF7BFA3FF99CCD40EB535E40BEA7CD93C6363F40000000C0D7A5FA3FFD09A363EB535E40B371CCCBC4363F4000000080CDCEFA3FC9536D6FEB535E40608BC95AC4363F40000000C0D7A5FA3F43180A9BEB535E40F0B78215C3363F4000000080CDCEFA3FF4E4F5BBEB535E4043FD964FC2363F40000000A0BDDEFA3FC48141E6EB535E401A9E247EC1363F40000000E09E59FB3F347AF122EC535E40EBB08A83C0363F4000000060B307FB3FBADA8544EC535E404A63350FC0363F40000000206AF0FA3F782EC69FEC535E40EC11E905BF363F40000000206AF0FA3F7BF559B4EC535E404BA8F2D3BE363F40000000206AF0FA3F30C57D2DED535E40101237E1BD363F400000006074C7FA3FD90C4F33ED535E40874CC9D7BD363F40000000A07E9EFA3F83BF3EBEED535E40D57C7927BD363F40000000600A4FFA3F7A6836C7ED535E40F9D2041FBD363F40000000A01426FA3F079E739EEE535E409F5FD8BDBC363F400000008066DEF83F0F0A1F51EE535E4040DFD9C8BC363F40000000005230F93FC389E066EE535E40B72696C1BC363F40000000005230F93F079E739EEE535E409F5FD8BDBC363F400000008066DEF83FE25B3CE2EE535E40E7AA32B9BC363F400000008066DEF83F', '2025-06-04 16:40:03.370846', '2025-06-04 16:40:03.370846', 'virtual', 'null', 0, 'generate', 0, '0', '8645924713383591855', '8645924713383591847', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646129', 100001, '01020000A0E6100000140000004A71CAE6EE535E400FB7CCB4C0363F40000000C06447F93F34611266EE535E40CD9D759AC0363F40000000805A70F93F20F45001EE535E401A1986BDC0363F40000000405099F93FF3D48DF1ED535E4044CCDBC7C0363F40000000805A70F93FB5F5488DED535E4097A8FF28C1363F40000000A0A7FAF93F8453A581ED535E409D9A2E38C1363F4000000020BCA8F93F7633A31FED535E40850D5EDAC1363F4000000040C67FF93F0DC6CF19ED535E4049C64BE6C1363F4000000040C67FF93F6E011DBDEC535E40E42023CBC2363F40000000E07B8DF93F6CA9D7BBEC535E40FCE7E0CEC2363F40000000E07B8DF93FE59B6D6EEC535E4054785BDFC3363F40000000205D08FA3FD73FE065EC535E40B9FE4603C4363F40000000205D08FA3F72F3322FEC535E409B2DB116C5363F400000004015B0F93F9C680121EC535E40E8E0B26DC5363F40000000801F87F93F287C3F00EC535E40D6A13567C6363F40000000801F87F93F592479F0EB535E406BAB6E02C7363F40000000801F87F93FD32B35E0EB535E40942780CAC7363F4000000040075DF93F150705E2EB535E40761A01C6C7363F4000000040075DF93FD32B35E0EB535E40942780CAC7363F4000000040075DF93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 16:40:04.056066', '2025-06-04 16:40:04.056066', 'virtual', NULL, 0, 'generate', 0, '0', '8645924713383591836', '8645924713383591853', 1, 1);
INSERT INTO public.lane VALUES ('8642101470935646125', 100001, '01020000A0E6100000030000003E293F1BEC535E40C3F352B1B1363F4000000060E5EDF93FA5391CD7EB535E408E9DA1CCC7363F4000000000FD85F93FA22B20D3EB535E4004738C15C9363F40000000801134F93F', '2025-06-04 16:40:04.736843', '2025-06-04 16:40:04.736843', 'virtual', '["all_motor_vehicle"]', 0, 'generate', 0, '0', '8645782395347271613', '8645782395347271612', 1, 1);


--
-- TOC entry 4506 (class 0 OID 18032)
-- Dependencies: 221
-- Data for Name: lane_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.lane_group VALUES ('8645924713383591812', 100001, '01030000A0E6100000010000000800000058771F8CE7535E40B1AA8EB7BD363F40000000A0DA27F83F66776285E4535E409AE90827BC363F400000006072F9F73F997A7DB0E3535E40F30160C0BB363F40000000402211F83F997A7DB0E3535E40F30160C0BB363F40000000402211F83FFA4C2BC2E3535E405AD63AC7B9363F4000000000EFDDF83F07A7E21FE6535E404D8356EBBA363F40000000C069E4F93FF830F59FE7535E40D5695BCFBB363F40000000C0DB98F93F58771F8CE7535E40B1AA8EB7BD363F40000000A0DA27F83F', '2025-06-03 11:17:03.405167', '2025-06-03 11:17:03.405167', 99, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645782395347271654', 100001, '01030000A0E610000001000000060000004195D2E7EE535E409739CAB2C1363F400000008083CCF83F58771F8CE7535E40B1AA8EB7BD363F40000000A0DA27F83F58771F8CE7535E40B1AA8EB7BD363F40000000A0DA27F83FF830F59FE7535E40D5695BCFBB363F40000000C0DB98F93F534DC2E5EE535E408634CFB6BF363F40000000C03BEBF93F4195D2E7EE535E409739CAB2C1363F400000008083CCF83F', '2025-06-03 12:07:12.708504', '2025-06-03 12:07:12.708504', 0, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645924713383591917', 100001, '01030000A0E610000001000000080000009C8C5FB5E8535E4058647BFAF6363F400000008018BEF53FAA882E03E9535E40BE2A4FD4DD363F40000000A0B8E3F83F2689D956E9535E40887A15A7C7363F400000000053CDFA3F2689D956E9535E40887A15A7C7363F400000000053CDFA3FE720BA30EA535E409A31B624C8363F40000000A0420AFD3FD16149AFE9535E4080AB5B8EEE363F4000000020C579FB3F59F2A692E9535E40B7E57728F7363F40000000602F22FB3F9C8C5FB5E8535E4058647BFAF6363F400000008018BEF53F', '2025-06-03 09:48:57.325291', '2025-06-03 09:48:57.325291', 99, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645924713383591832', 100001, '01030000A0E6100000010000001D0000002E3456E9EE535E40CC959F26C3363F40000000601F2BF83F538FE370EE535E409644056DC3363F40000000C0AEEDF93F6B724232EE535E4066701FAFC3363F40000000201554F83F1D34510AEE535E40D1CB9AEBC3363F40000000601F2BF83F8F79D3E3ED535E40D1853035C4363F40000000A02902F83FD1C81FC0ED535E40A7CAF78CC4363F4000000040C39BF93FF0F2A79FED535E4095174FF3C4363F40000000C0485AFA3FEDF76B82ED535E4018213268C5363F400000006067DFF93FC8D76B68ED535E40367EA9EBC5363F40000000002AD5FA3FE9AA8048ED535E40176E8EADC6363F40000000C0F6A1F73F856C6531ED535E40E74A5D62C7363F40000000C02069F73FD1C2DA22ED535E40400D8409C8363F40000000403517F73FFB5E271BED535E4064180D9FC8363F4000000060BA02F93FD91F0F1AED535E406FB06A22C9363F4000000080ED35F83FA736031FED535E4069A14BD5C9363F40000000803FEEFA3FA736031FED535E4069A14BD5C9363F40000000803FEEFA3F0D6CF88AEC535E40C321F37FC9363F40000000E0CEB0F83F9FD9B58AEC535E406F403773C9363F40000000E0CEB0F83F043FB98CEC535E405E7F082DC8363F4000000000D987F83F5D2F439FEC535E408EB3FDECC6363F4000000060B997F83FE8DBC4C1EC535E40423DD6BCC5363F40000000E0A4E9F83F68AF2FF3EC535E40DD57CCA5C4363F40000000A09A12F93F73560432ED535E4043445DB0C3363F40000000A09A12F93F98435A7CED535E4019AEF7E3C2363F40000000E0A4E9F83F86CAEFCFED535E40B44FD946C2363F40000000006F1EF93F5928392AEE535E40DEA2C1DDC1363F400000008083CCF83FCC357988EE535E4050FEE4ABC1363F400000004079F5F83F4195D2E7EE535E409739CAB2C1363F400000008083CCF83F2E3456E9EE535E40CC959F26C3363F40000000601F2BF83F', '2025-06-03 10:22:14.478887', '2025-06-03 10:22:14.478887', 0, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645924713383591809', 100001, '01030000A0E61000000100000009000000B7B2C3E6E3535E40C73EC6B1B5363F40000000803DCAF83F3B5684F6E5535E407FB444D6B6363F4000000020299BF83F9E66EB5AE7535E40CCA0359AB7363F40000000A04BB1F83FDB2EBDC8E7535E40079268E3B7363F40000000203703F93FDB2EBDC8E7535E40079268E3B7363F40000000203703F93FF830F59FE7535E40D5695BCFBB363F40000000C0DB98F93F07A7E21FE6535E404D8356EBBA363F40000000C069E4F93FFA4C2BC2E3535E405AD63AC7B9363F4000000000EFDDF83FB7B2C3E6E3535E40C73EC6B1B5363F40000000803DCAF83F', '2025-06-03 10:28:42.347648', '2025-06-03 10:28:42.347648', 0, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645782395347271668', 100001, '01030000A0E6100000010000000800000058771F8CE7535E40B1AA8EB7BD363F40000000A0DA27F83F66776285E4535E409AE90827BC363F400000006072F9F73F997A7DB0E3535E40F30160C0BB363F40000000402211F83F997A7DB0E3535E40F30160C0BB363F40000000402211F83FFA4C2BC2E3535E405AD63AC7B9363F4000000000EFDDF83F07A7E21FE6535E404D8356EBBA363F40000000C069E4F93FF830F59FE7535E40D5695BCFBB363F40000000C0DB98F93F58771F8CE7535E40B1AA8EB7BD363F40000000A0DA27F83F', '2025-06-03 11:17:23.297305', '2025-06-03 11:17:23.297305', 0, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645924713383591797', 100001, '01030000A0E610000001000000070000005FB2C6E0EE535E400B6EF7B4BB363F40000000C09911F83F2CADAA8AF5535E4074031C7ABF363F40000000001DD8F73F2CADAA8AF5535E4074031C7ABF363F40000000001DD8F73F07129A78F5535E40D32E976EC1363F4000000080082AF83F936DBA47F1535E406FC53D17BF363F40000000A064ABF83F4618B3E3EE535E40C3E76DBDBD363F40000000405099F93F5FB2C6E0EE535E400B6EF7B4BB363F40000000C09911F83F', '2025-06-03 10:46:22.374582', '2025-06-03 10:46:22.374582', 0, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645924713383591805', 100001, '01030000A0E6100000010000000A0000001737084FF5535E4077EBE33EC5363F40000000009A1EF73F0FB661DFF1535E4072382D57C3363F400000002087BAF73FF419717DEF535E40910B10FDC1363F40000000C09F3EF83F4195D2E7EE535E409739CAB2C1363F400000008083CCF83F4195D2E7EE535E409739CAB2C1363F400000008083CCF83F0C7A2DF0EE535E40409C69BDBD363F400000000046C2F93F60CD31BBEF535E403470542FBE363F40000000406234F93F434DAB23F2535E402D4ADB88BF363F40000000A07D9EF83FC8417B88F5535E407901847CC1363F4000000080082AF83F1737084FF5535E4077EBE33EC5363F40000000009A1EF73F', '2025-06-03 10:44:35.345879', '2025-06-03 10:44:35.345879', 99, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645924713383591794', 100001, '01030000A0E610000001000000090000001737084FF5535E4077EBE33EC5363F40000000009A1EF73F0FB661DFF1535E4072382D57C3363F400000002087BAF73FF419717DEF535E40910B10FDC1363F40000000C09F3EF83F4195D2E7EE535E409739CAB2C1363F400000008083CCF83F4195D2E7EE535E409739CAB2C1363F400000008083CCF83F4618B3E3EE535E40C3E76DBDBD363F40000000405099F93F936DBA47F1535E406FC53D17BF363F40000000A064ABF83F07129A78F5535E40D32E976EC1363F4000000080082AF83F1737084FF5535E4077EBE33EC5363F40000000009A1EF73F', '2025-06-03 10:46:31.851493', '2025-06-03 10:46:31.851493', 0, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645924713383591928', 100001, '01030000A0E61000000100000009000000045F7DAEE9535E403AA9412EF7363F40000000E043D0F63FF6F378EAE9535E404FA2F354E6363F40000000400037F73F9011AE52EA535E40AB6B4A38C8363F40000000E04CE1F83F9011AE52EA535E40AB6B4A38C8363F40000000E04CE1F83F6B964F7FEB535E404CBA9DE5C8363F4000000040DE00FA3F3A348045EB535E40EAFC763AD9363F40000000E045DFF83F034B1D00EB535E40BCE249D5ED363F400000000075B5F83F79B8EFE1EA535E400431296EF7363F400000008030F0F73F045F7DAEE9535E403AA9412EF7363F40000000E043D0F63F', '2025-06-03 14:43:46.012562', '2025-06-03 14:43:46.012562', 99, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645924713383591923', 100001, '01030000A0E6100000010000000B000000B81D3B24EC535E40349AB544C9363F40000000C0C952FA3F71CB4C0BEC535E40A8BCB8B5CE363F40000000400A5EF83FADF176DDEB535E40BFB8C141DC363F40000000A0B1EFF73F794AB8A4EB535E40E0173EF2EC363F40000000A0A973F73FA5FA9685EB535E4016172B90F7363F40000000800794F83FA5FA9685EB535E4016172B90F7363F40000000800794F83F0CDC63E4EA535E40F8EF5787F7363F40000000402619F83F976E9102EB535E40B0A178EEED363F400000000075B5F83FCE57F447EB535E40DEBBA553D9363F400000002050B6F83FFFB9C381EB535E404079CCFEC8363F4000000040DE00FA3FB81D3B24EC535E40349AB544C9363F40000000C0C952FA3F', '2025-06-03 14:44:15.833389', '2025-06-03 14:44:15.833389', 99, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645782395347271651', 100001, '01030000A0E61000000100000006000000DB2EBDC8E7535E40079268E3B7363F40000000203703F93F5FB2C6E0EE535E400B6EF7B4BB363F40000000C09911F83F5FB2C6E0EE535E400B6EF7B4BB363F40000000C09911F83F4618B3E3EE535E40C3E76DBDBD363F40000000405099F93F8C14FFB4E7535E40DC2E69C9B9363F4000000000BD13FA3FDB2EBDC8E7535E40079268E3B7363F40000000203703F93F', '2025-06-03 12:07:49.658452', '2025-06-03 12:07:49.658452', 0, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645782395347271632', 100001, '01030000A0E61000000100000006000000C2022D97EC535E40F9BA6F29A5363F4000000020D5A1FA3F3D956E73EC535E404C381ADEB1363F4000000000E9D4FB3F3D956E73EC535E404C381ADEB1363F4000000000E9D4FB3F89237727EB535E40F3178235B1363F4000000020DB16FA3F52C1FF5BEB535E40D54549C9A4363F4000000000E9F0FA3FC2022D97EC535E40F9BA6F29A5363F4000000020D5A1FA3F', '2025-06-03 12:16:28.2604', '2025-06-03 12:16:28.2604', 0, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645782395347271628', 100001, '01030000A0E610000001000000060000007C2C4085EA535E4058821DE3B0363F40000000605327FE3FEC3465B6EA535E405220C596A4363F40000000201CFAFD3FEC3465B6EA535E405220C596A4363F40000000201CFAFD3F52C1FF5BEB535E40D54549C9A4363F4000000000E9F0FA3F89237727EB535E40F3178235B1363F4000000020DB16FA3F7C2C4085EA535E4058821DE3B0363F40000000605327FE3F', '2025-06-03 12:16:37.518817', '2025-06-03 12:16:37.518817', 0, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645782395347271611', 100001, '01030000A0E61000000100000017000000DB2EBDC8E7535E40079268E3B7363F40000000203703F93FE85BE92CE8535E40AE6BE90EB8363F40000000A047FEF83FF0A0C591E8535E40A28440FEB7363F40000000E02879F93F311641F4E8535E403DB6EEB1B7363F40000000200AF4F93FD9145D51E9535E4019B5442CB7363F40000000200AF4F93F13FC46A6E9535E4008E35171B6363F4000000040F63AFA3F145F69F0E9535E40F6F2C186B5363F40000000800012FA3F8D91822DEA535E405CD8BE73B4363F40000000800012FA3F540EB95BEA535E40FEE09A40B3363F400000002072ACF93F700EA479EA535E40520DAAF6B1363F40000000E09031F93F3E524285EA535E4058821DE3B0363F40000000605327FE3F3E524285EA535E4058821DE3B0363F40000000605327FE3F89237727EB535E40F3178235B1363F4000000020DB16FA3F94265711EB535E405D81D465B2363F40000000A0C668FA3F672AC9DCEA535E409E9ED21CB4363F40000000A03A5DFA3FB666BE92EA535E409DB2EEADB5363F4000000080D7B5FA3FD1877835EA535E40674CF60CB7363F4000000000EC63FA3F6E41CBC7E9535E4096D23D2FB8363F40000000C0E18CFA3F7B330C4DE9535E408F69F60BB9363F40000000A02D35FA3F50FFF6C8E8535E40AD146A9CB9363F40000000E0370CFA3F34248E3FE8535E4065D737DCB9363F40000000604CBAF93F8C14FFB4E7535E40DC2E69C9B9363F4000000000BD13FA3FDB2EBDC8E7535E40079268E3B7363F40000000203703F93F', '2025-06-03 14:10:31.500114', '2025-06-03 14:10:31.501112', 0, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645782395347271606', 100001, '01030000A0E6100000010000001700000040BD0FC3EB535E40B7638784B1363F4000000060BC91FA3FD32A37A7EB535E40EB0ABDCBB3363F4000000060BC91FA3FCE92306EEB535E4002D287F9B5363F40000000A01101FB3FC269B719EB535E404365FEFCB7363F40000000A01101FB3FF8D05CACEA535E40CBAD6CC6B9363F40000000E05300FB3FBC2F7329EA535E40FF06F747BB363F40000000205ED7FA3F516EF494E9535E40BDF6DE75BC363F40000000A07285FA3F38F864F3E8535E402824F746BD363F40000000A05691F93FB701AC49E8535E405D5BECB4BD363F40000000E00DF7F83FA13EF29CE7535E400A9E63BCBD363F40000000A0DA27F83F58771F8CE7535E40B74197B7BD363F40000000A0DA27F83F58771F8CE7535E40B74197B7BD363F40000000A0DA27F83FF830F59FE7535E40531E57CFBB363F40000000C0DB98F93F9A0A381EE8535E401DECA8C5BB363F40000000604CBAF93F2AA105B2E8535E40472F1C68BB363F40000000A02D35FA3F414AD53EE9535E4012A92CB4BA363F40000000201987FA3F88BB5EC0E9535E40C5364EAFB9363F400000006068AEFA3FA4B6B132EA535E4066F47861B8363F4000000080D7B5FA3F6F525792EA535E4079BFCAD4B6363F4000000080D7B5FA3FC24E65DCEA535E4056614F15B5363F40000000E01BD8FA3FF0379D0EEB535E406F5DA630B3363F4000000060BC91FA3F89237727EB535E40F3178235B1363F4000000020DB16FA3F40BD0FC3EB535E40B7638784B1363F4000000060BC91FA3F', '2025-06-03 14:10:56.682999', '2025-06-03 14:10:56.682999', 0, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645782395347271601', 100001, '01030000A0E610000001000000190000003D956E73EC535E404C381ADEB1363F4000000000E9D4FB3FE581196AEC535E4092B77A53B3363F40000000A0826EF93FA92DDD73EC535E404426BDC8B4363F40000000A01598F93F355C6D90EC535E4002D38532B6363F40000000E01F6FF93FCEC9EBBEEC535E40AE89D785B7363F40000000A01598F93F9A9CEEFDEC535E40A1E260B8B8363F40000000201F8AF93F64218B4BED535E406B74D6C0B9363F40000000803338F93FACF966A5ED535E4077A92A97BA363F40000000405C07F93F0B11C608EE535E40C45ADF34BB363F40000000C070B5F83F4A62A472EE535E407CE02395BB363F40000000007B8CF83F2F4BC9DFEE535E401D3311B5BB363F40000000808F3AF83F5FB2C6E0EE535E409AE70CB5BB363F40000000C09911F83F5FB2C6E0EE535E409AE70CB5BB363F40000000C09911F83F4618B3E3EE535E40463372BDBD363F40000000405099F93F2496CC65EE535E406FFCD2A0BD363F40000000405099F93FD80F49DEED535E404C8AF732BD363F40000000E01EFDF93F18E5695EED535E4088564A76BC363F40000000600005FA3F33260EEAEC535E409AF68370BB363F4000000020F62DFA3FDF35C284EC535E4083EF9329BA363F4000000020CDD1FA3FDBFB9631EC535E40ADC275ABB8363F400000002026AFFA3F491516F3EB535E409CABB801B7363F40000000A03A5DFA3F19C423CBEB535E40CDAC5439B5363F40000000603086FA3FC47DF8BAEB535E40571F2160B3363F4000000060BC91FA3F40BD0FC3EB535E40B7638784B1363F4000000060BC91FA3F3D956E73EC535E404C381ADEB1363F4000000000E9D4FB3F', '2025-06-03 14:12:02.826413', '2025-06-03 14:12:02.826413', 0, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645782395347271589', 100001, '01030000A0E61000000100000015000000534DC2E5EE535E408634CFB6BF363F40000000C03BEBF93FA5B5A116EE535E409229F149BF363F40000000C03BEBF93F7B9D2D50ED535E407BBCAC63BE363F400000006074C7FA3F60FC6C98EC535E401C39050BBD363F40000000A0B823FB3FB50BF6F4EB535E40B8AE724ABB363F4000000000088AFB3F0B08BF6AEB535E4042EC982FB9363F40000000801C38FB3FEAE7FCFDEA535E400E3ECFCAB6363F40000000A01101FB3F5DA1FBB1EA535E408659B92EB4363F4000000000EC63FA3FFEE80B89EA535E404073A86FB1363F4000000000EDC0FB3F7C2C4085EA535E4058821DE3B0363F40000000605327FE3F7C2C4085EA535E4058821DE3B0363F40000000605327FE3FC8FD7427EB535E40F3178235B1363F4000000020DB16FA3F7D4D4144EB535E40B0ADF045B3363F40000000A0C668FA3F15CBCA82EB535E40A3189A97B5363F40000000E01BD8FA3F276183DEEB535E40137813BBB7363F400000002026AFFA3FC418A254EC535E400013C59FB9363F40000000A0E17FFA3F90BF8EE1EC535E402F57EB36BB363F4000000020F62DFA3FF3300381ED535E408EE02874BC363F40000000201F8AF93F311B252EEE535E40F2AAE04DBD363F400000000029D4F93F4618B3E3EE535E40C3E76DBDBD363F40000000405099F93F534DC2E5EE535E408634CFB6BF363F40000000C03BEBF93F', '2025-06-03 14:14:56.524832', '2025-06-03 14:14:56.524832', 0, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645782395347271580', 100001, '01030000A0E610000001000000180000009011AE52EA535E40AB6B4A38C8363F40000000E04CE1F83F791AFB55EA535E40E1E0684DC7363F40000000402E5CF93F2FD1194BEA535E408964FDA3C5363F4000000000A091F93FAAC8CA2AEA535E4025087D07C4363F4000000040AA68F93F5A4209F6E9535E40EAB97884C2363F4000000040AA68F93F9A696FAEE9535E40F65CA626C1363F40000000E09C27F93F0D842A56E9535E40B08AB1F8BF363F400000002018CEF83FAEB0E8EFE8535E40EC04BF03BF363F400000002018CEF83FE5A6C67EE8535E40570E464FBE363F400000002018CEF83FD4B83206E8535E40BDCFBEE0BD363F40000000E03653F83FA13EF29CE7535E408DE967BCBD363F40000000A0DA27F83FA13EF29CE7535E408DE967BCBD363F40000000A0DA27F83FF830F59FE7535E40D0D252CFBB363F40000000C0DB98F93FED966300E8535E4005BB4DF7BB363F40000000604CBAF93F3CCA2698E8535E4070996B82BC363F40000000604CBAF93F2C538C26E9535E405E299165BD363F40000000604CBAF93FDF043FA7E9535E400A7BDD99BE363F40000000A069F4F93FDF4A5816EA535E40F15FEB15C0363F40000000605F1DFA3F94B57670EA535E40973334CEC1363F40000000A069F4F93FB91DDDB2EA535E40B49354B5C3363F40000000A06287FA3F080B87DBEA535E40065780BCC5363F4000000040EC53FA3F66CF38E9EA535E40A038F2D3C7363F40000000C0C952FA3F42E793E7EA535E40ABC4238EC8363F40000000C0C952FA3F9011AE52EA535E40AB6B4A38C8363F40000000E04CE1F83F', '2025-06-03 14:17:23.86074', '2025-06-03 14:17:23.86074', 0, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645782395347271577', 100001, '01030000A0E610000001000000060000009011AE52EA535E40AB6B4A38C8363F40000000E04CE1F83F3E524285EA535E4058821DE3B0363F40000000605327FE3F3E524285EA535E4058821DE3B0363F40000000605327FE3F89237727EB535E40F3178235B1363F4000000020DB16FA3F42E793E7EA535E40ABC4238EC8363F40000000C0C952FA3F9011AE52EA535E40AB6B4A38C8363F40000000E04CE1F83F', '2025-06-03 14:17:30.08713', '2025-06-03 14:17:30.08713', 0, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645924713383591920', 100001, '01030000A0E61000000100000007000000A736031FED535E4069A14BD5C9363F40000000803FEEFA3F29D33581EC535E4058CC7AC4F7363F4000000040A04FFC3F29D33581EC535E4058CC7AC4F7363F4000000040A04FFC3F5EDB01F5EB535E40A57056A7F7363F400000002078D1FA3FE5331D5DEC535E40157CC6CAD7363F40000000A0EC3BF83F71CAFD8AEC535E40C321F37FC9363F40000000E0CEB0F83FA736031FED535E4069A14BD5C9363F40000000803FEEFA3F', '2025-06-03 14:25:39.766637', '2025-06-03 14:25:39.766637', 99, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645924713383591913', 100001, '01030000A0E610000001000000070000009C8C5FB5E8535E4058647BFAF6363F400000008018BEF53FAA882E03E9535E40BE2A4FD4DD363F40000000A0B8E3F83F2689D956E9535E40887A15A7C7363F400000000053CDFA3F2689D956E9535E40887A15A7C7363F400000000053CDFA3FB9B5DDE8E9535E40ED83A319C8363F4000000000D2CCFA3F4A74C94AE9535E402294871DF7363F40000000606A76F83F9C8C5FB5E8535E4058647BFAF6363F400000008018BEF53F', '2025-06-03 14:25:40.366508', '2025-06-03 14:25:40.366508', 99, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645782395347271274', 100001, '01030000A0E61000000100000009000000045F7DAEE9535E403AA9412EF7363F40000000E043D0F63FF6F378EAE9535E404FA2F354E6363F40000000400037F73F8B737B19EA535E40AFE07CBFD8363F40000000C062F8F73F8B737B19EA535E40AFE07CBFD8363F40000000C062F8F73FEDE68146EB535E40DEC388F1D8363F40000000E045DFF83F3A348045EB535E40EAFC763AD9363F40000000E045DFF83F034B1D00EB535E40BCE249D5ED363F400000000075B5F83F79B8EFE1EA535E400431296EF7363F400000008030F0F73F045F7DAEE9535E403AA9412EF7363F40000000E043D0F63F', '2025-06-03 15:48:12.1448', '2025-06-03 15:48:12.1448', 99, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645782395347271278', 100001, '01030000A0E610000001000000060000008B737B19EA535E40AFE07CBFD8363F40000000C062F8F73F9011AE52EA535E40AB6B4A38C8363F40000000E04CE1F83F9011AE52EA535E40AB6B4A38C8363F40000000E04CE1F83F6B964F7FEB535E404CBA9DE5C8363F4000000040DE00FA3FEDE68146EB535E40DEC388F1D8363F40000000E045DFF83F8B737B19EA535E40AFE07CBFD8363F40000000C062F8F73F', '2025-06-03 15:48:12.728072', '2025-06-03 15:48:12.728072', 99, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645782395347271270', 100001, '01030000A0E6100000010000000A000000B2C951E8EB535E4002996D0CD9363F400000004083E9F73FADF176DDEB535E40BFB8C141DC363F40000000A0B1EFF73F794AB8A4EB535E40E0173EF2EC363F40000000A0A973F73FA5FA9685EB535E4016172B90F7363F40000000800794F83FA5FA9685EB535E4016172B90F7363F40000000800794F83F0CDC63E4EA535E40F8EF5787F7363F40000000402619F83F976E9102EB535E40B0A178EEED363F400000000075B5F83FCE57F447EB535E40DEBBA553D9363F400000002050B6F83F7D164E49EB535E40AFBAFCF1D8363F40000000E045DFF83FB2C951E8EB535E4002996D0CD9363F400000004083E9F73F', '2025-06-03 15:48:13.31014', '2025-06-03 15:48:13.31014', 99, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645782395347271598', 100001, '01030000A0E610000001000000060000003D956E73EC535E404C381ADEB1363F4000000000E9D4FB3F93993324EC535E40B14EB144C9363F40000000C0C952FA3F93993324EC535E40B14EB144C9363F40000000C0C952FA3F2E720882EB535E40D54B63E6C8363F4000000040DE00FA3F40BD0FC3EB535E40B7638784B1363F4000000060BC91FA3F3D956E73EC535E404C381ADEB1363F4000000000E9D4FB3F', '2025-06-03 17:46:16.096478', '2025-06-03 17:46:16.096478', 99, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645782395347271267', 100001, '01030000A0E61000000100000007000000B81D3B24EC535E40349AB544C9363F40000000C0C952FA3F71CB4C0BEC535E40A8BCB8B5CE363F40000000400A5EF83FB2C951E8EB535E4002996D0CD9363F400000004083E9F73FB2C951E8EB535E4002996D0CD9363F400000004083E9F73F7D164E49EB535E40AFBAFCF1D8363F40000000E045DFF83F6D4C0682EB535E40D54B63E6C8363F4000000040DE00FA3FB81D3B24EC535E40349AB544C9363F40000000C0C952FA3F', '2025-06-03 15:48:13.891004', '2025-06-03 15:48:13.891004', 99, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645275692285558769', 100001, '01030000A0E61000000100000009000000045F7DAEE9535E403AA9412EF7363F40000000E043D0F63FF6F378EAE9535E404FA2F354E6363F40000000400037F73F8B737B19EA535E40AFE07CBFD8363F40000000C062F8F73F8B737B19EA535E40AFE07CBFD8363F40000000C062F8F73FEDE68146EB535E40DEC388F1D8363F40000000E045DFF83F3A348045EB535E40EAFC763AD9363F40000000E045DFF83F034B1D00EB535E40BCE249D5ED363F400000000075B5F83F79B8EFE1EA535E400431296EF7363F400000008030F0F73F045F7DAEE9535E403AA9412EF7363F40000000E043D0F63F', '2025-06-03 16:22:36.14651', '2025-06-03 16:22:36.14651', 99, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645275692285558761', 100001, '01030000A0E6100000010000000A000000B2C951E8EB535E4002996D0CD9363F400000004083E9F73FADF176DDEB535E40BFB8C141DC363F40000000A0B1EFF73F794AB8A4EB535E40E0173EF2EC363F40000000A0A973F73FA5FA9685EB535E4016172B90F7363F40000000800794F83FA5FA9685EB535E4016172B90F7363F40000000800794F83F0CDC63E4EA535E40F8EF5787F7363F40000000402619F83F976E9102EB535E40B0A178EEED363F400000000075B5F83FCE57F447EB535E40DEBBA553D9363F400000002050B6F83F7D164E49EB535E40AFBAFCF1D8363F40000000E045DFF83FB2C951E8EB535E4002996D0CD9363F400000004083E9F73F', '2025-06-03 16:22:36.777103', '2025-06-03 16:22:36.777103', 99, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645275692285558765', 100001, '01030000A0E610000001000000060000008B737B19EA535E40AFE07CBFD8363F40000000C062F8F73F9011AE52EA535E40AB6B4A38C8363F40000000E04CE1F83F9011AE52EA535E40AB6B4A38C8363F40000000E04CE1F83F6B964F7FEB535E404CBA9DE5C8363F4000000040DE00FA3FEDE68146EB535E40DEC388F1D8363F40000000E045DFF83F8B737B19EA535E40AFE07CBFD8363F40000000C062F8F73F', '2025-06-03 16:22:37.404716', '2025-06-03 16:22:37.404716', 99, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645275692285558758', 100001, '01030000A0E61000000100000007000000B81D3B24EC535E40349AB544C9363F40000000C0C952FA3F71CB4C0BEC535E40A8BCB8B5CE363F40000000400A5EF83FB2C951E8EB535E4002996D0CD9363F400000004083E9F73FB2C951E8EB535E4002996D0CD9363F400000004083E9F73F7D164E49EB535E40AFBAFCF1D8363F40000000E045DFF83F6D4C0682EB535E40D54B63E6C8363F4000000040DE00FA3FB81D3B24EC535E40349AB544C9363F40000000C0C952FA3F', '2025-06-03 16:22:38.034383', '2025-06-03 16:22:38.035638', 99, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645046787708551168', 100001, '01030000A0E61000000100000008000000045F7DAEE9535E403AA9412EF7363F40000000E043D0F63FF6F378EAE9535E404FA2F354E6363F40000000400037F73F8B737B19EA535E40AFE07CBFD8363F40000000C062F8F73F8B737B19EA535E40AFE07CBFD8363F40000000C062F8F73F7D164E49EB535E40AFBAFCF1D8363F40000000E045DFF83F034B1D00EB535E40BCE249D5ED363F400000000075B5F83F79B8EFE1EA535E400431296EF7363F400000008030F0F73F045F7DAEE9535E403AA9412EF7363F40000000E043D0F63F', '2025-06-03 16:54:44.188495', '2025-06-03 16:54:44.188495', 0, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645046787708551160', 100001, '01030000A0E61000000100000009000000B2C951E8EB535E4002996D0CD9363F400000004083E9F73FADF176DDEB535E40BFB8C141DC363F40000000A0B1EFF73F794AB8A4EB535E40E0173EF2EC363F40000000A0A973F73FA5FA9685EB535E4016172B90F7363F40000000800794F83FA5FA9685EB535E4016172B90F7363F40000000800794F83F0CDC63E4EA535E40F8EF5787F7363F40000000402619F83F976E9102EB535E40B0A178EEED363F400000000075B5F83FA7615342EB535E405ACF6EFFDA363F40000000006A0EF93FB2C951E8EB535E4002996D0CD9363F400000004083E9F73F', '2025-06-03 16:56:47.629003', '2025-06-03 16:56:47.629003', 99, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645046787708551157', 100001, '01030000A0E61000000100000009000000B2C951E8EB535E4002996D0CD9363F400000004083E9F73FADF176DDEB535E40BFB8C141DC363F40000000A0B1EFF73F794AB8A4EB535E40E0173EF2EC363F40000000A0A973F73FA5FA9685EB535E4016172B90F7363F40000000800794F83FA5FA9685EB535E4016172B90F7363F40000000800794F83F0CDC63E4EA535E40F8EF5787F7363F40000000402619F83F976E9102EB535E40B0A178EEED363F400000000075B5F83F7D164E49EB535E40AFBAFCF1D8363F40000000E045DFF83FB2C951E8EB535E4002996D0CD9363F400000004083E9F73F', '2025-06-03 16:57:13.917956', '2025-06-03 16:57:13.917956', 0, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645924713383591841', 100001, '01030000A0E6100000010000001700000042E793E7EA535E40ABC4238EC8363F40000000C0C952FA3FCC3B3AEDEA535E408FF8696AC6363F4000000040EC53FA3F8CD9970EEB535E408A785D52C4363F4000000000E27CFA3FEEFAA94AEB535E4067AE4856C2363F4000000080A472FB3F2E799C9FEB535E4056AD9685C0363F40000000E09E59FB3F62FADA0AEC535E40276970EEBE363F40000000E0C7B5FA3F68322389EC535E40E6AE2A9DBD363F40000000A05542FB3FF6A79E16ED535E40B1030A9CBC363F4000000020CDD1FA3F14D801AFED535E40F3DBDFF2BB363F400000004033ABF93FAA46AA4DEE535E40B82ECAA6BB363F40000000007B8CF83F5FB2C6E0EE535E400B6EF7B4BB363F40000000C09911F83F5FB2C6E0EE535E400B6EF7B4BB363F40000000C09911F83F4618B3E3EE535E40C3E76DBDBD363F40000000405099F93F8A7A936FEE535E40690857D8BD363F40000000405099F93F0EA3B3DBED535E40FE1A714ABE363F400000008008B8FA3F8428DE4FED535E403FF3A412BF363F400000006074C7FA3F5DAB51D0EC535E407A15E42AC0363F400000006074C7FA3FAB61EF60EC535E40445EA48AC1363F40000000A07E9EFA3F04BB1805EC535E40B4E83527C3363F4000000080F62AFA3F39C197BFEB535E401EA914F4C4363F4000000040EC53FA3F9FB18A92EB535E40CA073AE3C6363F4000000080F62AFA3F6B964F7FEB535E404CBA9DE5C8363F4000000040DE00FA3F42E793E7EA535E40ABC4238EC8363F40000000C0C952FA3F', '2025-06-03 17:46:14.228373', '2025-06-03 17:46:14.228373', 99, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645782395347271657', 100001, '01030000A0E6100000010000001A0000008C14FFB4E7535E40DC2E69C9B9363F4000000000BD13FA3F188DF16BE8535E403CF039C9B9363F400000002042E3F93F385A1F20E9535E406B32B535BA363F4000000060235EFA3F622D0ECCE9535E40A670950BBB363F40000000205ED7FA3F9537856AEA535E40ED835C44BC363F40000000205ED7FA3FFDD0B3F6EA535E40A5E182D6BD363F4000000020A930FB3F8620586CEB535E4056CDD1B5BF363F40000000A0BDDEFA3F742CDDC7EB535E40EA3EB9D3C1363F4000000060B307FB3F7B367D06EC535E40FB24C81FC4363F40000000C00002FA3F29B14F26EC535E40A0C41788C6363F40000000E03335F93F1369552AEC535E40C3AB1CC2C7363F400000000026E2F83FB81D3B24EC535E40349AB544C9363F40000000C0C952FA3FB81D3B24EC535E40349AB544C9363F40000000C0C952FA3F6B964F7FEB535E404CBA9DE5C8363F4000000040DE00FA3FFDB2C57FEB535E4010204880C8363F4000000040DE00FA3FFFFDE07EEB535E40DB834DF3C7363F4000000000D429FA3F49844B69EB535E40D66748C1C5363F4000000000E27CFA3F88338237EB535E401FCA9EA4C3363F4000000080CDCEFA3F88BD09EBEA535E409770BDADC1363F40000000A0BDDEFA3FE4D63286EA535E405612EDEBBF363F400000006036C1FA3F3E7A0F0CEA535E405715DA6CBE363F40000000E04A6FFA3F87EA5580E9535E4028E3243CBD363F40000000208733FA3F50B543E7E8535E40B7991463BC363F40000000E0370CFA3F33A27F45E8535E4094D93CE8BB363F40000000604CBAF93FF830F59FE7535E40D5695BCFBB363F40000000C0DB98F93F8C14FFB4E7535E40DC2E69C9B9363F4000000000BD13FA3F', '2025-06-03 17:46:14.862999', '2025-06-03 17:46:14.862999', 99, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645924713383591835', 100001, '01030000A0E610000001000000180000004195D2E7EE535E409739CAB2C1363F400000008083CCF83FBA73AA7AEE535E403EA7B1A1C1363F400000008083CCF83F3F2F4C0EEE535E407F42ADD1C1363F400000004079F5F83FD8BD03A6ED535E4061445441C2363F40000000006F1EF93F58CCFB44ED535E4084803AEDC2363F40000000E0A4E9F83F0A1F26EEEC535E40CB3A28D0C3363F40000000A09A12F93F012B27A4EC535E40EF3738E3C4363F40000000208664F93FAE893F69EC535E4024930F1EC6363F40000000A09A12F93F4C7F363FEC535E4047DF1977C7363F4000000020B02BF93F5FAF5527EC535E409958E3E3C8363F4000000000ABCDFA3F93993324EC535E40B14EB144C9363F40000000C0C952FA3F93993324EC535E40B14EB144C9363F40000000C0C952FA3F2E720882EB535E40D54B63E6C8363F4000000040DE00FA3F61BD388EEB535E40A08ED17EC7363F4000000000D429FA3FE4D8DDB0EB535E408FEFD9DAC5363F4000000080F62AFA3F2F7E4DE8EB535E40AD53D851C4363F4000000080F62AFA3F3A1BD932EC535E4043BFBEEFC2363F4000000000E27CFA3F10CB3B8EEC535E4044454EBFC1363F4000000020934CFA3F85BCAEF7EC535E40976CC5C9C0363F40000000A0A7FAF93FC2ABFE6BED535E406EC39F16C0363F40000000E08875FA3FB36EA2E7ED535E40099048ABBF363F40000000C03BEBF93FBDF2D766EE535E402D57058BBF363F40000000C03BEBF93F534DC2E5EE535E408634CFB6BF363F40000000C03BEBF93F4195D2E7EE535E409739CAB2C1363F400000008083CCF83F', '2025-06-03 17:46:15.482467', '2025-06-03 17:46:15.482467', 99, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645046787708551164', 100001, '01030000A0E610000001000000060000008B737B19EA535E40AFE07CBFD8363F40000000C062F8F73F9011AE52EA535E40AB6B4A38C8363F40000000E04CE1F83F9011AE52EA535E40AB6B4A38C8363F40000000E04CE1F83F6B964F7FEB535E404CBA9DE5C8363F4000000040DE00FA3FEDE68146EB535E40DEC388F1D8363F40000000E045DFF83F8B737B19EA535E40AFE07CBFD8363F40000000C062F8F73F', '2025-06-03 17:47:10.413203', '2025-06-03 17:47:10.413203', 99, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8645046787708551154', 100001, '01030000A0E61000000100000007000000B81D3B24EC535E40349AB544C9363F40000000C0C952FA3F71CB4C0BEC535E40A8BCB8B5CE363F40000000400A5EF83FB2C951E8EB535E4002996D0CD9363F400000004083E9F73FB2C951E8EB535E4002996D0CD9363F400000004083E9F73F7D164E49EB535E40AFBAFCF1D8363F40000000E045DFF83F6D4C0682EB535E40D54B63E6C8363F4000000040DE00FA3FB81D3B24EC535E40349AB544C9363F40000000C0C952FA3F', '2025-06-03 17:47:11.012707', '2025-06-03 17:47:11.012707', 99, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8644945289041412096', 100001, '01030000A0E610000001000000060000008B737B19EA535E40AFE07CBFD8363F40000000C062F8F73F9011AE52EA535E40AB6B4A38C8363F40000000E04CE1F83F9011AE52EA535E40AB6B4A38C8363F40000000E04CE1F83F2E720882EB535E40D54B63E6C8363F4000000040DE00FA3FEDE68146EB535E40DEC388F1D8363F40000000E045DFF83F8B737B19EA535E40AFE07CBFD8363F40000000C062F8F73F', '2025-06-03 17:47:43.177126', '2025-06-03 17:47:43.177126', 0, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8644945289041412092', 100001, '01030000A0E61000000100000007000000B81D3B24EC535E40349AB544C9363F40000000C0C952FA3F71CB4C0BEC535E40A8BCB8B5CE363F40000000400A5EF83FB2C951E8EB535E4002996D0CD9363F400000004083E9F73FB2C951E8EB535E4002996D0CD9363F400000004083E9F73F7D164E49EB535E40AFBAFCF1D8363F40000000E045DFF83F6D4C0682EB535E40D54B63E6C8363F4000000040DE00FA3FB81D3B24EC535E40349AB544C9363F40000000C0C952FA3F', '2025-06-03 17:47:53.875837', '2025-06-03 17:47:53.875837', 0, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8644945289041412089', 100001, '01030000A0E6100000010000001A0000008C14FFB4E7535E40DC2E69C9B9363F4000000000BD13FA3F188DF16BE8535E403CF039C9B9363F400000002042E3F93F385A1F20E9535E406B32B535BA363F4000000060235EFA3F622D0ECCE9535E40A670950BBB363F40000000205ED7FA3F9537856AEA535E40ED835C44BC363F40000000205ED7FA3FFDD0B3F6EA535E40A5E182D6BD363F4000000020A930FB3F8620586CEB535E4056CDD1B5BF363F40000000A0BDDEFA3F742CDDC7EB535E40EA3EB9D3C1363F4000000060B307FB3F7B367D06EC535E40FB24C81FC4363F40000000C00002FA3F29B14F26EC535E40A0C41788C6363F40000000E03335F93F1369552AEC535E40C3AB1CC2C7363F400000000026E2F83FB81D3B24EC535E40349AB544C9363F40000000C0C952FA3FB81D3B24EC535E40349AB544C9363F40000000C0C952FA3F6D4C0682EB535E40D54B63E6C8363F4000000040DE00FA3FFDB2C57FEB535E4010204880C8363F4000000040DE00FA3FFFFDE07EEB535E40DB834DF3C7363F4000000000D429FA3F49844B69EB535E40D66748C1C5363F4000000000E27CFA3F88338237EB535E401FCA9EA4C3363F4000000080CDCEFA3F88BD09EBEA535E409770BDADC1363F40000000A0BDDEFA3FE4D63286EA535E405612EDEBBF363F400000006036C1FA3F3E7A0F0CEA535E405715DA6CBE363F40000000E04A6FFA3F87EA5580E9535E4028E3243CBD363F40000000208733FA3F50B543E7E8535E40B7991463BC363F40000000E0370CFA3F33A27F45E8535E4094D93CE8BB363F40000000604CBAF93FF830F59FE7535E40D5695BCFBB363F40000000C0DB98F93F8C14FFB4E7535E40DC2E69C9B9363F4000000000BD13FA3F', '2025-06-03 17:48:05.02365', '2025-06-03 17:48:05.02365', 0, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8644945289041412086', 100001, '01030000A0E6100000010000001700000042E793E7EA535E40ABC4238EC8363F40000000C0C952FA3FCC3B3AEDEA535E408FF8696AC6363F4000000040EC53FA3F8CD9970EEB535E408A785D52C4363F4000000000E27CFA3FEEFAA94AEB535E4067AE4856C2363F4000000080A472FB3F2E799C9FEB535E4056AD9685C0363F40000000E09E59FB3F62FADA0AEC535E40276970EEBE363F40000000E0C7B5FA3F68322389EC535E40E6AE2A9DBD363F40000000A05542FB3FF6A79E16ED535E40B1030A9CBC363F4000000020CDD1FA3F14D801AFED535E40F3DBDFF2BB363F400000004033ABF93FAA46AA4DEE535E40B82ECAA6BB363F40000000007B8CF83F5FB2C6E0EE535E400B6EF7B4BB363F40000000C09911F83F5FB2C6E0EE535E400B6EF7B4BB363F40000000C09911F83F4618B3E3EE535E40C3E76DBDBD363F40000000405099F93F8A7A936FEE535E40690857D8BD363F40000000405099F93F0EA3B3DBED535E40FE1A714ABE363F400000008008B8FA3F8428DE4FED535E403FF3A412BF363F400000006074C7FA3F5DAB51D0EC535E407A15E42AC0363F400000006074C7FA3FAB61EF60EC535E40445EA48AC1363F40000000A07E9EFA3F04BB1805EC535E40B4E83527C3363F4000000080F62AFA3F39C197BFEB535E401EA914F4C4363F4000000040EC53FA3F9FB18A92EB535E40CA073AE3C6363F4000000080F62AFA3F6D4C0682EB535E40D54B63E6C8363F4000000040DE00FA3F42E793E7EA535E40ABC4238EC8363F40000000C0C952FA3F', '2025-06-03 17:48:13.135785', '2025-06-03 17:48:13.135785', 0, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8644945289041412083', 100001, '01030000A0E610000001000000180000004195D2E7EE535E409739CAB2C1363F400000008083CCF83FBA73AA7AEE535E403EA7B1A1C1363F400000008083CCF83F3F2F4C0EEE535E407F42ADD1C1363F400000004079F5F83FD8BD03A6ED535E4061445441C2363F40000000006F1EF93F58CCFB44ED535E4084803AEDC2363F40000000E0A4E9F83F0A1F26EEEC535E40CB3A28D0C3363F40000000A09A12F93F012B27A4EC535E40EF3738E3C4363F40000000208664F93FAE893F69EC535E4024930F1EC6363F40000000A09A12F93F4C7F363FEC535E4047DF1977C7363F4000000020B02BF93F5FAF5527EC535E409958E3E3C8363F4000000000ABCDFA3F93993324EC535E40B14EB144C9363F40000000C0C952FA3F93993324EC535E40B14EB144C9363F40000000C0C952FA3F2E720882EB535E40D54B63E6C8363F4000000040DE00FA3F61BD388EEB535E40A08ED17EC7363F4000000000D429FA3FE4D8DDB0EB535E408FEFD9DAC5363F4000000080F62AFA3F2F7E4DE8EB535E40AD53D851C4363F4000000080F62AFA3F3A1BD932EC535E4043BFBEEFC2363F4000000000E27CFA3F10CB3B8EEC535E4044454EBFC1363F4000000020934CFA3F85BCAEF7EC535E40976CC5C9C0363F40000000A0A7FAF93FC2ABFE6BED535E406EC39F16C0363F40000000E08875FA3FB36EA2E7ED535E40099048ABBF363F40000000C03BEBF93FBDF2D766EE535E402D57058BBF363F40000000C03BEBF93F534DC2E5EE535E408634CFB6BF363F40000000C03BEBF93F4195D2E7EE535E409739CAB2C1363F400000008083CCF83F', '2025-06-03 17:48:19.710003', '2025-06-03 17:48:19.710003', 0, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8644945289041412080', 100001, '01030000A0E610000001000000060000003D956E73EC535E404C381ADEB1363F4000000000E9D4FB3F93993324EC535E40B14EB144C9363F40000000C0C952FA3F93993324EC535E40B14EB144C9363F40000000C0C952FA3F2E720882EB535E40D54B63E6C8363F4000000040DE00FA3F40BD0FC3EB535E40B7638784B1363F4000000060BC91FA3F3D956E73EC535E404C381ADEB1363F4000000000E9D4FB3F', '2025-06-03 17:48:26.946036', '2025-06-03 17:48:26.946036', 0, '0', NULL, 1);
INSERT INTO public.lane_group VALUES ('8642101470935646109', 100001, '01030000A0E610000001000000110000008506E611F1535E40AE8BDD69AB363F4000000040E17AF4BF8506E611F1535E403F905490B3363F4000000040E17AF4BF7CD28904F3535E40213D1A8EB4363F4000000040E17AF4BF9DDAF3DEF3535E4050A0CE63B4363F4000000040E17AF4BFD0FA7556F4535E403F905490B3363F4000000040E17AF4BFFDC8F166F4535E40AB929805B2363F4000000040E17AF4BF1833106BF4535E40D7EBFC2CAD363F4000000040E17AF4BF5665E987F4535E401A297A31AB363F4000000040E17AF4BF5665E987F4535E401A297A31AB363F4000000040E17AF4BFE3216320F5535E40A2B4A94DAB363F4000000040E17AF4BFDF9E8224F5535E4072EC4DCAAC363F4000000040E17AF4BF8A856BFFF4535E40E578FB2FB4363F4000000040E17AF4BF87B64594F4535E4020E994C6B6363F4000000040E17AF4BFE98699C2F2535E402BC0C8E2B6363F4000000040E17AF4BFEA68EF68F0535E4050B1F049B5363F4000000040E17AF4BFB917935CF0535E40780005C3AB363F4000000040E17AF4BF8506E611F1535E40AE8BDD69AB363F4000000040E17AF4BF', '2025-06-04 16:56:00.787379', '2025-06-04 16:56:00.787379', 99, '1', NULL, 1);
INSERT INTO public.lane_group VALUES ('8642101470935646089', 100001, '01030000A0E610000001000000080000008506E611F1535E40AE8BDD69AB363F4000000040E17AF4BF8506E611F1535E403F905490B3363F4000000040E17AF4BFEC67D222F2535E4003993A1BB4363F4000000040E17AF4BFEC67D222F2535E4003993A1BB4363F4000000040E17AF4BF46342921F2535E40A3F51375B6363F4000000040E17AF4BFEA68EF68F0535E4050B1F049B5363F4000000040E17AF4BFB917935CF0535E40780005C3AB363F4000000040E17AF4BF8506E611F1535E40AE8BDD69AB363F4000000040E17AF4BF', '2025-06-04 16:57:34.660715', '2025-06-04 16:57:34.660715', 99, '1', NULL, 1);
INSERT INTO public.lane_group VALUES ('8642101470935646080', 100001, '01030000A0E610000001000000080000008506E611F1535E40AE8BDD69AB363F4000000040E17AF4BF8506E611F1535E403F905490B3363F4000000040E17AF4BFEC67D222F2535E4003993A1BB4363F4000000040E17AF4BFEC67D222F2535E4003993A1BB4363F4000000040E17AF4BF46342921F2535E40A3F51375B6363F4000000040E17AF4BFEA68EF68F0535E4050B1F049B5363F4000000040E17AF4BFB917935CF0535E40780005C3AB363F4000000040E17AF4BF8506E611F1535E40AE8BDD69AB363F4000000040E17AF4BF', '2025-06-04 16:59:51.065544', '2025-06-04 16:59:51.065544', 99, '1', NULL, 1);
INSERT INTO public.lane_group VALUES ('8642101470935646070', 100001, '01030000A0E610000001000000080000008506E611F1535E4064E3876BB1363F4000000040E17AF4BF8506E611F1535E403F905490B3363F4000000040E17AF4BFEC67D222F2535E4003993A1BB4363F4000000040E17AF4BFEC67D222F2535E4003993A1BB4363F4000000040E17AF4BF46342921F2535E40A3F51375B6363F4000000040E17AF4BFEA68EF68F0535E4050B1F049B5363F4000000040E17AF4BFEC486F64F0535E40F80517D2B1363F4000000040E17AF4BF8506E611F1535E4064E3876BB1363F4000000040E17AF4BF', '2025-06-04 17:04:15.738388', '2025-06-04 17:04:15.738388', 99, '1', NULL, 1);
INSERT INTO public.lane_group VALUES ('8642101470935646064', 100001, '01030000A0E6100000010000000B0000008506E611F1535E4064E3876BB1363F4000000040E17AF4BF48FDF051F1535E40816DC292B2363F4000000040E17AF4BFB74C7E72F1535E403302D61CB3363F4000000040E17AF4BFEC67D222F2535E4003993A1BB4363F4000000040E17AF4BFEC67D222F2535E4003993A1BB4363F4000000040E17AF4BF46342921F2535E40A3F51375B6363F4000000040E17AF4BFB169C61EF1535E40444F3741B5363F4000000040E17AF4BF97F715C4F0535E40DF6C27D5B4363F4000000040E17AF4BFA7E5909FF0535E40EB9C858EB4363F4000000040E17AF4BFEC486F64F0535E40F80517D2B1363F4000000040E17AF4BF8506E611F1535E4064E3876BB1363F4000000040E17AF4BF', '2025-06-04 17:28:33.934547', '2025-06-04 17:28:33.934547', 99, '1', NULL, 1);
INSERT INTO public.lane_group VALUES ('8642101470935646073', 100001, '01030000A0E610000001000000060000008506E611F1535E40AE8BDD69AB363F4000000040E17AF4BF8506E611F1535E4064E3876BB1363F4000000040E17AF4BF8506E611F1535E4064E3876BB1363F4000000040E17AF4BFEC486F64F0535E40F80517D2B1363F4000000040E17AF4BFB917935CF0535E40780005C3AB363F4000000040E17AF4BF8506E611F1535E40AE8BDD69AB363F4000000040E17AF4BF', '2025-06-04 17:28:34.525009', '2025-06-04 17:28:34.525009', 99, '1', NULL, 1);
INSERT INTO public.lane_group VALUES ('8642101470935646086', 100001, '01030000A0E6100000010000000F000000EC67D222F2535E4003993A1BB4363F4000000040E17AF4BF7CD28904F3535E40213D1A8EB4363F4000000040E17AF4BF9DDAF3DEF3535E4050A0CE63B4363F4000000040E17AF4BFD0FA7556F4535E403F905490B3363F4000000040E17AF4BFFDC8F166F4535E40AB929805B2363F4000000040E17AF4BF1833106BF4535E40D7EBFC2CAD363F4000000040E17AF4BF5665E987F4535E401A297A31AB363F4000000040E17AF4BF5665E987F4535E401A297A31AB363F4000000040E17AF4BFE3216320F5535E40A2B4A94DAB363F4000000040E17AF4BFDF9E8224F5535E4072EC4DCAAC363F4000000040E17AF4BF8A856BFFF4535E40E578FB2FB4363F4000000040E17AF4BF87B64594F4535E4020E994C6B6363F4000000040E17AF4BFE98699C2F2535E402BC0C8E2B6363F4000000040E17AF4BF46342921F2535E40A3F51375B6363F4000000040E17AF4BFEC67D222F2535E4003993A1BB4363F4000000040E17AF4BF', '2025-06-04 17:28:35.106431', '2025-06-04 17:28:35.106431', 99, '1', NULL, 1);
INSERT INTO public.lane_group VALUES ('8642101470935646112', 100001, '01030000A0E610000001000000090000005665E987F4535E401A297A31AB363F4000000040E17AF4BFDBCEF49BF4535E403B01CE04A3363F4000000040E17AF4BFDF51D597F4535E40BBE4BF0D9F363F4000000040E17AF4BFDF51D597F4535E40BBE4BF0D9F363F4000000040E17AF4BFA6BD4751F5535E40C6BBF3299F363F4000000040E17AF4BFA6BD4751F5535E40FBF24609A1363F4000000040E17AF4BFA6BD4751F5535E40292705D6A4363F4000000040E17AF4BFE3216320F5535E40A2B4A94DAB363F4000000040E17AF4BF5665E987F4535E401A297A31AB363F4000000040E17AF4BF', '2025-06-04 17:28:35.685529', '2025-06-04 17:28:35.685529', 99, '1', NULL, 1);
INSERT INTO public.lane_group VALUES ('8642101470935646115', 100001, '01030000A0E6100000010000000C0000003F442E2EF1535E40BBE4BF0D9F363F4000000040E17AF4BF82F9E746F1535E40FF613E65A4363F4000000040E17AF4BF82F9E746F1535E40F85EA952A6363F4000000040E17AF4BF0EF3D121F1535E400FA869DDA7363F4000000040E17AF4BFF70B9419F1535E403E41CF57AA363F4000000040E17AF4BF8506E611F1535E40AE8BDD69AB363F4000000040E17AF4BF8506E611F1535E40AE8BDD69AB363F4000000040E17AF4BFB917935CF0535E40780005C3AB363F4000000040E17AF4BFD2804943F0535E40983399F9A7363F4000000040E17AF4BFE967874BF0535E40FF613E65A4363F4000000040E17AF4BFFF4EC553F0535E40F61EA8FF9E363F4000000040E17AF4BF3F442E2EF1535E40BBE4BF0D9F363F4000000040E17AF4BF', '2025-06-04 17:28:36.263268', '2025-06-04 17:28:36.263268', 99, '1', NULL, 1);


--
-- TOC entry 4507 (class 0 OID 18040)
-- Dependencies: 222
-- Data for Name: lane_group_ref; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.lane_group_ref VALUES ('8642735957864349614', '8642735957864349615', '1002', '2025-06-04 11:31:17.801011', '2025-06-04 11:36:22.029435', '8644945289041412080', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416831', '8642660435159416832', '1002', '2025-06-04 12:08:16.999321', '2025-06-04 14:10:09.790582', '8644945289041412086', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895807', '8642348861051895808', '1002', '2025-06-04 14:39:07.863321', '2025-06-04 14:39:45.282035', '8644945289041412092', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642305877019197439', '8642305877019197440', '1002', '2025-06-04 15:02:23.257642', '2025-06-04 15:03:09.839483', '8644945289041412086', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642272238835335152', '8642272238835335153', '1002', '2025-06-04 15:39:22.386692', '2025-06-04 15:46:50.417012', '8644945289041412086', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642735957864349622', '8642735957864349623', '1002', '2025-06-04 11:31:16.435833', '2025-06-04 11:36:23.195905', '8644945289041412086', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642735957864349617', '8642735957864349618', '1002', '2025-06-04 11:31:17.168399', '2025-06-04 11:36:24.375211', '8644945289041412083', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642735957864349683', '8642735957864349685', '1002', '2025-06-04 11:31:04.679183', '2025-06-04 11:36:25.543761', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642735957864349636', '8642735957864349638', '1002', '2025-06-04 11:31:14.329863', '2025-06-04 11:36:26.130093', '8644945289041412096', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642735957864349629', '8642735957864349630', '1002', '2025-06-04 11:31:15.096322', '2025-06-04 11:36:26.711977', '8644945289041412092', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642735957864349640', '8642735957864349641', '1002', '2025-06-04 11:31:13.279307', '2025-06-04 11:36:27.293996', '8645046787708551157', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642735957864349689', '8642735957864349690', '1002', '2025-06-04 11:31:03.192777', '2025-06-04 11:36:27.875711', '8645782395347271668', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642735957864349625', '8642735957864349626', '1002', '2025-06-04 11:31:15.790565', '2025-06-04 11:36:28.459641', '8644945289041412089', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642735957864349642', '8642735957864349644', '1002', '2025-06-04 11:31:12.776276', '2025-06-04 11:36:29.041787', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642735957864349635', '8642735957864349637', '1002', '2025-06-04 11:31:14.329863', '2025-06-04 11:36:29.622628', '8644945289041412096', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642735957864349650', '8642735957864349651', '1002', '2025-06-04 11:31:11.184766', '2025-06-04 11:36:30.208981', '8645782395347271580', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642735957864349643', '8642735957864349645', '1002', '2025-06-04 11:31:12.775278', '2025-06-04 11:36:30.80427', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642735957864349681', '8642735957864349682', '1002', '2025-06-04 11:31:05.235702', '2025-06-04 11:36:31.390988', '8645782395347271654', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642698677548220375', '8642698677548220376', '1002', '2025-06-04 11:50:41.189146', '2025-06-04 14:10:01.362469', '8645782395347271589', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642698677548220389', '8642698677548220390', '1002', '2025-06-04 11:50:38.63084', '2025-06-04 14:10:01.972124', '8645782395347271628', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642698677548220387', '8642698677548220388', '1002', '2025-06-04 11:50:39.170067', '2025-06-04 14:10:02.58311', '8645782395347271611', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642698677548220368', '8642698677548220369', '1002', '2025-06-04 11:50:42.471662', '2025-06-04 14:10:03.258493', '8645782395347271577', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642698677548220411', '8642698677548220413', '1002', '2025-06-04 11:50:12.406178', '2025-06-04 14:10:03.870087', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642698677548220337', '8642698677548220338', '1002', '2025-06-04 11:50:48.139269', '2025-06-04 14:10:04.502928', '8644945289041412080', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642698677548220383', '8642698677548220384', '1002', '2025-06-04 11:50:39.841291', '2025-06-04 14:10:05.132327', '8645782395347271606', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642698677548220412', '8642698677548220414', '1002', '2025-06-04 11:50:12.406178', '2025-06-04 14:10:05.759236', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642698677548220397', '8642698677548220398', '1002', '2025-06-04 11:50:37.070016', '2025-06-04 14:10:06.391487', '8645782395347271651', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642698677548220348', '8642698677548220349', '1002', '2025-06-04 11:50:46.188212', '2025-06-04 14:10:07.102487', '8644945289041412089', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642698677548220401', '8642698677548220402', '1002', '2025-06-04 11:50:36.364669', '2025-06-04 14:10:07.78722', '8645782395347271654', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642698677548220341', '8642698677548220342', '1002', '2025-06-04 11:50:47.481874', '2025-06-04 14:10:08.468085', '8644945289041412083', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642723176041676773', '8642723176041676774', '1002', '2025-06-04 11:37:02.251368', '2025-06-04 11:39:42.737366', '8645782395347271628', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642723176041676753', '8642723176041676754', '1002', '2025-06-04 11:37:06.044169', '2025-06-04 11:39:43.358507', '8645782395347271577', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642723176041676771', '8642723176041676772', '1002', '2025-06-04 11:37:02.797394', '2025-06-04 11:39:43.972503', '8645782395347271611', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642723176041676795', '8642723176041676797', '1002', '2025-06-04 11:36:57.447826', '2025-06-04 11:39:44.588265', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642723176041676767', '8642723176041676768', '1002', '2025-06-04 11:37:03.475172', '2025-06-04 11:39:45.202306', '8645782395347271606', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642723176041676796', '8642723176041676798', '1002', '2025-06-04 11:36:57.447826', '2025-06-04 11:39:45.810678', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642723176041676781', '8642723176041676782', '1002', '2025-06-04 11:37:00.714175', '2025-06-04 11:39:46.427804', '8645782395347271651', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642723176041676793', '8642723176041676794', '1002', '2025-06-04 11:36:58.034411', '2025-06-04 11:39:47.033273', '8645782395347271668', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642723176041676748', '8642723176041676750', '1002', '2025-06-04 11:37:06.969065', '2025-06-04 11:39:47.636931', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642723176041676742', '8642723176041676744', '1002', '2025-06-04 11:37:08.377527', '2025-06-04 11:39:48.248763', '8644945289041412096', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642723176041676785', '8642723176041676786', '1002', '2025-06-04 11:37:00.014377', '2025-06-04 11:39:48.857353', '8645782395347271654', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642723176041676749', '8642723176041676751', '1002', '2025-06-04 11:37:06.969065', '2025-06-04 11:39:49.453942', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642723176041676733', '8642723176041676734', '1002', '2025-06-04 11:37:10.11322', '2025-06-04 11:39:50.059225', '8644945289041412089', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642723176041676756', '8642723176041676757', '1002', '2025-06-04 11:37:05.436211', '2025-06-04 11:39:50.657418', '8645782395347271580', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642723176041676776', '8642723176041676778', '1002', '2025-06-04 11:37:01.726467', '2025-06-04 11:39:51.260299', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642723176041676775', '8642723176041676777', '1002', '2025-06-04 11:37:01.727463', '2025-06-04 11:39:51.863732', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642723176041676760', '8642723176041676761', '1002', '2025-06-04 11:37:04.763155', '2025-06-04 11:39:52.46762', '8645782395347271589', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642698677548220409', '8642698677548220410', '1002', '2025-06-04 11:50:34.393868', '2025-06-04 14:10:09.134291', '8645782395347271668', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642698677548220371', '8642698677548220372', '1002', '2025-06-04 11:50:41.855958', '2025-06-04 14:10:10.410395', '8645782395347271580', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642698677548220379', '8642698677548220380', '1002', '2025-06-04 11:50:40.519331', '2025-06-04 14:10:11.018139', '8645782395347271601', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642698677548220391', '8642698677548220393', '1002', '2025-06-04 11:50:38.087506', '2025-06-04 14:10:11.624845', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642698677548220404', '8642698677548220406', '1002', '2025-06-04 11:50:35.830385', '2025-06-04 14:10:12.233212', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642698677548220407', '8642698677548220408', '1002', '2025-06-04 11:50:34.932288', '2025-06-04 14:10:12.840935', '8645924713383591797', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642698677548220415', '8642698677548220416', '1002', '2025-06-04 11:50:11.427305', '2025-06-04 14:10:13.452079', '8645924713383591832', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642698677548220403', '8642698677548220405', '1002', '2025-06-04 11:50:35.830385', '2025-06-04 14:10:14.066061', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642698677548220364', '8642698677548220366', '1002', '2025-06-04 11:50:43.398048', '2025-06-04 14:10:14.67645', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642698677548220363', '8642698677548220365', '1002', '2025-06-04 11:50:43.398048', '2025-06-04 14:10:15.28262', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642698677548220361', '8642698677548220362', '1002', '2025-06-04 11:50:43.882738', '2025-06-04 14:10:15.891759', '8645046787708551157', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642698677548220358', '8642698677548220360', '1002', '2025-06-04 11:50:44.813331', '2025-06-04 14:10:16.49988', '8644945289041412096', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642698677548220357', '8642698677548220359', '1002', '2025-06-04 11:50:44.814329', '2025-06-04 14:10:17.115262', '8644945289041412096', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642698677548220351', '8642698677548220352', '1002', '2025-06-04 11:50:45.563689', '2025-06-04 14:10:17.720974', '8644945289041412092', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640703', '8642391707645640704', '1002', '2025-06-04 14:20:13.722735', '2025-06-04 14:39:45.91362', '8645924713383591832', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640631', '8642391707645640632', '1002', '2025-06-04 14:20:28.290174', '2025-06-04 14:39:48.4388', '8644945289041412086', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640622', '8642391707645640623', '1002', '2025-06-04 14:20:29.74804', '2025-06-04 14:39:49.06618', '8644945289041412080', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640697', '8642391707645640698', '1002', '2025-06-04 14:20:15.340684', '2025-06-04 14:39:49.688854', '8645782395347271668', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640695', '8642391707645640696', '1002', '2025-06-04 14:20:15.903654', '2025-06-04 14:39:50.314528', '8645924713383591797', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640692', '8642391707645640694', '1002', '2025-06-04 14:20:16.831328', '2025-06-04 14:39:50.936925', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640691', '8642391707645640693', '1002', '2025-06-04 14:20:16.832325', '2025-06-04 14:39:51.559883', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640689', '8642391707645640690', '1002', '2025-06-04 14:20:17.381855', '2025-06-04 14:39:52.187076', '8645782395347271654', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640685', '8642391707645640686', '1002', '2025-06-04 14:20:18.108903', '2025-06-04 14:39:52.8147', '8645782395347271651', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640671', '8642391707645640672', '1002', '2025-06-04 14:20:20.990227', '2025-06-04 14:39:53.437099', '8645782395347271606', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640667', '8642391707645640668', '1002', '2025-06-04 14:20:21.689797', '2025-06-04 14:39:54.070463', '8645782395347271601', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640663', '8642391707645640664', '1002', '2025-06-04 14:20:22.387395', '2025-06-04 14:39:54.697488', '8645782395347271589', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642723176041676721', '8642723176041676722', '1002', '2025-06-04 11:37:12.12761', '2025-06-04 11:39:53.071827', '8644945289041412080', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642723176041676764', '8642723176041676765', '1002', '2025-06-04 11:37:04.097283', '2025-06-04 11:39:53.679831', '8645782395347271601', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642723176041676791', '8642723176041676792', '1002', '2025-06-04 11:36:58.584995', '2025-06-04 11:39:54.289379', '8645924713383591797', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642723176041676729', '8642723176041676730', '1002', '2025-06-04 11:37:10.793322', '2025-06-04 11:39:54.888122', '8644945289041412086', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642723176041676788', '8642723176041676790', '1002', '2025-06-04 11:36:59.483629', '2025-06-04 11:39:55.495', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642723176041676725', '8642723176041676726', '1002', '2025-06-04 11:37:11.474209', '2025-06-04 11:39:56.109218', '8644945289041412083', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591916', '8645924713383591930', '1001', '2025-06-03 09:47:24.70594', '2025-06-03 09:48:58.07177', '8645924713383591917', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642723176041676746', '8642723176041676747', '1002', '2025-06-04 11:37:07.448736', '2025-06-04 11:39:56.711024', '8645046787708551157', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642723176041676787', '8642723176041676789', '1002', '2025-06-04 11:36:59.483629', '2025-06-04 11:39:57.308782', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642723176041676799', '8642723176041676800', '1002', '2025-06-04 11:36:56.471259', '2025-06-04 11:39:57.915988', '8645924713383591832', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642723176041676743', '8642723176041676745', '1002', '2025-06-04 11:37:08.377527', '2025-06-04 11:39:58.519212', '8644945289041412096', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591895', '8645924713383591900', '1004', '2025-06-03 09:51:12.806611', '2025-06-03 14:44:15.920157', '8645924713383591923', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591921', '8645924713383591924', '1001', '2025-06-03 09:47:05.457718', '2025-06-03 14:44:15.920157', '8645924713383591923', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591907', '8645924713383591909', '1002', '2025-06-03 09:49:21.365696', '2025-06-03 14:46:48.755845', '8645924713383591928', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591908', '8645924713383591910', '1002', '2025-06-03 09:49:21.364729', '2025-06-03 14:46:49.941886', '8645924713383591928', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591919', '8645924713383591935', '1001', '2025-06-03 09:47:17.182637', '2025-06-03 14:42:09.593031', '8645924713383591920', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591927', '8645924713383591933', '1001', '2025-06-03 09:45:37.025098', '2025-06-03 14:43:46.100108', '8645924713383591928', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591896', '8645924713383591900', '1004', '2025-06-03 09:51:12.678906', '2025-06-03 14:43:46.100108', '8645924713383591928', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591879', '8645924713383591884', '1005', '2025-06-03 09:55:56.43726', '2025-06-03 14:43:46.100108', '8645924713383591928', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591877', '8645924713383591883', '1005', '2025-06-03 09:55:56.851151', '2025-06-03 14:43:46.100108', '8645924713383591928', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591926', '8645924713383591932', '1001', '2025-06-03 09:45:37.026096', '2025-06-03 14:43:46.100108', '8645924713383591928', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591925', '8645924713383591931', '1001', '2025-06-03 09:45:37.026096', '2025-06-03 14:43:46.100108', '8645924713383591928', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591922', '8645924713383591936', '1001', '2025-06-03 09:47:05.457718', '2025-06-03 14:44:15.920157', '8645924713383591923', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591905', '8645924713383591906', '1002', '2025-06-03 09:49:21.908098', '2025-06-03 14:46:51.119025', '8645924713383591923', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591839', '8645924713383591855', '1001', '2025-06-03 10:18:39.586878', '2025-06-03 17:46:14.327109', '8645924713383591841', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591838', '8645924713383591847', '1001', '2025-06-03 10:18:39.587876', '2025-06-03 17:46:14.327109', '8645924713383591841', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591831', '8645924713383591842', '1001', '2025-06-03 10:22:14.692622', '2025-06-03 10:22:14.692622', '8645924713383591832', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591830', '8645924713383591843', '1001', '2025-06-03 10:22:14.692622', '2025-06-03 10:22:14.692622', '8645924713383591832', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642723176041676736', '8642723176041676737', '1002', '2025-06-04 11:37:09.11772', '2025-06-04 11:39:59.121066', '8644945289041412092', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591808', '8645924713383591813', '1001', '2025-06-03 10:28:42.65078', '2025-06-03 10:28:42.65078', '8645924713383591809', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591807', '8645924713383591814', '1001', '2025-06-03 10:28:42.651779', '2025-06-03 10:28:42.651779', '8645924713383591809', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591806', '8645924713383591815', '1001', '2025-06-03 10:28:42.651779', '2025-06-03 10:28:42.651779', '8645924713383591809', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591804', '8645924713383591870', '1001', '2025-06-03 10:31:23.958878', '2025-06-03 10:44:35.430287', '8645924713383591805', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591803', '8645924713383591876', '1001', '2025-06-03 10:31:23.958878', '2025-06-03 10:44:35.430287', '8645924713383591805', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591802', '8645924713383591865', '1001', '2025-06-03 10:31:23.958878', '2025-06-03 10:44:37.213072', '8645924713383591805', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591796', '8645924713383591800', '1001', '2025-06-03 10:46:22.668365', '2025-06-03 10:46:22.668365', '8645924713383591797', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591795', '8645924713383591798', '1001', '2025-06-03 10:46:22.669366', '2025-06-03 10:46:22.669366', '8645924713383591797', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591793', '8645924713383591870', '1001', '2025-06-03 10:46:32.142163', '2025-06-03 10:46:32.142163', '8645924713383591794', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591792', '8645924713383591876', '1001', '2025-06-03 10:46:32.142163', '2025-06-03 10:46:32.142163', '8645924713383591794', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591791', '8645924713383591799', '1001', '2025-06-03 10:46:32.143188', '2025-06-03 10:46:32.143188', '8645924713383591794', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591811', '8645924713383591818', '1001', '2025-06-03 10:28:37.402429', '2025-06-03 11:17:03.489624', '8645924713383591812', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271605', '8645782395347271616', '1001', '2025-06-03 14:10:56.899956', '2025-06-03 14:10:56.899956', '8645782395347271606', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271673', '8645782395347271674', '1002', '2025-06-03 11:16:25.299618', '2025-06-03 11:17:10.758081', '8645924713383591812', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271667', '8645924713383591818', '1001', '2025-06-03 11:17:23.564457', '2025-06-03 11:17:23.564457', '8645782395347271668', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271666', '8645924713383591816', '1001', '2025-06-03 11:17:23.565455', '2025-06-03 11:17:23.565455', '8645782395347271668', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271653', '8645782395347271662', '1001', '2025-06-03 12:07:12.914536', '2025-06-03 12:07:12.914536', '8645782395347271654', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271652', '8645782395347271663', '1001', '2025-06-03 12:07:12.914536', '2025-06-03 12:07:12.914536', '8645782395347271654', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271650', '8645782395347271659', '1001', '2025-06-03 12:07:49.873883', '2025-06-03 12:07:49.873883', '8645782395347271651', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271649', '8645782395347271658', '1001', '2025-06-03 12:07:49.874881', '2025-06-03 12:07:49.874881', '8645782395347271651', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271631', '8645782395347271640', '1001', '2025-06-03 12:16:28.571564', '2025-06-03 12:16:28.571564', '8645782395347271632', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271630', '8645782395347271639', '1001', '2025-06-03 12:16:28.571564', '2025-06-03 12:16:28.571564', '8645782395347271632', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271629', '8645782395347271637', '1001', '2025-06-03 12:16:28.571564', '2025-06-03 12:16:28.571564', '8645782395347271632', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271627', '8645782395347271633', '1001', '2025-06-03 12:16:37.784422', '2025-06-03 12:16:37.784422', '8645782395347271628', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271626', '8645782395347271634', '1001', '2025-06-03 12:16:37.784422', '2025-06-03 12:16:37.784422', '8645782395347271628', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271610', '8645782395347271618', '1001', '2025-06-03 14:10:31.718814', '2025-06-03 14:10:31.718814', '8645782395347271611', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271609', '8645782395347271619', '1001', '2025-06-03 14:10:31.71981', '2025-06-03 14:10:31.71981', '8645782395347271611', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271604', '8645782395347271617', '1001', '2025-06-03 14:10:56.899956', '2025-06-03 14:10:56.899956', '8645782395347271606', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271600', '8645782395347271614', '1001', '2025-06-03 14:12:03.04479', '2025-06-03 14:12:03.04479', '8645782395347271601', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271599', '8645782395347271615', '1001', '2025-06-03 14:12:03.04479', '2025-06-03 14:12:03.04479', '8645782395347271601', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416798', '8642660435159416799', '1002', '2025-06-04 14:10:40.887589', '2025-06-04 14:17:19.907881', '8645782395347271611', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271588', '8645782395347271591', '1001', '2025-06-03 14:14:56.737351', '2025-06-03 14:14:56.737351', '8645782395347271589', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271587', '8645782395347271590', '1001', '2025-06-03 14:14:56.737351', '2025-06-03 14:14:56.737351', '8645782395347271589', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271592', '8645782395347271593', '1002', '2025-06-03 14:12:26.789774', '2025-06-03 17:20:38.555614', '8645782395347271601', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591840', '8645924713383591856', '1001', '2025-06-03 10:18:39.586878', '2025-06-03 17:46:14.327109', '8645924713383591841', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591827', '8645924713383591829', '1002', '2025-06-03 10:22:26.540709', '2025-06-03 17:46:14.327109', '8645924713383591841', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271645', '8645782395347271646', '1002', '2025-06-03 12:08:05.615426', '2025-06-03 17:46:14.327109', '8645924713383591841', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591837', '8645924713383591846', '1001', '2025-06-03 10:18:39.587876', '2025-06-03 17:46:14.327109', '8645924713383591841', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271656', '8645782395347271660', '1001', '2025-06-03 12:07:01.614899', '2025-06-03 17:46:14.951149', '8645782395347271657', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271655', '8645782395347271661', '1001', '2025-06-03 12:07:01.614899', '2025-06-03 17:46:14.951149', '8645782395347271657', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271647', '8645782395347271648', '1002', '2025-06-03 12:08:05.151664', '2025-06-03 17:46:14.951149', '8645782395347271657', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591834', '8645924713383591853', '1001', '2025-06-03 10:22:09.483216', '2025-06-03 17:46:15.568951', '8645924713383591835', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591833', '8645924713383591836', '1001', '2025-06-03 10:22:09.483216', '2025-06-03 17:46:15.568951', '8645924713383591835', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271597', '8645782395347271613', '1001', '2025-06-03 14:12:14.520568', '2025-06-03 17:46:16.183605', '8645782395347271598', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271596', '8645782395347271612', '1001', '2025-06-03 14:12:14.520568', '2025-06-03 17:46:16.183605', '8645782395347271598', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271579', '8645782395347271584', '1001', '2025-06-03 14:17:24.076398', '2025-06-03 14:17:24.076398', '8645782395347271580', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271578', '8645782395347271583', '1001', '2025-06-03 14:17:24.081495', '2025-06-03 14:17:24.081495', '8645782395347271580', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271576', '8645782395347271582', '1001', '2025-06-03 14:17:30.301487', '2025-06-03 14:17:30.301487', '8645782395347271577', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271575', '8645782395347271581', '1001', '2025-06-03 14:17:30.301487', '2025-06-03 14:17:30.301487', '8645782395347271577', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271562', '8645782395347271570', '1004', '2025-06-03 14:20:50.98934', '2025-06-03 14:20:50.98934', '8645924713383591809', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271561', '8645782395347271570', '1004', '2025-06-03 14:20:51.117673', '2025-06-03 14:20:51.117673', '8645782395347271668', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271560', '8645782395347271570', '1004', '2025-06-03 14:20:51.245585', '2025-06-03 14:20:51.245585', '8645782395347271654', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271559', '8645782395347271570', '1004', '2025-06-03 14:20:51.373162', '2025-06-03 14:20:51.373162', '8645782395347271651', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271558', '8645782395347271570', '1004', '2025-06-03 14:20:51.501971', '2025-06-03 14:20:51.501971', '8645782395347271611', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271557', '8645782395347271570', '1004', '2025-06-03 14:20:51.63175', '2025-06-03 14:20:51.63175', '8645782395347271606', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271556', '8645782395347271570', '1004', '2025-06-03 14:20:51.758964', '2025-06-03 14:20:51.758964', '8645782395347271580', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271549', '8645782395347271569', '1004', '2025-06-03 14:20:52.782315', '2025-06-03 14:20:52.782315', '8645782395347271632', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271548', '8645782395347271569', '1004', '2025-06-03 14:20:52.91013', '2025-06-03 14:20:52.91013', '8645782395347271628', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271547', '8645782395347271569', '1004', '2025-06-03 14:20:53.03785', '2025-06-03 14:20:53.03785', '8645782395347271606', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271546', '8645782395347271569', '1004', '2025-06-03 14:20:53.165188', '2025-06-03 14:20:53.165188', '8645782395347271601', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271538', '8645782395347271543', '1005', '2025-06-03 14:22:08.015722', '2025-06-03 14:22:08.015722', '8645924713383591809', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271536', '8645782395347271542', '1005', '2025-06-03 14:22:08.402892', '2025-06-03 14:22:08.402892', '8645924713383591809', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271534', '8645782395347271541', '1005', '2025-06-03 14:22:08.788017', '2025-06-03 14:22:08.788017', '8645782395347271632', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271532', '8645782395347271540', '1005', '2025-06-03 14:22:09.172601', '2025-06-03 14:22:09.172601', '8645782395347271632', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271523', '8645782395347271531', '1005', '2025-06-03 14:23:01.468606', '2025-06-03 14:23:01.468606', '8645782395347271611', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271522', '8645782395347271531', '1005', '2025-06-03 14:23:01.593785', '2025-06-03 14:23:01.593785', '8645782395347271606', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271521', '8645782395347271531', '1005', '2025-06-03 14:23:01.71981', '2025-06-03 14:23:01.71981', '8645782395347271601', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271519', '8645782395347271531', '1005', '2025-06-03 14:23:01.971338', '2025-06-03 14:23:01.971338', '8645782395347271589', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271518', '8645782395347271531', '1005', '2025-06-03 14:23:02.097436', '2025-06-03 14:23:02.097436', '8645782395347271577', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271509', '8645782395347271530', '1005', '2025-06-03 14:23:03.352606', '2025-06-03 14:23:03.352606', '8645782395347271654', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271508', '8645782395347271530', '1005', '2025-06-03 14:23:03.478393', '2025-06-03 14:23:03.478393', '8645782395347271651', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271507', '8645782395347271530', '1005', '2025-06-03 14:23:03.603109', '2025-06-03 14:23:03.603109', '8645782395347271611', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271506', '8645782395347271530', '1005', '2025-06-03 14:23:03.728712', '2025-06-03 14:23:03.728712', '8645782395347271606', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271505', '8645782395347271530', '1005', '2025-06-03 14:23:03.853835', '2025-06-03 14:23:03.853835', '8645782395347271580', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591894', '8645924713383591900', '1004', '2025-06-03 09:51:12.935089', '2025-06-03 14:25:40.452037', '8645924713383591913', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591903', '8645924713383591904', '1002', '2025-06-03 09:49:22.395944', '2025-06-03 14:25:41.046434', '8645924713383591920', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591901', '8645924713383591902', '1002', '2025-06-03 09:49:22.887208', '2025-06-03 14:25:41.635767', '8645924713383591913', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591810', '8645924713383591817', '1001', '2025-06-03 10:28:37.403426', '2025-06-03 14:25:45.184619', '8645924713383591812', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591915', '8645924713383591929', '1001', '2025-06-03 09:47:24.70594', '2025-06-03 14:25:45.773293', '8645924713383591917', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591912', '8645924713383591929', '1001', '2025-06-03 09:49:07.845883', '2025-06-03 14:25:45.773293', '8645924713383591913', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591918', '8645924713383591934', '1001', '2025-06-03 09:47:17.183634', '2025-06-03 14:25:46.365299', '8645924713383591920', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271493', '8645924713383591893', '1005', '2025-06-03 14:26:30.289204', '2025-06-03 14:26:30.289204', '8645924713383591832', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271492', '8645924713383591862', '1005', '2025-06-03 14:26:30.423462', '2025-06-03 14:26:30.423462', '8645924713383591832', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271491', '8645924713383591860', '1004', '2025-06-03 14:26:30.603015', '2025-06-03 14:26:30.603015', '8645924713383591832', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271490', '8645924713383591860', '1004', '2025-06-03 14:26:33.085325', '2025-06-03 14:26:33.085325', '8645924713383591797', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271489', '8645924713383591882', '1005', '2025-06-03 14:26:33.981298', '2025-06-03 14:26:33.981298', '8645924713383591794', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271488', '8645924713383591881', '1005', '2025-06-03 14:26:34.115455', '2025-06-03 14:26:34.115455', '8645924713383591794', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271487', '8645924713383591860', '1004', '2025-06-03 14:26:34.293617', '2025-06-03 14:26:34.293617', '8645924713383591794', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271486', '8645924713383591862', '1005', '2025-06-03 14:26:35.055074', '2025-06-03 14:26:35.055074', '8645782395347271654', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271485', '8645924713383591860', '1004', '2025-06-03 14:26:35.277466', '2025-06-03 14:26:35.277466', '8645782395347271654', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271484', '8645924713383591862', '1005', '2025-06-03 14:26:36.0809', '2025-06-03 14:26:36.0809', '8645782395347271651', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271483', '8645924713383591860', '1004', '2025-06-03 14:26:36.30457', '2025-06-03 14:26:36.30457', '8645782395347271651', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271482', '8645924713383591862', '1005', '2025-06-03 14:26:40.434565', '2025-06-03 14:26:40.434565', '8645782395347271601', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271571', '8645782395347271572', '1002', '2025-06-03 14:17:37.257937', '2025-06-03 17:20:47.40024', '8645782395347271577', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271501', '8645924713383591893', '1005', '2025-06-03 14:26:27.852293', '2025-06-03 17:46:14.327109', '8645924713383591841', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271500', '8645924713383591862', '1005', '2025-06-03 14:26:27.989971', '2025-06-03 17:46:14.327109', '8645924713383591841', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212195', '8642718640556212196', '1002', '2025-06-04 11:41:28.601866', '2025-06-04 11:49:33.007144', '8645782395347271611', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271481', '8645924713383591860', '1004', '2025-06-03 14:26:40.658962', '2025-06-03 14:26:40.658962', '8645782395347271601', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271478', '8645924713383591862', '1005', '2025-06-03 14:26:42.513622', '2025-06-03 14:26:42.513622', '8645782395347271589', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271477', '8645924713383591860', '1004', '2025-06-03 14:26:42.741482', '2025-06-03 14:26:42.741482', '8645782395347271589', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271476', '8645924713383591893', '1005', '2025-06-03 14:26:43.503528', '2025-06-03 14:26:43.503528', '8645782395347271580', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271475', '8645924713383591900', '1004', '2025-06-03 14:26:43.72698', '2025-06-03 14:26:43.72698', '8645782395347271580', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271474', '8645924713383591893', '1005', '2025-06-03 14:26:44.526672', '2025-06-03 14:26:44.526672', '8645782395347271577', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271473', '8645924713383591900', '1004', '2025-06-03 14:26:44.749345', '2025-06-03 14:26:44.749345', '8645782395347271577', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591911', '8645924713383591914', '1001', '2025-06-03 09:49:07.845883', '2025-06-03 14:42:10.203495', '8645924713383591913', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271261', '8645782395347271263', '1002', '2025-06-03 14:45:15.967547', '2025-06-03 15:48:12.228296', '8645782395347271274', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271262', '8645782395347271264', '1002', '2025-06-03 14:45:15.967547', '2025-06-03 15:48:12.228296', '8645782395347271274', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271271', '8645782395347271292', '1001', '2025-06-03 14:44:01.874547', '2025-06-03 15:48:12.228296', '8645782395347271274', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271273', '8645782395347271286', '1001', '2025-06-03 14:44:01.874547', '2025-06-03 15:48:12.228296', '8645782395347271274', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271277', '8645782395347271285', '1001', '2025-06-03 14:42:51.04559', '2025-06-03 15:48:12.810851', '8645782395347271278', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271276', '8645782395347271283', '1001', '2025-06-03 14:42:51.04559', '2025-06-03 15:48:12.810851', '8645782395347271278', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271275', '8645782395347271291', '1001', '2025-06-03 14:42:51.04559', '2025-06-03 15:48:12.810851', '8645782395347271278', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271256', '8645782395347271258', '1002', '2025-06-03 14:45:17.356152', '2025-06-03 15:48:12.810851', '8645782395347271278', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271255', '8645782395347271257', '1002', '2025-06-03 14:45:17.356152', '2025-06-03 15:48:12.810851', '8645782395347271278', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271235', '8645782395347271236', '1002', '2025-06-03 14:56:52.787055', '2025-06-03 15:48:12.810851', '8645782395347271278', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271238', '8645782395347271240', '1002', '2025-06-03 14:47:14.112586', '2025-06-03 15:48:12.810851', '8645782395347271278', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271259', '8645782395347271260', '1002', '2025-06-03 14:45:16.52892', '2025-06-03 15:48:13.392234', '8645782395347271270', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271266', '8645782395347271280', '1001', '2025-06-03 14:45:02.066911', '2025-06-03 15:48:13.975992', '8645782395347271267', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271265', '8645782395347271282', '1001', '2025-06-03 14:45:02.066911', '2025-06-03 15:48:13.975992', '8645782395347271267', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271252', '8645782395347271253', '1002', '2025-06-03 14:45:18.003966', '2025-06-03 15:48:13.975992', '8645782395347271267', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271245', '8645782395347271247', '1002', '2025-06-03 14:47:12.56458', '2025-06-03 15:48:14.558107', '8645782395347271274', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645275692285558783', '8645275692285558784', '1002', '2025-06-03 15:05:06.242174', '2025-06-03 15:48:15.142669', '8645782395347271278', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271249', '8645782395347271250', '1002', '2025-06-03 14:47:11.677391', '2025-06-03 15:48:15.723921', '8645782395347271270', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271243', '8645782395347271244', '1002', '2025-06-03 14:47:13.138034', '2025-06-03 15:48:16.307188', '8645782395347271267', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271272', '8645782395347271284', '1001', '2025-06-03 14:44:01.874547', '2025-06-03 16:24:29.492878', '8645782395347271274', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271246', '8645782395347271248', '1002', '2025-06-03 14:47:12.56458', '2025-06-03 15:52:25.166893', '8645782395347271274', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645275692285558766', '8645782395347271284', '1001', '2025-06-03 15:49:15.001598', '2025-06-03 16:24:29.492878', '8645275692285558769', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271269', '8645782395347271281', '1001', '2025-06-03 14:44:45.724388', '2025-06-03 16:24:30.12072', '8645782395347271270', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271268', '8645782395347271279', '1001', '2025-06-03 14:44:45.724388', '2025-06-03 16:24:30.748003', '8645782395347271270', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271239', '8645782395347271241', '1002', '2025-06-03 14:47:14.112586', '2025-06-03 15:52:27.494137', '8645782395347271278', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645275692285558760', '8645782395347271279', '1001', '2025-06-03 15:49:51.224178', '2025-06-03 16:24:30.748003', '8645275692285558761', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212177', '8642718640556212178', '1002', '2025-06-04 11:41:31.846567', '2025-06-04 11:49:34.820097', '8645782395347271577', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212184', '8642718640556212185', '1002', '2025-06-04 11:41:30.570375', '2025-06-04 11:49:35.412971', '8645782395347271589', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212157', '8642718640556212158', '1002', '2025-06-04 11:41:35.515717', '2025-06-04 11:49:38.953743', '8644945289041412089', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212153', '8642718640556212154', '1002', '2025-06-04 11:41:36.170422', '2025-06-04 11:49:39.544163', '8644945289041412086', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645275692285558768', '8645275692285558773', '1001', '2025-06-03 15:49:15.000625', '2025-06-03 16:24:31.37563', '8645275692285558769', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212180', '8642718640556212181', '1002', '2025-06-04 11:41:31.235553', '2025-06-04 11:49:40.128441', '8645782395347271580', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212149', '8642718640556212150', '1002', '2025-06-04 11:41:36.831451', '2025-06-04 11:49:41.303141', '8644945289041412083', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212166', '8642718640556212168', '1002', '2025-06-04 11:41:34.168551', '2025-06-04 11:49:41.893562', '8644945289041412096', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212160', '8642718640556212161', '1002', '2025-06-04 11:41:34.899222', '2025-06-04 11:49:42.483757', '8644945289041412092', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645275692285558753', '8645275692285558755', '1002', '2025-06-03 15:50:11.169433', '2025-06-03 16:22:36.237266', '8645275692285558769', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645275692285558752', '8645275692285558754', '1002', '2025-06-03 15:50:11.169433', '2025-06-03 16:22:36.237266', '8645275692285558769', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645275692285558767', '8645275692285558772', '1001', '2025-06-03 15:49:15.000625', '2025-06-03 16:24:31.999631', '8645275692285558769', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212167', '8642718640556212169', '1002', '2025-06-04 11:41:34.168551', '2025-06-04 11:49:43.084526', '8644945289041412096', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645275692285558770', '8645275692285558771', '1002', '2025-06-03 15:46:24.474542', '2025-06-03 17:46:14.327109', '8645924713383591841', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271480', '8645924713383591893', '1005', '2025-06-03 14:26:41.472511', '2025-06-03 17:46:16.183605', '8645782395347271598', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271479', '8645924713383591900', '1004', '2025-06-03 14:26:41.697474', '2025-06-03 17:46:16.183605', '8645782395347271598', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416743', '8642660435159416744', '1002', '2025-06-04 14:10:50.600547', '2025-06-04 14:17:21.694013', '8644945289041412080', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416756', '8642660435159416757', '1002', '2025-06-04 14:10:48.474937', '2025-06-04 14:17:24.635757', '8644945289041412089', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416752', '8642660435159416753', '1002', '2025-06-04 14:10:49.169262', '2025-06-04 14:17:25.221153', '8644945289041412086', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640700', '8642391707645640702', '1002', '2025-06-04 14:20:14.732617', '2025-06-04 14:39:55.327708', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640699', '8642391707645640701', '1002', '2025-06-04 14:20:14.732617', '2025-06-04 14:39:55.945858', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640680', '8642391707645640682', '1002', '2025-06-04 14:20:19.161669', '2025-06-04 14:39:56.567397', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640679', '8642391707645640681', '1002', '2025-06-04 14:20:19.161669', '2025-06-04 14:39:57.18668', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640677', '8642391707645640678', '1002', '2025-06-04 14:20:19.719236', '2025-06-04 14:39:57.808074', '8645782395347271628', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640675', '8642391707645640676', '1002', '2025-06-04 14:20:20.291704', '2025-06-04 14:39:58.425076', '8645782395347271611', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642296977846960127', '8642296977846960128', '1002', '2025-06-04 15:04:19.867057', '2025-06-04 15:15:35.247714', '8644945289041412086', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642272238835335148', '8642272238835335149', '1002', '2025-06-04 15:48:28.647734', '2025-06-04 15:51:12.324636', '8644945289041412086', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645275692285558749', '8645275692285558750', '1002', '2025-06-03 15:50:11.86557', '2025-06-03 16:22:36.866107', '8645275692285558761', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645275692285558764', '8645782395347271283', '1001', '2025-06-03 15:49:28.876908', '2025-06-03 16:22:37.493705', '8645275692285558765', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645275692285558763', '8645782395347271285', '1001', '2025-06-03 15:49:28.877902', '2025-06-03 16:22:37.493705', '8645275692285558765', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645275692285558762', '8645782395347271291', '1001', '2025-06-03 15:49:28.878901', '2025-06-03 16:22:37.493705', '8645275692285558765', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645275692285558747', '8645275692285558748', '1002', '2025-06-03 15:50:12.724642', '2025-06-03 16:22:37.493705', '8645275692285558765', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645275692285558719', '8645275692285558721', '1002', '2025-06-03 15:52:46.093208', '2025-06-03 16:22:37.493705', '8645275692285558765', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645275692285558757', '8645782395347271282', '1001', '2025-06-03 15:49:59.269302', '2025-06-03 16:22:38.124534', '8645275692285558758', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645275692285558756', '8645782395347271280', '1001', '2025-06-03 15:49:59.269302', '2025-06-03 16:22:38.124534', '8645275692285558758', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645275692285558745', '8645275692285558746', '1002', '2025-06-03 15:50:13.238026', '2025-06-03 16:22:38.124534', '8645275692285558758', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645275692285558723', '8645275692285558724', '1002', '2025-06-03 15:52:45.186935', '2025-06-03 16:22:38.750595', '8645275692285558761', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645275692285558716', '8645275692285558717', '1002', '2025-06-03 15:52:46.769847', '2025-06-03 16:22:39.378455', '8645275692285558758', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645275692285558726', '8645275692285558728', '1002', '2025-06-03 15:52:44.593699', '2025-06-03 16:22:40.004108', '8645275692285558769', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645275692285558720', '8645275692285558722', '1002', '2025-06-03 15:52:46.093208', '2025-06-03 16:22:40.628754', '8645275692285558765', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645275692285558725', '8645275692285558727', '1002', '2025-06-03 15:52:44.593699', '2025-06-03 16:22:41.25377', '8645275692285558769', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645275692285558713', '8645275692285558714', '1002', '2025-06-03 16:03:54.14967', '2025-06-03 16:22:41.882089', '8645275692285558765', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645275692285558759', '8645782395347271281', '1001', '2025-06-03 15:49:51.224178', '2025-06-03 16:24:30.12072', '8645275692285558761', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212191', '8642718640556212192', '1002', '2025-06-04 11:41:29.283028', '2025-06-04 11:43:42.882413', '8645782395347271606', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416778', '8642660435159416779', '1002', '2025-06-04 14:10:44.522558', '2025-06-04 14:14:13.752324', '8645782395347271577', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645046787708551159', '8645275692285558707', '1001', '2025-06-03 16:55:12.418585', '2025-06-26 15:12:17.496438', '8645046787708551160', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645046787708551156', '8645275692285558707', '1001', '2025-06-03 16:57:14.183526', '2025-06-26 15:12:17.496438', '8645046787708551157', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645046787708551163', '8645782395347271283', '1001', '2025-06-03 16:54:55.603746', '2025-06-03 17:47:10.498493', '8645046787708551164', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271669', '8645782395347271671', '1002', '2025-06-03 11:16:26.202383', '2025-06-03 17:20:39.146225', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271670', '8645782395347271672', '1002', '2025-06-03 11:16:26.201387', '2025-06-03 17:20:39.737597', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271641', '8645782395347271642', '1002', '2025-06-03 12:08:17.687943', '2025-06-03 17:20:40.340462', '8645782395347271651', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271664', '8645782395347271665', '1002', '2025-06-03 11:17:30.078203', '2025-06-03 17:20:40.929668', '8645782395347271668', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271585', '8645782395347271586', '1002', '2025-06-03 14:15:01.327215', '2025-06-03 17:20:41.518918', '8645782395347271589', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271621', '8645782395347271623', '1002', '2025-06-03 12:16:55.783038', '2025-06-03 17:20:42.108635', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271624', '8645782395347271625', '1002', '2025-06-03 12:16:54.935481', '2025-06-03 17:20:42.696751', '8645782395347271628', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271620', '8645782395347271622', '1002', '2025-06-03 12:16:55.783038', '2025-06-03 17:20:43.287603', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271607', '8645782395347271608', '1002', '2025-06-03 14:10:39.88789', '2025-06-03 17:20:43.875863', '8645782395347271611', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271602', '8645782395347271603', '1002', '2025-06-03 14:11:03.217838', '2025-06-03 17:20:44.460387', '8645782395347271606', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591822', '8645924713383591823', '1002', '2025-06-03 10:22:27.538693', '2025-06-03 17:20:46.223657', '8645924713383591832', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271573', '8645782395347271574', '1002', '2025-06-03 14:17:36.739135', '2025-06-03 17:20:47.986318', '8645782395347271580', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271675', '8645782395347271676', '1002', '2025-06-03 11:16:10.332482', '2025-06-03 17:20:48.572559', '8645924713383591797', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271678', '8645782395347271680', '1002', '2025-06-03 11:16:09.719832', '2025-06-03 17:20:49.15994', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271643', '8645782395347271644', '1002', '2025-06-03 12:08:17.230817', '2025-06-03 17:20:49.745434', '8645782395347271654', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271677', '8645782395347271679', '1002', '2025-06-03 11:16:09.72083', '2025-06-03 17:20:50.337105', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645046787708551148', '8645046787708551150', '1002', '2025-06-03 16:57:42.808544', '2025-06-03 17:20:52.684808', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645046787708551146', '8645046787708551147', '1002', '2025-06-03 16:57:43.369774', '2025-06-03 17:20:53.272441', '8645046787708551157', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645046787708551149', '8645046787708551151', '1002', '2025-06-03 16:57:42.807546', '2025-06-03 17:20:53.858907', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591826', '8645924713383591828', '1002', '2025-06-03 10:22:26.540709', '2025-06-03 17:46:14.327109', '8645924713383591841', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214971', '8644989441305214972', '1002', '2025-06-03 17:18:53.744005', '2025-06-03 17:46:14.951149', '8645782395347271657', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645924713383591824', '8645924713383591825', '1002', '2025-06-03 10:22:27.061976', '2025-06-03 17:46:15.568951', '8645924713383591835', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271594', '8645782395347271595', '1002', '2025-06-03 14:12:26.301419', '2025-06-03 17:46:16.183605', '8645782395347271598', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645046787708551162', '8645782395347271291', '1001', '2025-06-03 16:54:55.603746', '2025-06-03 17:47:10.498493', '8645046787708551164', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645046787708551161', '8645782395347271285', '1001', '2025-06-03 16:54:55.604744', '2025-06-03 17:47:10.498493', '8645046787708551164', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214976', '8645924713383591884', '1005', '2025-06-03 17:17:28.975897', '2025-06-03 17:47:10.498493', '8645046787708551164', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214975', '8645924713383591883', '1005', '2025-06-03 17:17:29.126492', '2025-06-03 17:47:10.498493', '8645046787708551164', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214974', '8645924713383591900', '1004', '2025-06-03 17:17:29.300103', '2025-06-03 17:47:10.498493', '8645046787708551164', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645046787708551142', '8645046787708551144', '1002', '2025-06-03 16:57:44.267557', '2025-06-03 17:47:10.498493', '8645046787708551164', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214911', '8644989441305214912', '1002', '2025-06-03 17:21:55.87441', '2025-06-03 17:24:33.25044', '8645782395347271577', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214925', '8644989441305214926', '1002', '2025-06-03 17:21:52.996561', '2025-06-03 17:24:33.868492', '8645782395347271606', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214929', '8644989441305214930', '1002', '2025-06-03 17:21:52.360734', '2025-06-03 17:24:34.483519', '8645782395347271611', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214916', '8644989441305214917', '1002', '2025-06-03 17:21:54.746405', '2025-06-03 17:24:35.100015', '8645782395347271589', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214956', '8644989441305214958', '1002', '2025-06-03 17:21:46.740083', '2025-06-03 17:24:35.71241', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214957', '8644989441305214959', '1002', '2025-06-03 17:21:46.739085', '2025-06-03 17:24:36.328021', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214939', '8644989441305214940', '1002', '2025-06-03 17:21:50.263606', '2025-06-03 17:24:36.938468', '8645782395347271651', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214947', '8644989441305214949', '1002', '2025-06-03 17:21:48.930674', '2025-06-03 17:24:37.55145', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212141', '8642718640556212142', '1002', '2025-06-04 11:44:15.638872', '2025-06-04 11:44:47.854433', '8645782395347271606', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214946', '8644989441305214948', '1002', '2025-06-03 17:21:48.93167', '2025-06-03 17:24:38.78079', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214960', '8644989441305214961', '1002', '2025-06-03 17:21:45.79568', '2025-06-03 17:24:39.395868', '8645924713383591832', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214832', '8644989441305214834', '1002', '2025-06-03 17:26:32.667774', '2025-06-04 10:19:26.251667', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214831', '8644989441305214833', '1002', '2025-06-03 17:26:32.667774', '2025-06-04 10:19:26.884972', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214897', '8644989441305214898', '1002', '2025-06-03 17:21:58.370083', '2025-06-03 17:24:41.264403', '8645046787708551157', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214931', '8644989441305214932', '1002', '2025-06-03 17:21:51.823855', '2025-06-03 17:24:41.886291', '8645782395347271628', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214933', '8644989441305214935', '1002', '2025-06-03 17:21:51.287926', '2025-06-03 17:24:42.49955', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214922', '8644989441305214923', '1002', '2025-06-03 17:21:53.582461', '2025-06-03 17:24:43.110809', '8645782395347271601', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214934', '8644989441305214936', '1002', '2025-06-03 17:21:51.287926', '2025-06-03 17:24:43.723593', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214817', '8644989441305214818', '1002', '2025-06-03 17:28:53.262556', '2025-06-03 17:46:22.983088', '8645924713383591841', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214951', '8644989441305214952', '1002', '2025-06-03 17:21:47.94463', '2025-06-03 17:24:44.94469', '8645924713383591797', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214953', '8644989441305214954', '1002', '2025-06-03 17:21:47.408481', '2025-06-03 17:24:46.181355', '8645782395347271668', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416786', '8642660435159416787', '1002', '2025-06-04 14:10:43.106864', '2025-06-04 14:17:20.51509', '8645782395347271589', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214943', '8644989441305214944', '1002', '2025-06-03 17:21:49.553656', '2025-06-03 17:24:47.434724', '8645782395347271654', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214913', '8644989441305214914', '1002', '2025-06-03 17:21:55.341634', '2025-06-03 17:24:48.05953', '8645782395347271580', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214822', '8644989441305214823', '1002', '2025-06-03 17:26:34.186439', '2025-06-04 10:19:27.507868', '8645046787708551157', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214906', '8644989441305214908', '1002', '2025-06-03 17:21:56.809228', '2025-06-03 17:24:49.291187', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214907', '8644989441305214909', '1002', '2025-06-03 17:21:56.809228', '2025-06-03 17:24:49.913671', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416794', '8642660435159416795', '1002', '2025-06-04 14:10:41.617208', '2025-06-04 14:17:21.10645', '8645782395347271606', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416823', '8642660435159416825', '1002', '2025-06-04 14:10:30.293151', '2025-06-04 14:17:22.289051', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416790', '8642660435159416791', '1002', '2025-06-04 14:10:42.397122', '2025-06-04 14:17:22.879694', '8645782395347271601', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416824', '8642660435159416826', '1002', '2025-06-04 14:10:30.293151', '2025-06-04 14:17:23.463127', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416809', '8642660435159416810', '1002', '2025-06-04 14:10:38.351052', '2025-06-04 14:17:24.043306', '8645782395347271651', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416819', '8642660435159416820', '1002', '2025-06-04 14:10:36.039804', '2025-06-04 14:17:25.804944', '8645924713383591797', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416781', '8642660435159416782', '1002', '2025-06-04 14:10:43.88073', '2025-06-04 14:17:26.385985', '8645782395347271580', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416813', '8642660435159416814', '1002', '2025-06-04 14:10:37.619686', '2025-06-04 14:17:26.967537', '8645782395347271654', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416816', '8642660435159416818', '1002', '2025-06-04 14:10:37.008436', '2025-06-04 14:17:27.544698', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416748', '8642660435159416749', '1002', '2025-06-04 14:10:49.869199', '2025-06-04 14:17:28.128846', '8644945289041412083', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416815', '8642660435159416817', '1002', '2025-06-04 14:10:37.008436', '2025-06-04 14:17:28.72661', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416801', '8642660435159416802', '1002', '2025-06-04 14:10:40.080453', '2025-06-04 14:17:29.302015', '8645782395347271628', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416804', '8642660435159416806', '1002', '2025-06-04 14:10:39.459598', '2025-06-04 14:17:29.882879', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214903', '8644989441305214905', '1002', '2025-06-03 17:21:57.702419', '2025-06-03 17:47:10.498493', '8645046787708551164', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214902', '8644989441305214904', '1002', '2025-06-03 17:21:57.702419', '2025-06-03 17:47:10.498493', '8645046787708551164', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416803', '8642660435159416805', '1002', '2025-06-04 14:10:39.459598', '2025-06-04 14:17:30.459343', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214827', '8644989441305214829', '1002', '2025-06-03 17:26:33.542303', '2025-06-04 10:19:28.126214', '8645046787708551164', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271499', '8645924713383591900', '1004', '2025-06-03 14:26:28.173752', '2025-06-03 17:46:14.327109', '8645924713383591841', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271498', '8645924713383591860', '1004', '2025-06-03 14:26:28.307188', '2025-06-03 17:46:14.327109', '8645924713383591841', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214965', '8644989441305214966', '1002', '2025-06-03 17:21:44.700846', '2025-06-03 17:46:14.327109', '8645924713383591841', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214890', '8644989441305214891', '1002', '2025-06-03 17:26:21.012797', '2025-06-03 17:46:14.327109', '8645924713383591841', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214895', '8644989441305214896', '1002', '2025-06-03 17:21:58.859946', '2025-06-03 17:47:11.096655', '8645046787708551154', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271563', '8645782395347271570', '1004', '2025-06-03 14:20:50.860507', '2025-06-03 17:46:14.951149', '8645782395347271657', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271510', '8645782395347271530', '1005', '2025-06-03 14:23:03.228196', '2025-06-03 17:46:14.951149', '8645782395347271657', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214859', '8644989441305214861', '1002', '2025-06-03 17:26:27.371976', '2025-06-04 10:39:26.983919', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214847', '8644989441305214848', '1002', '2025-06-03 17:26:29.57181', '2025-06-04 10:19:29.983803', '8645782395347271601', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214828', '8644989441305214830', '1002', '2025-06-03 17:26:33.542303', '2025-06-03 17:47:11.698356', '8645046787708551164', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214820', '8644989441305214821', '1002', '2025-06-03 17:26:34.666881', '2025-06-03 17:47:12.296225', '8645046787708551154', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214871', '8644989441305214873', '1002', '2025-06-03 17:26:25.111769', '2025-06-04 10:19:30.611125', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214872', '8644989441305214874', '1002', '2025-06-03 17:26:25.11077', '2025-06-04 10:19:31.232452', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214876', '8644989441305214877', '1002', '2025-06-03 17:26:24.144004', '2025-06-04 10:19:31.844691', '8645924713383591797', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214885', '8644989441305214886', '1002', '2025-06-03 17:26:22.063593', '2025-06-04 10:19:32.457035', '8645924713383591832', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214858', '8644989441305214860', '1002', '2025-06-03 17:26:27.371976', '2025-06-04 10:39:27.588886', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214856', '8644989441305214857', '1002', '2025-06-03 17:26:27.885082', '2025-06-04 10:39:28.194924', '8645782395347271628', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416738', '8642660435159416739', '1002', '2025-06-04 14:15:59.198425', '2025-06-04 14:17:31.043482', '8645782395347271577', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416821', '8642660435159416822', '1002', '2025-06-04 14:10:35.485632', '2025-06-04 14:17:31.631715', '8645782395347271668', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416827', '8642660435159416828', '1002', '2025-06-04 14:10:29.292825', '2025-06-04 14:17:32.211875', '8645924713383591832', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271503', '8645924713383591893', '1005', '2025-06-03 14:26:25.012958', '2025-06-03 17:46:14.951149', '8645782395347271657', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271502', '8645924713383591900', '1004', '2025-06-03 14:26:25.25161', '2025-06-03 17:46:14.951149', '8645782395347271657', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214967', '8644989441305214968', '1002', '2025-06-03 17:21:44.150847', '2025-06-03 17:46:14.951149', '8645782395347271657', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214892', '8644989441305214893', '1002', '2025-06-03 17:26:20.484747', '2025-06-03 17:46:14.951149', '8645782395347271657', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214813', '8644989441305214814', '1002', '2025-06-03 17:28:58.495936', '2025-06-03 17:46:14.951149', '8645782395347271657', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271497', '8645924713383591893', '1005', '2025-06-03 14:26:29.070711', '2025-06-03 17:46:15.568951', '8645924713383591835', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271496', '8645924713383591862', '1005', '2025-06-03 14:26:29.205696', '2025-06-03 17:46:15.568951', '8645924713383591835', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271495', '8645924713383591900', '1004', '2025-06-03 14:26:29.387708', '2025-06-03 17:46:15.568951', '8645924713383591835', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271494', '8645924713383591860', '1004', '2025-06-03 14:26:29.522834', '2025-06-03 17:46:15.568951', '8645924713383591835', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214962', '8644989441305214963', '1002', '2025-06-03 17:21:45.289503', '2025-06-03 17:46:15.568951', '8645924713383591835', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271545', '8645782395347271569', '1004', '2025-06-03 14:20:53.293829', '2025-06-03 17:46:16.183605', '8645782395347271598', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645782395347271520', '8645782395347271531', '1005', '2025-06-03 14:23:01.845384', '2025-06-03 17:46:16.183605', '8645782395347271598', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214919', '8644989441305214920', '1002', '2025-06-03 17:21:54.158807', '2025-06-03 17:46:16.183605', '8645782395347271598', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214887', '8644989441305214888', '1002', '2025-06-03 17:26:21.576674', '2025-06-03 17:46:21.755007', '8645924713383591835', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214844', '8644989441305214845', '1002', '2025-06-03 17:26:30.123891', '2025-06-03 17:46:22.372787', '8645782395347271598', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645046787708551143', '8645046787708551145', '1002', '2025-06-03 16:57:44.267557', '2025-06-03 17:47:10.498493', '8645046787708551164', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645046787708551153', '8645782395347271282', '1001', '2025-06-03 16:57:22.962623', '2025-06-03 17:47:11.096655', '8645046787708551154', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645046787708551152', '8645782395347271280', '1001', '2025-06-03 16:57:22.962623', '2025-06-03 17:47:11.096655', '8645046787708551154', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214973', '8645924713383591900', '1004', '2025-06-03 17:17:30.718493', '2025-06-03 17:47:11.096655', '8645046787708551154', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645046787708551135', '8645046787708551136', '1002', '2025-06-03 16:57:45.103878', '2025-06-03 17:47:11.096655', '8645046787708551154', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644945289041412095', '8645782395347271291', '1001', '2025-06-03 17:47:43.495073', '2025-06-03 17:47:43.495073', '8644945289041412096', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644945289041412094', '8645782395347271285', '1001', '2025-06-03 17:47:43.498064', '2025-06-03 17:47:43.498064', '8644945289041412096', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644945289041412093', '8645782395347271283', '1001', '2025-06-03 17:47:43.498064', '2025-06-03 17:47:43.498064', '8644945289041412096', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644945289041412091', '8645782395347271282', '1001', '2025-06-03 17:47:54.138852', '2025-06-03 17:47:54.138852', '8644945289041412092', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644945289041412090', '8645782395347271280', '1001', '2025-06-03 17:47:54.138852', '2025-06-03 17:47:54.138852', '8644945289041412092', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644945289041412088', '8645782395347271661', '1001', '2025-06-03 17:48:05.244578', '2025-06-03 17:48:05.244578', '8644945289041412089', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644945289041412087', '8645782395347271660', '1001', '2025-06-03 17:48:05.245575', '2025-06-03 17:48:05.245575', '8644945289041412089', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644945289041412085', '8645924713383591847', '1001', '2025-06-03 17:48:13.354425', '2025-06-03 17:48:13.354425', '8644945289041412086', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644945289041412084', '8645924713383591855', '1001', '2025-06-03 17:48:13.355425', '2025-06-03 17:48:13.355425', '8644945289041412086', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644945289041412082', '8645924713383591836', '1001', '2025-06-03 17:48:19.924674', '2025-06-03 17:48:19.924674', '8644945289041412083', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644945289041412081', '8645924713383591853', '1001', '2025-06-03 17:48:19.924674', '2025-06-03 17:48:19.924674', '8644945289041412083', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644945289041412079', '8645782395347271612', '1001', '2025-06-03 17:48:27.167443', '2025-06-03 17:48:27.167443', '8644945289041412080', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644945289041412078', '8645782395347271613', '1001', '2025-06-03 17:48:27.167443', '2025-06-03 17:48:27.167443', '8644945289041412080', 0, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644945289041412067', '8644945289041412068', '1002', '2025-06-03 17:48:45.401586', '2025-06-03 17:51:16.541213', '8644945289041412086', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644945289041412071', '8644945289041412072', '1002', '2025-06-03 17:48:44.672878', '2025-06-03 17:51:17.145329', '8644945289041412089', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644945289041412054', '8644945289041412055', '1002', '2025-06-03 17:51:32.686463', '2025-06-04 09:49:56.679754', '8644945289041412089', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642946617420283903', '8642946617420283904', '1002', '2025-06-04 09:50:39.437988', '2025-06-04 09:51:13.176972', '8644945289041412089', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642946617420283898', '8642946617420283899', '1002', '2025-06-04 09:53:39.809899', '2025-06-04 09:55:06.498662', '8644945289041412089', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644945289041412076', '8644945289041412077', '1002', '2025-06-03 17:48:43.511352', '2025-06-04 10:19:28.743303', '8644945289041412096', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644945289041412074', '8644945289041412075', '1002', '2025-06-03 17:48:44.04735', '2025-06-04 10:19:29.363889', '8644945289041412092', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214864', '8644989441305214865', '1002', '2025-06-03 17:26:26.393308', '2025-06-04 10:19:33.078069', '8645782395347271651', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642933182762582015', '8642933182762582016', '1002', '2025-06-04 09:55:48.566451', '2025-06-04 10:19:33.688988', '8644945289041412089', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644945289041412057', '8644945289041412058', '1002', '2025-06-03 17:51:25.865959', '2025-06-04 10:19:34.29842', '8644945289041412086', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214868', '8644989441305214869', '1002', '2025-06-03 17:26:25.716922', '2025-06-04 10:19:34.913692', '8645782395347271654', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644945289041412063', '8644945289041412064', '1002', '2025-06-03 17:48:46.020378', '2025-06-04 10:19:35.529803', '8644945289041412083', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214838', '8644989441305214839', '1002', '2025-06-03 17:26:31.264105', '2025-06-04 10:19:36.139018', '8645782395347271580', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214850', '8644989441305214851', '1002', '2025-06-03 17:26:29.011618', '2025-06-04 10:19:36.748943', '8645782395347271606', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644945289041412060', '8644945289041412061', '1002', '2025-06-03 17:48:46.587684', '2025-06-04 10:19:37.363592', '8644945289041412080', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214854', '8644989441305214855', '1002', '2025-06-03 17:26:28.403437', '2025-06-04 10:19:37.99846', '8645782395347271611', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214841', '8644989441305214842', '1002', '2025-06-03 17:26:30.682219', '2025-06-04 10:19:38.621964', '8645782395347271589', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214836', '8644989441305214837', '1002', '2025-06-03 17:26:31.775193', '2025-06-04 10:19:39.22965', '8645782395347271577', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214882', '8644989441305214884', '1002', '2025-06-03 17:26:22.97425', '2025-06-04 10:19:39.83697', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214878', '8644989441305214879', '1002', '2025-06-03 17:26:23.622979', '2025-06-04 10:19:40.456732', '8645782395347271668', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8644989441305214881', '8644989441305214883', '1002', '2025-06-03 17:26:22.975247', '2025-06-04 10:19:41.067611', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212138', '8642718640556212139', '1002', '2025-06-04 11:45:06.719202', '2025-06-04 11:49:36.005216', '8645782395347271606', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416766', '8642660435159416768', '1002', '2025-06-04 14:10:47.004119', '2025-06-04 14:17:32.784157', '8644945289041412096', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416767', '8642660435159416769', '1002', '2025-06-04 14:10:47.004119', '2025-06-04 14:17:33.366116', '8644945289041412096', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416760', '8642660435159416761', '1002', '2025-06-04 14:10:47.782303', '2025-06-04 14:17:33.952861', '8644945289041412092', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416772', '8642660435159416774', '1002', '2025-06-04 14:10:45.544821', '2025-06-04 14:17:34.532475', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416770', '8642660435159416771', '1002', '2025-06-04 14:10:46.044484', '2025-06-04 14:17:35.104019', '8645046787708551157', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642660435159416773', '8642660435159416775', '1002', '2025-06-04 14:10:45.543823', '2025-06-04 14:17:35.676881', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507392', '8642875801999507393', '1002', '2025-06-04 10:22:34.527437', '2025-06-04 10:31:42.386757', '8644945289041412083', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507444', '8642875801999507446', '1002', '2025-06-04 10:22:22.581899', '2025-06-04 10:39:14.189163', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507386', '8642875801999507387', '1002', '2025-06-04 10:31:57.707151', '2025-06-04 10:39:14.804143', '8644945289041412083', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507443', '8642875801999507445', '1002', '2025-06-04 10:22:22.583902', '2025-06-04 10:39:15.414437', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507455', '8642875801999507456', '1002', '2025-06-04 10:22:19.48393', '2025-06-04 10:39:16.024966', '8645924713383591832', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507407', '8642875801999507409', '1002', '2025-06-04 10:22:31.184543', '2025-06-04 10:39:16.633591', '8644945289041412096', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507408', '8642875801999507410', '1002', '2025-06-04 10:22:31.183573', '2025-06-04 10:39:17.24405', '8644945289041412096', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507402', '8642875801999507403', '1002', '2025-06-04 10:22:31.917539', '2025-06-04 10:39:17.85319', '8644945289041412092', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507389', '8642875801999507390', '1002', '2025-06-04 10:22:35.110602', '2025-06-04 10:39:18.461202', '8644945289041412080', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507418', '8642875801999507419', '1002', '2025-06-04 10:22:28.855404', '2025-06-04 10:39:19.071428', '8645782395347271577', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507423', '8642875801999507424', '1002', '2025-06-04 10:22:27.71479', '2025-06-04 10:39:19.684455', '8645782395347271589', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507399', '8642875801999507400', '1002', '2025-06-04 10:22:32.557025', '2025-06-04 10:39:20.295418', '8644945289041412089', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507395', '8642875801999507396', '1002', '2025-06-04 10:22:33.925544', '2025-06-04 10:39:20.907968', '8644945289041412086', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507447', '8642875801999507448', '1002', '2025-06-04 10:22:21.643172', '2025-06-04 10:39:21.515047', '8645924713383591797', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507441', '8642875801999507442', '1002', '2025-06-04 10:22:23.133727', '2025-06-04 10:39:22.124425', '8645782395347271654', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507420', '8642875801999507421', '1002', '2025-06-04 10:22:28.31135', '2025-06-04 10:39:22.736551', '8645782395347271580', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507452', '8642875801999507454', '1002', '2025-06-04 10:22:20.480715', '2025-06-04 10:39:23.342399', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507437', '8642875801999507438', '1002', '2025-06-04 10:22:23.869568', '2025-06-04 10:39:23.948487', '8645782395347271651', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507449', '8642875801999507450', '1002', '2025-06-04 10:22:21.085972', '2025-06-04 10:39:24.556251', '8645782395347271668', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507414', '8642875801999507416', '1002', '2025-06-04 10:22:29.813756', '2025-06-04 10:39:25.163518', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507413', '8642875801999507415', '1002', '2025-06-04 10:22:29.813756', '2025-06-04 10:39:25.772483', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507411', '8642875801999507412', '1002', '2025-06-04 10:22:30.315613', '2025-06-04 10:39:26.378265', '8645046787708551157', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507433', '8642875801999507434', '1002', '2025-06-04 10:22:25.859163', '2025-06-04 10:39:28.799531', '8645782395347271611', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507451', '8642875801999507453', '1002', '2025-06-04 10:22:20.48271', '2025-06-04 10:39:29.407639', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507426', '8642875801999507427', '1002', '2025-06-04 10:22:27.113323', '2025-06-04 10:39:30.013328', '8645782395347271601', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507429', '8642875801999507430', '1002', '2025-06-04 10:22:26.508715', '2025-06-04 10:39:30.616611', '8645782395347271606', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212200', '8642718640556212202', '1002', '2025-06-04 11:41:27.538823', '2025-06-04 11:49:33.621434', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212197', '8642718640556212198', '1002', '2025-06-04 11:41:28.059726', '2025-06-04 11:49:34.216545', '8645782395347271628', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212219', '8642718640556212221', '1002', '2025-06-04 11:41:22.828162', '2025-06-04 11:49:36.597448', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212220', '8642718640556212222', '1002', '2025-06-04 11:41:22.827165', '2025-06-04 11:49:37.187504', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212205', '8642718640556212206', '1002', '2025-06-04 11:41:26.371787', '2025-06-04 11:49:37.772341', '8645782395347271651', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212217', '8642718640556212218', '1002', '2025-06-04 11:41:23.425566', '2025-06-04 11:49:38.363783', '8645782395347271668', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212209', '8642718640556212210', '1002', '2025-06-04 11:41:25.456237', '2025-06-04 11:49:40.714982', '8645782395347271654', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212145', '8642718640556212146', '1002', '2025-06-04 11:41:37.49447', '2025-06-04 11:49:43.671522', '8644945289041412080', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212188', '8642718640556212189', '1002', '2025-06-04 11:41:29.911573', '2025-06-04 11:49:44.255959', '8645782395347271601', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212199', '8642718640556212201', '1002', '2025-06-04 11:41:27.538823', '2025-06-04 11:49:44.845523', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212223', '8642718640556212224', '1002', '2025-06-04 11:41:21.887755', '2025-06-04 11:49:45.429959', '8645924713383591832', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212212', '8642718640556212214', '1002', '2025-06-04 11:41:24.902613', '2025-06-04 11:49:46.022376', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212211', '8642718640556212213', '1002', '2025-06-04 11:41:24.902613', '2025-06-04 11:49:46.612101', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212215', '8642718640556212216', '1002', '2025-06-04 11:41:23.984071', '2025-06-04 11:49:47.213948', '8645924713383591797', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212173', '8642718640556212175', '1002', '2025-06-04 11:41:32.763327', '2025-06-04 11:49:47.811119', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212172', '8642718640556212174', '1002', '2025-06-04 11:41:32.764325', '2025-06-04 11:49:48.400503', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642718640556212170', '8642718640556212171', '1002', '2025-06-04 11:41:33.250061', '2025-06-04 11:49:48.986788', '8645046787708551157', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507330', '8642875801999507332', '1002', '2025-06-04 10:40:00.193693', '2025-06-04 10:47:21.559093', '8644945289041412096', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507329', '8642875801999507331', '1002', '2025-06-04 10:40:00.19473', '2025-06-04 10:47:22.142445', '8644945289041412096', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507323', '8642875801999507324', '1002', '2025-06-04 10:40:00.9309', '2025-06-04 10:47:22.724363', '8644945289041412092', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507348', '8642875801999507349', '1002', '2025-06-04 10:39:56.246246', '2025-06-04 10:47:23.30631', '8645782395347271601', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507359', '8642875801999507361', '1002', '2025-06-04 10:39:53.987534', '2025-06-04 10:47:23.88323', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507383', '8642875801999507384', '1002', '2025-06-04 10:39:48.853624', '2025-06-04 10:47:24.461126', '8645924713383591832', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507375', '8642875801999507376', '1002', '2025-06-04 10:39:50.877793', '2025-06-04 10:47:25.039729', '8645924713383591797', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507372', '8642875801999507374', '1002', '2025-06-04 10:39:51.76375', '2025-06-04 10:47:25.630679', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507371', '8642875801999507373', '1002', '2025-06-04 10:39:51.76375', '2025-06-04 10:47:26.213099', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507380', '8642875801999507382', '1002', '2025-06-04 10:39:49.781979', '2025-06-04 10:47:26.797535', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507365', '8642875801999507366', '1002', '2025-06-04 10:39:52.985158', '2025-06-04 10:47:27.37933', '8645782395347271651', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507313', '8642875801999507314', '1002', '2025-06-04 10:40:02.792392', '2025-06-04 10:47:27.956523', '8644945289041412083', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507320', '8642875801999507321', '1002', '2025-06-04 10:40:01.547103', '2025-06-04 10:47:28.550353', '8644945289041412089', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507342', '8642875801999507343', '1002', '2025-06-04 10:39:57.389821', '2025-06-04 10:47:29.142381', '8645782395347271580', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507316', '8642875801999507317', '1002', '2025-06-04 10:40:02.214521', '2025-06-04 10:47:29.737787', '8644945289041412086', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507377', '8642875801999507378', '1002', '2025-06-04 10:39:50.351081', '2025-06-04 10:47:30.322225', '8645782395347271668', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507369', '8642875801999507370', '1002', '2025-06-04 10:39:52.292083', '2025-06-04 10:47:30.904658', '8645782395347271654', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507357', '8642875801999507358', '1002', '2025-06-04 10:39:54.512009', '2025-06-04 10:47:31.478475', '8645782395347271628', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507360', '8642875801999507362', '1002', '2025-06-04 10:39:53.987534', '2025-06-04 10:47:32.049912', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507340', '8642875801999507341', '1002', '2025-06-04 10:39:57.913957', '2025-06-04 10:47:32.623024', '8645782395347271577', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507345', '8642875801999507346', '1002', '2025-06-04 10:39:56.819002', '2025-06-04 10:47:33.197376', '8645782395347271589', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507351', '8642875801999507352', '1002', '2025-06-04 10:39:55.666709', '2025-06-04 10:47:33.768356', '8645782395347271606', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507355', '8642875801999507356', '1002', '2025-06-04 10:39:55.047137', '2025-06-04 10:47:34.344637', '8645782395347271611', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507310', '8642875801999507311', '1002', '2025-06-04 10:40:03.35856', '2025-06-04 10:47:34.916203', '8644945289041412080', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507379', '8642875801999507381', '1002', '2025-06-04 10:39:49.781979', '2025-06-04 10:47:35.489109', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507336', '8642875801999507338', '1002', '2025-06-04 10:39:58.834342', '2025-06-04 10:47:36.059832', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507335', '8642875801999507337', '1002', '2025-06-04 10:39:58.834342', '2025-06-04 10:47:36.633861', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507333', '8642875801999507334', '1002', '2025-06-04 10:39:59.314784', '2025-06-04 10:47:37.206893', '8645046787708551157', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507279', '8642875801999507280', '1002', '2025-06-04 10:47:47.724071', '2025-06-04 10:58:38.791008', '8645782395347271611', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507269', '8642875801999507270', '1002', '2025-06-04 10:47:49.440495', '2025-06-04 10:58:39.375345', '8645782395347271589', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507264', '8642875801999507265', '1002', '2025-06-04 10:47:50.495963', '2025-06-04 10:58:39.964347', '8645782395347271577', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507275', '8642875801999507276', '1002', '2025-06-04 10:47:48.326515', '2025-06-04 10:58:40.548749', '8645782395347271606', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507232', '8642875801999507233', '1002', '2025-06-04 10:47:56.077632', '2025-06-04 10:58:41.130201', '8644945289041412080', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507303', '8642875801999507305', '1002', '2025-06-04 10:47:42.725837', '2025-06-04 10:58:41.706608', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507304', '8642875801999507306', '1002', '2025-06-04 10:47:42.725837', '2025-06-04 10:58:42.288514', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507289', '8642875801999507290', '1002', '2025-06-04 10:47:45.769403', '2025-06-04 10:58:42.864674', '8645782395347271651', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507301', '8642875801999507302', '1002', '2025-06-04 10:47:43.268449', '2025-06-04 10:58:43.442265', '8645782395347271668', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507240', '8642875801999507241', '1002', '2025-06-04 10:47:54.826579', '2025-06-04 10:58:44.017115', '8644945289041412086', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507244', '8642875801999507245', '1002', '2025-06-04 10:47:54.176898', '2025-06-04 10:58:44.593298', '8644945289041412089', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507293', '8642875801999507294', '1002', '2025-06-04 10:47:45.106578', '2025-06-04 10:58:45.166279', '8645782395347271654', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507266', '8642875801999507267', '1002', '2025-06-04 10:47:49.9878', '2025-06-04 10:58:45.741394', '8645782395347271580', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507236', '8642875801999507237', '1002', '2025-06-04 10:47:55.454521', '2025-06-04 10:58:46.316432', '8644945289041412083', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507272', '8642875801999507273', '1002', '2025-06-04 10:47:48.88864', '2025-06-04 10:58:46.890482', '8645782395347271601', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507283', '8642875801999507285', '1002', '2025-06-04 10:47:46.723716', '2025-06-04 10:58:47.465296', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507307', '8642875801999507308', '1002', '2025-06-04 10:47:41.848712', '2025-06-04 10:58:48.044971', '8645924713383591832', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507299', '8642875801999507300', '1002', '2025-06-04 10:47:43.769788', '2025-06-04 10:58:48.621303', '8645924713383591797', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507296', '8642875801999507298', '1002', '2025-06-04 10:47:44.605593', '2025-06-04 10:58:49.195015', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507295', '8642875801999507297', '1002', '2025-06-04 10:47:44.605593', '2025-06-04 10:58:49.76863', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642698677548220392', '8642698677548220394', '1002', '2025-06-04 11:50:38.087506', '2025-06-04 14:10:00.733196', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640627', '8642391707645640628', '1002', '2025-06-04 14:20:29.025374', '2025-06-04 14:25:47.297687', '8644945289041412083', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640639', '8642391707645640640', '1002', '2025-06-04 14:20:26.89845', '2025-06-04 14:26:46.450909', '8644945289041412092', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640649', '8642391707645640650', '1002', '2025-06-04 14:20:25.174203', '2025-06-04 14:39:42.12229', '8645046787708551157', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640651', '8642391707645640653', '1002', '2025-06-04 14:20:24.681779', '2025-06-04 14:39:42.762506', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640652', '8642391707645640654', '1002', '2025-06-04 14:20:24.681779', '2025-06-04 14:39:43.390917', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640646', '8642391707645640648', '1002', '2025-06-04 14:20:26.12964', '2025-06-04 14:39:44.019381', '8644945289041412096', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640645', '8642391707645640647', '1002', '2025-06-04 14:20:26.12964', '2025-06-04 14:39:44.642997', '8644945289041412096', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640659', '8642391707645640660', '1002', '2025-06-04 14:20:23.075253', '2025-06-04 14:39:46.555113', '8645782395347271580', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640656', '8642391707645640657', '1002', '2025-06-04 14:20:23.708692', '2025-06-04 14:39:47.183693', '8645782395347271577', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640635', '8642391707645640636', '1002', '2025-06-04 14:20:27.608848', '2025-06-04 14:39:47.81171', '8644945289041412089', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895732', '8642348861051895733', '1002', '2025-06-04 14:40:53.175469', '2025-06-04 14:45:23.500727', '8644945289041412086', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338209', '8642197643843338210', '1002', '2025-06-04 15:55:07.242689', '2025-06-04 16:39:19.147085', '8645782395347271628', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507284', '8642875801999507286', '1002', '2025-06-04 10:47:46.723716', '2025-06-04 10:58:50.343766', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507281', '8642875801999507282', '1002', '2025-06-04 10:47:47.218984', '2025-06-04 10:58:50.920819', '8645782395347271628', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507254', '8642875801999507256', '1002', '2025-06-04 10:47:52.883136', '2025-06-04 10:58:51.496821', '8644945289041412096', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507253', '8642875801999507255', '1002', '2025-06-04 10:47:52.884102', '2025-06-04 10:58:52.072154', '8644945289041412096', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507247', '8642875801999507248', '1002', '2025-06-04 10:47:53.585784', '2025-06-04 10:58:52.649181', '8644945289041412092', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507260', '8642875801999507262', '1002', '2025-06-04 10:47:51.490304', '2025-06-04 10:59:05.000528', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507259', '8642875801999507261', '1002', '2025-06-04 10:47:51.490304', '2025-06-04 10:59:05.587776', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507257', '8642875801999507258', '1002', '2025-06-04 10:47:52.010908', '2025-06-04 10:59:06.165134', '8645046787708551157', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507189', '8642875801999507190', '1002', '2025-06-04 10:59:16.098152', '2025-06-04 11:03:14.356222', '8645782395347271589', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507196', '8642875801999507197', '1002', '2025-06-04 10:59:14.896272', '2025-06-04 11:03:14.96016', '8645782395347271606', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507152', '8642875801999507153', '1002', '2025-06-04 10:59:22.566481', '2025-06-04 11:03:15.567674', '8644945289041412080', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507224', '8642875801999507226', '1002', '2025-06-04 10:59:09.277711', '2025-06-04 11:03:16.1684', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507173', '8642875801999507175', '1002', '2025-06-04 10:59:19.379252', '2025-06-04 11:03:16.767427', '8644945289041412096', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507174', '8642875801999507176', '1002', '2025-06-04 10:59:19.379252', '2025-06-04 11:03:17.365408', '8644945289041412096', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507167', '8642875801999507168', '1002', '2025-06-04 10:59:20.082466', '2025-06-04 11:03:17.963752', '8644945289041412092', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507193', '8642875801999507194', '1002', '2025-06-04 10:59:15.490776', '2025-06-04 11:03:18.564809', '8645782395347271601', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507204', '8642875801999507206', '1002', '2025-06-04 10:59:13.28487', '2025-06-04 11:03:19.170322', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507228', '8642875801999507229', '1002', '2025-06-04 10:59:08.395821', '2025-06-04 11:03:19.771513', '8645924713383591832', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507216', '8642875801999507218', '1002', '2025-06-04 10:59:11.161448', '2025-06-04 11:03:20.374202', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507220', '8642875801999507221', '1002', '2025-06-04 10:59:10.328161', '2025-06-04 11:03:20.969119', '8645924713383591797', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507217', '8642875801999507219', '1002', '2025-06-04 10:59:11.160446', '2025-06-04 11:03:21.567694', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507225', '8642875801999507227', '1002', '2025-06-04 10:59:09.277711', '2025-06-04 11:03:22.162821', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507222', '8642875801999507223', '1002', '2025-06-04 10:59:09.825336', '2025-06-04 11:03:22.76533', '8645782395347271668', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507214', '8642875801999507215', '1002', '2025-06-04 10:59:11.65831', '2025-06-04 11:03:23.368182', '8645782395347271654', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507210', '8642875801999507211', '1002', '2025-06-04 10:59:12.326408', '2025-06-04 11:03:23.966706', '8645782395347271651', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507160', '8642875801999507161', '1002', '2025-06-04 10:59:21.310182', '2025-06-04 11:03:24.565797', '8644945289041412086', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507186', '8642875801999507187', '1002', '2025-06-04 10:59:16.64332', '2025-06-04 11:03:25.161551', '8645782395347271580', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507164', '8642875801999507165', '1002', '2025-06-04 10:59:20.673884', '2025-06-04 11:03:25.763215', '8644945289041412089', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507156', '8642875801999507157', '1002', '2025-06-04 10:59:21.949472', '2025-06-04 11:03:26.359822', '8644945289041412083', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507202', '8642875801999507203', '1002', '2025-06-04 10:59:13.780399', '2025-06-04 11:03:26.955749', '8645782395347271628', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507205', '8642875801999507207', '1002', '2025-06-04 10:59:13.283872', '2025-06-04 11:03:27.557432', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507200', '8642875801999507201', '1002', '2025-06-04 10:59:14.286774', '2025-06-04 11:03:28.156985', '8645782395347271611', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507184', '8642875801999507185', '1002', '2025-06-04 10:59:17.13932', '2025-06-04 11:03:28.753975', '8645782395347271577', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507180', '8642875801999507182', '1002', '2025-06-04 10:59:18.015975', '2025-06-04 11:03:29.355078', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507179', '8642875801999507181', '1002', '2025-06-04 10:59:18.015975', '2025-06-04 11:03:29.951139', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507177', '8642875801999507178', '1002', '2025-06-04 10:59:18.490706', '2025-06-04 11:03:30.546099', '8645046787708551157', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642698677548220344', '8642698677548220345', '1002', '2025-06-04 11:50:46.856811', '2025-06-04 12:05:13.097875', '8644945289041412086', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640617', '8642391707645640618', '1002', '2025-06-04 14:28:40.665265', '2025-06-04 14:31:32.888064', '8644945289041412092', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895721', '8642348861051895722', '1002', '2025-06-04 14:47:00.710279', '2025-06-04 14:54:17.041074', '8644945289041412086', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642272238835335167', '8642272238835335168', '1002', '2025-06-04 15:16:10.576511', '2025-06-04 15:19:44.331469', '8644945289041412086', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642272238835335162', '8642272238835335163', '1002', '2025-06-04 15:21:10.490029', '2025-06-04 15:21:40.576651', '8644945289041412086', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895775', '8642348861051895776', '1002', '2025-06-04 14:40:45.311059', '2025-06-04 15:54:33.983183', '8645782395347271611', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895799', '8642348861051895801', '1002', '2025-06-04 14:40:39.84764', '2025-06-04 15:54:34.587921', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895763', '8642348861051895764', '1002', '2025-06-04 14:40:47.375771', '2025-06-04 15:54:35.197855', '8645782395347271589', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895771', '8642348861051895772', '1002', '2025-06-04 14:40:45.993288', '2025-06-04 15:54:35.808379', '8645782395347271606', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895767', '8642348861051895768', '1002', '2025-06-04 14:40:46.692539', '2025-06-04 15:54:36.414143', '8645782395347271601', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895800', '8642348861051895802', '1002', '2025-06-04 14:40:39.846642', '2025-06-04 15:54:37.020317', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895785', '8642348861051895786', '1002', '2025-06-04 14:40:43.171488', '2025-06-04 15:54:37.621247', '8645782395347271651', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895797', '8642348861051895798', '1002', '2025-06-04 14:40:40.442018', '2025-06-04 15:54:38.220009', '8645782395347271668', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895795', '8642348861051895796', '1002', '2025-06-04 14:40:40.99396', '2025-06-04 15:54:38.823001', '8645924713383591797', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895789', '8642348861051895790', '1002', '2025-06-04 14:40:42.450706', '2025-06-04 15:54:39.424765', '8645782395347271654', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895792', '8642348861051895794', '1002', '2025-06-04 14:40:41.907644', '2025-06-04 15:54:40.024665', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895791', '8642348861051895793', '1002', '2025-06-04 14:40:41.908642', '2025-06-04 15:54:40.623595', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895803', '8642348861051895804', '1002', '2025-06-04 14:40:38.860146', '2025-06-04 15:54:41.224749', '8645924713383591832', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895759', '8642348861051895760', '1002', '2025-06-04 14:40:48.076578', '2025-06-04 15:54:41.828672', '8645782395347271580', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895756', '8642348861051895757', '1002', '2025-06-04 14:40:48.704927', '2025-06-04 15:54:42.428102', '8645782395347271577', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895736', '8642348861051895737', '1002', '2025-06-04 14:40:52.497661', '2025-06-04 15:54:43.024232', '8644945289041412089', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895729', '8642348861051895730', '1002', '2025-06-04 14:40:53.816144', '2025-06-04 15:54:43.626995', '8644945289041412083', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895725', '8642348861051895726', '1002', '2025-06-04 14:40:54.486094', '2025-06-04 15:54:44.224662', '8644945289041412080', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338239', '8642197643843338240', '1002', '2025-06-04 15:51:56.935966', '2025-06-04 15:54:44.822772', '8644945289041412086', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507116', '8642875801999507117', '1002', '2025-06-04 11:03:44.438486', '2025-06-04 11:20:03.878977', '8645782395347271606', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507130', '8642875801999507131', '1002', '2025-06-04 11:03:41.769907', '2025-06-04 11:30:21.200809', '8645782395347271651', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895746', '8642348861051895748', '1002', '2025-06-04 14:40:51.087161', '2025-06-04 15:54:45.424985', '8644945289041412096', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895745', '8642348861051895747', '1002', '2025-06-04 14:40:51.088159', '2025-06-04 15:54:46.020122', '8644945289041412096', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507109', '8642875801999507110', '1002', '2025-06-04 11:03:45.695001', '2025-06-04 11:17:05.190006', '8645782395347271589', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642765198001700859', '8642765198001700860', '1002', '2025-06-04 11:20:21.961178', '2025-06-04 11:23:26.53974', '8645782395347271606', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642765198001700856', '8642765198001700857', '1002', '2025-06-04 11:25:35.247931', '2025-06-04 11:27:02.473359', '8645782395347271606', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507142', '8642875801999507143', '1002', '2025-06-04 11:03:39.188833', '2025-06-04 11:30:21.81072', '8645782395347271668', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507083', '8642875801999507084', '1002', '2025-06-04 11:03:50.499144', '2025-06-04 11:30:22.416866', '8644945289041412089', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507079', '8642875801999507080', '1002', '2025-06-04 11:03:51.15388', '2025-06-04 11:30:23.022719', '8644945289041412086', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507106', '8642875801999507107', '1002', '2025-06-04 11:03:46.298282', '2025-06-04 11:30:23.624447', '8645782395347271580', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507134', '8642875801999507135', '1002', '2025-06-04 11:03:41.089387', '2025-06-04 11:30:24.229429', '8645782395347271654', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507075', '8642875801999507076', '1002', '2025-06-04 11:03:51.800263', '2025-06-04 11:30:24.827871', '8644945289041412083', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507113', '8642875801999507114', '1002', '2025-06-04 11:03:45.043441', '2025-06-04 11:30:25.426911', '8645782395347271601', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507144', '8642875801999507146', '1002', '2025-06-04 11:03:38.627541', '2025-06-04 11:30:26.031019', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507103', '8642875801999507104', '1002', '2025-06-04 11:03:46.896028', '2025-06-04 11:30:26.628923', '8645782395347271577', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507071', '8642875801999507072', '1002', '2025-06-04 11:03:52.441073', '2025-06-04 11:30:27.226939', '8644945289041412080', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642765198001700863', '8642765198001700864', '1002', '2025-06-04 11:17:19.616681', '2025-06-04 11:30:27.821895', '8645782395347271589', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507120', '8642875801999507121', '1002', '2025-06-04 11:03:43.791701', '2025-06-04 11:30:28.42187', '8645782395347271611', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507145', '8642875801999507147', '1002', '2025-06-04 11:03:38.627541', '2025-06-04 11:30:29.021525', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507125', '8642875801999507127', '1002', '2025-06-04 11:03:42.7572', '2025-06-04 11:30:29.629426', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507122', '8642875801999507123', '1002', '2025-06-04 11:03:43.272351', '2025-06-04 11:30:30.233786', '8645782395347271628', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507124', '8642875801999507126', '1002', '2025-06-04 11:03:42.7572', '2025-06-04 11:30:30.857147', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642743998043127807', '8642743998043127808', '1002', '2025-06-04 11:27:47.557135', '2025-06-04 11:30:31.469176', '8645782395347271606', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507140', '8642875801999507141', '1002', '2025-06-04 11:03:39.704115', '2025-06-04 11:30:32.06407', '8645924713383591797', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507137', '8642875801999507139', '1002', '2025-06-04 11:03:40.572483', '2025-06-04 11:30:32.671166', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507136', '8642875801999507138', '1002', '2025-06-04 11:03:40.572483', '2025-06-04 11:30:33.276547', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507148', '8642875801999507149', '1002', '2025-06-04 11:03:37.709601', '2025-06-04 11:30:33.875944', '8645924713383591832', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507092', '8642875801999507094', '1002', '2025-06-04 11:03:49.167526', '2025-06-04 11:30:34.471926', '8644945289041412096', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507086', '8642875801999507087', '1002', '2025-06-04 11:03:49.892405', '2025-06-04 11:30:35.068925', '8644945289041412092', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507093', '8642875801999507095', '1002', '2025-06-04 11:03:49.167526', '2025-06-04 11:30:35.672312', '8644945289041412096', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507099', '8642875801999507101', '1002', '2025-06-04 11:03:47.793682', '2025-06-04 11:30:36.271583', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507098', '8642875801999507100', '1002', '2025-06-04 11:03:47.79468', '2025-06-04 11:30:36.871222', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642875801999507096', '8642875801999507097', '1002', '2025-06-04 11:03:48.266552', '2025-06-04 11:30:37.475239', '8645046787708551157', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642735957864349654', '8642735957864349655', '1002', '2025-06-04 11:31:10.495638', '2025-06-04 11:36:15.536514', '8645782395347271589', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642735957864349665', '8642735957864349666', '1002', '2025-06-04 11:31:08.454681', '2025-06-04 11:36:16.147247', '8645782395347271611', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642735957864349647', '8642735957864349648', '1002', '2025-06-04 11:31:11.820005', '2025-06-04 11:36:16.739919', '8645782395347271577', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642735957864349662', '8642735957864349663', '1002', '2025-06-04 11:31:09.107328', '2025-06-04 11:36:17.334848', '8645782395347271606', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642735957864349691', '8642735957864349693', '1002', '2025-06-04 11:31:02.57074', '2025-06-04 11:36:17.922641', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642735957864349692', '8642735957864349694', '1002', '2025-06-04 11:31:02.57074', '2025-06-04 11:36:18.515647', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642735957864349677', '8642735957864349678', '1002', '2025-06-04 11:31:06.016906', '2025-06-04 11:36:19.105191', '8645782395347271651', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642735957864349669', '8642735957864349670', '1002', '2025-06-04 11:31:07.759866', '2025-06-04 11:36:19.69142', '8645782395347271628', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642735957864349672', '8642735957864349674', '1002', '2025-06-04 11:31:07.152865', '2025-06-04 11:36:20.276861', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642735957864349671', '8642735957864349673', '1002', '2025-06-04 11:31:07.153863', '2025-06-04 11:36:20.861797', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642735957864349658', '8642735957864349659', '1002', '2025-06-04 11:31:09.80655', '2025-06-04 11:36:21.446227', '8645782395347271601', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642735957864349687', '8642735957864349688', '1002', '2025-06-04 11:31:03.748331', '2025-06-04 11:36:22.612827', '8645924713383591797', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642735957864349684', '8642735957864349686', '1002', '2025-06-04 11:31:04.679183', '2025-06-04 11:36:23.784446', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642735957864349695', '8642735957864349696', '1002', '2025-06-04 11:31:01.594342', '2025-06-04 11:36:24.959479', '8645924713383591832', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642668028661596159', '8642668028661596160', '1002', '2025-06-04 12:05:23.809332', '2025-06-04 12:07:07.402485', '8644945289041412086', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642391707645640612', '8642391707645640613', '1002', '2025-06-04 14:36:21.26972', '2025-06-04 14:38:07.601477', '8644945289041412092', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642315944422539263', '8642315944422539264', '1002', '2025-06-04 14:55:21.928288', '2025-06-04 14:59:00.508516', '8644945289041412086', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642272238835335157', '8642272238835335158', '1002', '2025-06-04 15:22:31.837026', '2025-06-04 15:30:18.994488', '8644945289041412086', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895739', '8642348861051895740', '1002', '2025-06-04 14:40:51.852195', '2025-06-04 15:54:46.621915', '8644945289041412092', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895780', '8642348861051895782', '1002', '2025-06-04 14:40:44.207124', '2025-06-04 15:54:47.225832', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895779', '8642348861051895781', '1002', '2025-06-04 14:40:44.207124', '2025-06-04 15:54:47.828162', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895777', '8642348861051895778', '1002', '2025-06-04 14:40:44.752519', '2025-06-04 15:54:48.425402', '8645782395347271628', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895752', '8642348861051895754', '1002', '2025-06-04 14:40:49.645874', '2025-06-04 15:54:49.016431', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895751', '8642348861051895753', '1002', '2025-06-04 14:40:49.645874', '2025-06-04 15:54:49.605524', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642348861051895749', '8642348861051895750', '1002', '2025-06-04 14:40:50.139237', '2025-06-04 15:54:50.197074', '8645046787708551157', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338203', '8642197643843338204', '1002', '2025-06-04 15:55:08.431759', '2025-06-04 15:59:49.822238', '8645782395347271606', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338153', '8642197643843338154', '1002', '2025-06-04 16:03:08.552156', '2025-06-04 16:15:44.936083', '8645782395347271606', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642135968112967679', '8642135968112967680', '1002', '2025-06-04 16:22:11.268359', '2025-06-04 16:38:01.821968', '8645782395347271606', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338212', '8642197643843338214', '1002', '2025-06-04 15:55:06.721879', '2025-06-04 16:39:19.779781', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338207', '8642197643843338208', '1002', '2025-06-04 15:55:07.774132', '2025-06-04 16:39:20.40158', '8645782395347271611', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338189', '8642197643843338190', '1002', '2025-06-04 15:55:10.976706', '2025-06-04 16:39:21.032436', '8645782395347271577', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338185', '8642197643843338187', '1002', '2025-06-04 15:55:11.886501', '2025-06-04 16:39:21.657557', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338184', '8642197643843338186', '1002', '2025-06-04 15:55:11.886501', '2025-06-04 16:39:22.284214', '8645046787708551168', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338182', '8642197643843338183', '1002', '2025-06-04 15:55:12.36427', '2025-06-04 16:39:22.906979', '8645046787708551157', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338232', '8642197643843338234', '1002', '2025-06-04 15:55:02.44857', '2025-06-04 16:39:23.524888', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338217', '8642197643843338218', '1002', '2025-06-04 15:55:05.72015', '2025-06-04 16:39:24.149776', '8645782395347271651', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338165', '8642197643843338166', '1002', '2025-06-04 15:55:15.280744', '2025-06-04 16:39:24.78009', '8644945289041412086', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338221', '8642197643843338222', '1002', '2025-06-04 15:55:05.027635', '2025-06-04 16:39:25.403861', '8645782395347271654', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338192', '8642197643843338193', '1002', '2025-06-04 15:55:10.371972', '2025-06-04 16:39:26.02545', '8645782395347271580', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338169', '8642197643843338170', '1002', '2025-06-04 15:55:14.631521', '2025-06-04 16:39:26.647661', '8644945289041412089', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338229', '8642197643843338230', '1002', '2025-06-04 15:55:03.037999', '2025-06-04 16:39:27.264627', '8645782395347271668', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338161', '8642197643843338162', '1002', '2025-06-04 15:55:15.935965', '2025-06-04 16:39:27.879133', '8644945289041412083', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338200', '8642197643843338201', '1002', '2025-06-04 15:55:09.051276', '2025-06-04 16:39:28.490968', '8645782395347271601', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338211', '8642197643843338213', '1002', '2025-06-04 15:55:06.721879', '2025-06-04 16:39:29.10698', '8645782395347271632', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338235', '8642197643843338236', '1002', '2025-06-04 15:55:01.495879', '2025-06-04 16:39:29.727184', '8645924713383591832', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338224', '8642197643843338226', '1002', '2025-06-04 15:55:04.496245', '2025-06-04 16:39:30.349622', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338223', '8642197643843338225', '1002', '2025-06-04 15:55:04.497237', '2025-06-04 16:39:30.964133', '8645924713383591794', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338227', '8642197643843338228', '1002', '2025-06-04 15:55:03.583535', '2025-06-04 16:39:31.577962', '8645924713383591797', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338196', '8642197643843338197', '1002', '2025-06-04 15:55:09.713956', '2025-06-04 16:39:32.192512', '8645782395347271589', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646207', '8642101470935646208', '1002', '2025-06-04 16:38:32.747481', '2025-06-04 16:39:32.815473', '8645782395347271606', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338157', '8642197643843338158', '1002', '2025-06-04 15:55:16.575959', '2025-06-04 16:39:33.433818', '8644945289041412080', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338231', '8642197643843338233', '1002', '2025-06-04 15:55:02.44857', '2025-06-04 16:39:34.058645', '8645924713383591809', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338178', '8642197643843338180', '1002', '2025-06-04 15:55:13.276736', '2025-06-04 16:39:34.683555', '8644945289041412096', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338179', '8642197643843338181', '1002', '2025-06-04 15:55:13.276736', '2025-06-04 16:39:35.297564', '8644945289041412096', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642197643843338172', '8642197643843338173', '1002', '2025-06-04 15:55:14.014659', '2025-06-04 16:39:35.914779', '8644945289041412092', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646203', '8642101470935646204', '1002', '2025-06-04 16:39:49.01262', '2025-06-04 16:39:49.01262', '8645924713383591832', 0, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646200', '8642101470935646202', '1002', '2025-06-04 16:39:49.988186', '2025-06-04 16:39:49.988186', '8645924713383591809', 0, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646199', '8642101470935646201', '1002', '2025-06-04 16:39:49.988186', '2025-06-04 16:39:49.988186', '8645924713383591809', 0, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646197', '8642101470935646198', '1002', '2025-06-04 16:39:50.588611', '2025-06-04 16:39:50.588611', '8645782395347271668', 0, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646195', '8642101470935646196', '1002', '2025-06-04 16:39:51.142982', '2025-06-04 16:39:51.142982', '8645924713383591797', 0, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646192', '8642101470935646194', '1002', '2025-06-04 16:39:52.075266', '2025-06-04 16:39:52.075266', '8645924713383591794', 0, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646191', '8642101470935646193', '1002', '2025-06-04 16:39:52.076265', '2025-06-04 16:39:52.076265', '8645924713383591794', 0, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646189', '8642101470935646190', '1002', '2025-06-04 16:39:52.624361', '2025-06-04 16:39:52.624361', '8645782395347271654', 0, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646185', '8642101470935646186', '1002', '2025-06-04 16:39:53.349383', '2025-06-04 16:39:53.349383', '8645782395347271651', 0, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646180', '8642101470935646182', '1002', '2025-06-04 16:39:54.403544', '2025-06-04 16:39:54.403544', '8645782395347271632', 0, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646179', '8642101470935646181', '1002', '2025-06-04 16:39:54.404542', '2025-06-04 16:39:54.404542', '8645782395347271632', 0, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646177', '8642101470935646178', '1002', '2025-06-04 16:39:54.955285', '2025-06-04 16:39:54.955285', '8645782395347271628', 0, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646175', '8642101470935646176', '1002', '2025-06-04 16:39:55.514589', '2025-06-04 16:39:55.514589', '8645782395347271611', 0, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646171', '8642101470935646172', '1002', '2025-06-04 16:39:56.20872', '2025-06-04 16:39:56.20872', '8645782395347271606', 0, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646167', '8642101470935646168', '1002', '2025-06-04 16:39:56.899939', '2025-06-04 16:39:56.899939', '8645782395347271601', 0, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646163', '8642101470935646164', '1002', '2025-06-04 16:39:57.593602', '2025-06-04 16:39:57.593602', '8645782395347271589', 0, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646159', '8642101470935646160', '1002', '2025-06-04 16:39:58.308621', '2025-06-04 16:39:58.308621', '8645782395347271580', 0, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646156', '8642101470935646157', '1002', '2025-06-04 16:39:58.942776', '2025-06-04 16:39:58.942776', '8645782395347271577', 0, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646152', '8642101470935646154', '1002', '2025-06-04 16:39:59.909166', '2025-06-04 16:39:59.909166', '8645046787708551168', 0, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646151', '8642101470935646153', '1002', '2025-06-04 16:39:59.909166', '2025-06-04 16:39:59.909166', '8645046787708551168', 0, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646149', '8642101470935646150', '1002', '2025-06-04 16:40:00.410111', '2025-06-04 16:40:00.410111', '8645046787708551157', 0, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646146', '8642101470935646148', '1002', '2025-06-04 16:40:01.360792', '2025-06-04 16:40:01.360792', '8644945289041412096', 0, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646145', '8642101470935646147', '1002', '2025-06-04 16:40:01.361791', '2025-06-04 16:40:01.361791', '8644945289041412096', 0, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646139', '8642101470935646140', '1002', '2025-06-04 16:40:02.132091', '2025-06-04 16:40:02.132091', '8644945289041412092', 0, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646136', '8642101470935646137', '1002', '2025-06-04 16:40:02.775121', '2025-06-04 16:40:02.775121', '8644945289041412089', 0, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646132', '8642101470935646133', '1002', '2025-06-04 16:40:03.458836', '2025-06-04 16:40:03.458836', '8644945289041412086', 0, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646128', '8642101470935646129', '1002', '2025-06-04 16:40:04.146823', '2025-06-04 16:40:04.147822', '8644945289041412083', 0, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646124', '8642101470935646125', '1002', '2025-06-04 16:40:04.826598', '2025-06-04 16:40:04.826598', '8644945289041412080', 0, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646101', '8642101470935646102', '1002', '2025-06-04 16:48:13.697972', '2025-06-04 16:56:00.873623', '8642101470935646109', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646098', '8642101470935646099', '1002', '2025-06-04 16:50:12.354304', '2025-06-04 16:56:00.873623', '8642101470935646109', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646107', '8642101470935646120', '1001', '2025-06-04 16:48:03.607913', '2025-06-04 16:56:00.873623', '8642101470935646109', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646108', '8642101470935646121', '1001', '2025-06-04 16:48:03.607913', '2025-06-04 16:56:00.873623', '8642101470935646109', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646095', '8642101470935646096', '1002', '2025-06-04 16:51:33.780586', '2025-06-04 16:56:00.873623', '8642101470935646109', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646088', '8642101470935646093', '1001', '2025-06-04 16:56:15.591698', '2025-06-04 16:59:42.104797', '8642101470935646089', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646087', '8642101470935646091', '1001', '2025-06-04 16:56:15.591698', '2025-06-04 16:59:42.700828', '8642101470935646089', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646078', '8642101470935646093', '1001', '2025-06-04 16:57:50.595128', '2025-06-04 16:59:51.157173', '8642101470935646080', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646079', '8642101470935646091', '1001', '2025-06-04 16:57:50.595128', '2025-06-04 16:59:51.157173', '8642101470935646080', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646060', '8642101470935646061', '1002', '2025-06-04 17:04:42.065971', '2025-06-04 17:28:34.020318', '8642101470935646064', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646103', '8642101470935646104', '1002', '2025-06-04 16:48:13.084455', '2025-06-04 17:28:37.503923', '8642101470935646112', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646082', '8642101470935646083', '1002', '2025-06-04 16:57:23.499662', '2025-06-04 17:28:38.663176', '8642101470935646086', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646066', '8642101470935646067', '1002', '2025-06-04 17:00:10.574945', '2025-06-04 17:28:39.24105', '8642101470935646073', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646071', '8642101470935646077', '1001', '2025-06-04 16:59:58.108436', '2025-06-04 17:28:39.819515', '8642101470935646073', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646072', '8642101470935646075', '1001', '2025-06-04 16:59:58.108436', '2025-06-04 17:28:40.394881', '8642101470935646073', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646069', '8642101470935646076', '1001', '2025-06-04 17:00:01.594855', '2025-06-04 17:28:40.971082', '8642101470935646070', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646063', '8642101470935646076', '1001', '2025-06-04 17:04:23.722429', '2025-06-04 17:28:40.971082', '8642101470935646064', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646068', '8642101470935646074', '1001', '2025-06-04 17:00:01.594855', '2025-06-04 17:28:41.548962', '8642101470935646070', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646062', '8642101470935646074', '1001', '2025-06-04 17:04:23.722429', '2025-06-04 17:28:41.548962', '8642101470935646064', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646057', '8642101470935646058', '1002', '2025-06-04 17:06:35.714113', '2025-06-04 17:28:34.020318', '8642101470935646064', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646054', '8642101470935646055', '1002', '2025-06-04 17:07:36.865109', '2025-06-04 17:28:36.928628', '8642101470935646064', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646105', '8642101470935646106', '1002', '2025-06-04 16:48:12.516128', '2025-06-04 17:28:38.082466', '8642101470935646115', 99, 1, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646111', '8642101470935646117', '1001', '2025-06-04 16:47:54.692564', '2025-06-04 17:28:42.125949', '8642101470935646112', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646113', '8642101470935646118', '1001', '2025-06-04 16:47:51.851338', '2025-06-04 17:28:42.701644', '8642101470935646115', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646110', '8642101470935646116', '1001', '2025-06-04 16:47:54.692564', '2025-06-04 17:28:43.27812', '8642101470935646112', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646085', '8642101470935646090', '1001', '2025-06-04 16:56:18.937277', '2025-06-04 17:28:43.85548', '8642101470935646086', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646084', '8642101470935646092', '1001', '2025-06-04 16:56:18.938273', '2025-06-04 17:28:44.432639', '8642101470935646086', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8642101470935646114', '8642101470935646119', '1001', '2025-06-04 16:47:51.851338', '2025-06-04 17:28:45.008114', '8642101470935646115', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645046787708551167', '8645275692285558706', '1001', '2025-06-03 16:54:44.453871', '2025-07-15 14:16:28.372791', '8645046787708551168', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645046787708551166', '8645275692285558705', '1001', '2025-06-03 16:54:44.456839', '2025-07-15 14:16:29.007799', '8645046787708551168', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645046787708551158', '8645275692285558708', '1001', '2025-06-03 16:55:12.419582', '2025-07-15 14:16:29.641958', '8645046787708551160', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645046787708551155', '8645275692285558708', '1001', '2025-06-03 16:57:14.184525', '2025-07-15 14:16:29.641958', '8645046787708551157', 99, 0, 100001);
INSERT INTO public.lane_group_ref VALUES ('8645046787708551165', '8645275692285558709', '1001', '2025-06-03 16:54:44.456839', '2025-07-15 14:16:30.286728', '8645046787708551168', 99, 0, 100001);


--
-- TOC entry 4508 (class 0 OID 18045)
-- Dependencies: 223
-- Data for Name: lane_ref; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.lane_ref VALUES ('8552983717042192383', '80191', '1007', '2025-07-04 17:07:31.448834', '2025-07-04 17:07:31.448834', '8642101470935646154', 0, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8552983717042192382', '80175', '1011', '2025-07-04 17:10:48.404404', '2025-07-04 17:10:48.404404', '8642101470935646153', 0, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338152', '8642197643843338214', '1002', '2025-06-04 16:03:08.669281', '2025-06-04 16:39:19.779781', '8642197643843338154', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642698677548220335', '8642698677548220352', '1002', '2025-06-04 11:50:48.271201', '2025-06-04 14:10:17.720974', '8642698677548220338', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642718640556212137', '8642718640556212202', '1002', '2025-06-04 11:45:06.810239', '2025-06-04 11:49:36.005216', '8642718640556212139', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642735957864349613', '8642735957864349673', '1002', '2025-06-04 11:31:17.889767', '2025-06-04 11:36:22.029435', '8642735957864349615', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416808', '8642660435159416825', '1002', '2025-06-04 14:10:38.487253', '2025-06-04 14:17:24.043306', '8642660435159416810', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416829', '8642698677548220408', '1002', '2025-06-04 12:08:17.133168', '2025-06-04 14:10:12.840935', '8642660435159416832', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416830', '8642698677548220360', '1002', '2025-06-04 12:08:17.132171', '2025-06-04 14:10:16.49988', '8642660435159416832', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642698677548220355', '8642698677548220365', '1002', '2025-06-04 11:50:45.030721', '2025-06-04 14:10:17.115262', '8642698677548220359', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642698677548220346', '8642698677548220352', '1002', '2025-06-04 11:50:46.318906', '2025-06-04 14:10:17.720974', '8642698677548220349', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642698677548220339', '8642698677548220352', '1002', '2025-06-04 11:50:47.613484', '2025-06-04 14:10:17.720974', '8642698677548220342', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642698677548220350', '8642698677548220362', '1002', '2025-06-04 11:50:45.649939', '2025-06-04 14:10:17.720974', '8642698677548220352', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642735957864349619', '8642735957864349688', '1002', '2025-06-04 11:31:16.61376', '2025-06-04 11:36:23.195905', '8642735957864349623', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642735957864349616', '8642735957864349685', '1002', '2025-06-04 11:31:17.257204', '2025-06-04 11:36:25.543761', '8642735957864349618', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642735957864349621', '8642735957864349638', '1002', '2025-06-04 11:31:16.61376', '2025-06-04 11:36:26.130093', '8642735957864349623', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642135968112967678', '8642197643843338214', '1002', '2025-06-04 16:22:11.370086', '2025-06-04 16:39:19.779781', '8642135968112967680', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214928', '8644989441305214958', '1002', '2025-06-03 17:21:52.49195', '2025-06-03 17:24:35.71241', '8644989441305214930', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8552983717042192381', '80194', '1011', '2025-07-04 17:11:31.565795', '2025-07-04 17:11:31.565795', '8642101470935646153', 0, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8642735957864349628', '8642735957864349638', '1002', '2025-06-04 11:31:15.230389', '2025-06-04 11:36:26.711977', '8642735957864349630', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214938', '8644989441305214958', '1002', '2025-06-03 17:21:50.395537', '2025-06-03 17:24:36.938468', '8644989441305214940', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214915', '8644989441305214949', '1002', '2025-06-03 17:21:54.834171', '2025-06-03 17:24:37.55145', '8644989441305214917', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642735957864349627', '8642735957864349641', '1002', '2025-06-04 11:31:15.230389', '2025-06-04 11:36:27.293996', '8642735957864349630', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214945', '8644989441305214963', '1002', '2025-06-03 17:21:49.02049', '2025-06-03 17:24:38.78079', '8644989441305214948', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214894', '8644989441305214898', '1002', '2025-06-03 17:21:58.946312', '2025-06-03 17:24:41.264403', '8644989441305214896', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214910', '8644989441305214932', '1002', '2025-06-03 17:21:55.961923', '2025-06-03 17:24:41.886291', '8644989441305214912', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214927', '8644989441305214932', '1002', '2025-06-03 17:21:52.49195', '2025-06-03 17:24:41.886291', '8644989441305214930', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214921', '8644989441305214935', '1002', '2025-06-03 17:21:53.670227', '2025-06-03 17:24:43.110809', '8644989441305214923', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214924', '8644989441305214936', '1002', '2025-06-03 17:21:53.085322', '2025-06-03 17:24:43.723593', '8644989441305214926', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214918', '8644989441305214935', '1002', '2025-06-03 17:21:54.246307', '2025-06-03 17:24:44.332878', '8644989441305214920', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214937', '8644989441305214952', '1002', '2025-06-03 17:21:50.395537', '2025-06-03 17:24:44.94469', '8644989441305214940', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214950', '8644989441305214966', '1002', '2025-06-03 17:21:48.032395', '2025-06-03 17:24:45.561357', '8644989441305214952', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642735957864349620', '8642735957864349626', '1002', '2025-06-04 11:31:16.61376', '2025-06-04 11:36:28.459641', '8642735957864349623', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642735957864349624', '8642735957864349694', '1002', '2025-06-04 11:31:15.879628', '2025-06-04 11:36:28.459641', '8642735957864349626', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645924713383591898', '8645924713383591900', '1004', '2025-06-03 09:51:12.380482', '2025-06-03 14:46:48.755845', '8645924713383591909', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271567', '8645782395347271570', '1004', '2025-06-03 14:20:50.301352', '2025-06-03 17:18:46.452064', '8645782395347271648', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271516', '8645782395347271530', '1005', '2025-06-03 14:23:02.434491', '2025-06-03 17:18:46.452064', '8645782395347271648', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271550', '8645782395347271569', '1004', '2025-06-03 14:20:52.611555', '2025-06-03 17:20:38.555614', '8645782395347271593', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271526', '8645782395347271531', '1005', '2025-06-03 14:23:01.043933', '2025-06-03 17:20:38.555614', '8645782395347271593', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271566', '8645782395347271570', '1004', '2025-06-03 14:20:50.429363', '2025-06-03 17:20:39.146225', '8645782395347271671', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271537', '8645782395347271542', '1005', '2025-06-03 14:22:08.23141', '2025-06-03 17:20:39.146225', '8645782395347271671', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8642735957864349631', '8642735957864349648', '1002', '2025-06-04 11:31:14.552834', '2025-06-04 11:36:29.622628', '8642735957864349637', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642735957864349633', '8642735957864349644', '1002', '2025-06-04 11:31:14.552834', '2025-06-04 11:36:29.622628', '8642735957864349637', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642735957864349632', '8642735957864349651', '1002', '2025-06-04 11:31:14.552834', '2025-06-04 11:36:30.208981', '8642735957864349637', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642735957864349634', '8642735957864349645', '1002', '2025-06-04 11:31:14.552834', '2025-06-04 11:36:30.80427', '8642735957864349638', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642718640556212176', '8642718640556212198', '1002', '2025-06-04 11:41:31.93114', '2025-06-04 11:49:34.820097', '8642718640556212178', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214955', '8644989441305214968', '1002', '2025-06-03 17:21:46.871722', '2025-06-03 17:24:46.807728', '8644989441305214959', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645924713383591897', '8645924713383591900', '1004', '2025-06-03 09:51:12.508139', '2025-06-03 14:25:41.635767', '8645924713383591902', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214964', '8644989441305214968', '1002', '2025-06-03 17:21:44.789313', '2025-06-03 17:24:46.807728', '8644989441305214966', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214942', '8644989441305214948', '1002', '2025-06-03 17:21:49.685315', '2025-06-03 17:24:47.434724', '8644989441305214944', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214941', '8644989441305214954', '1002', '2025-06-03 17:21:49.686314', '2025-06-03 17:24:47.434724', '8644989441305214944', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214899', '8644989441305214912', '1002', '2025-06-03 17:21:57.878772', '2025-06-03 17:24:48.681811', '8644989441305214904', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214900', '8644989441305214914', '1002', '2025-06-03 17:21:57.878772', '2025-06-03 17:24:48.681811', '8644989441305214904', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214901', '8644989441305214908', '1002', '2025-06-03 17:21:57.878772', '2025-06-03 17:24:49.291187', '8644989441305214904', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271466', '8645924713383591846', '1001', '2025-06-03 14:26:53.608658', '2025-06-03 17:25:24.997261', '8645782395347271648', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507326', '8642875801999507343', '1002', '2025-06-04 10:40:00.409228', '2025-06-04 10:47:29.142381', '8642875801999507331', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507315', '8642875801999507376', '1002', '2025-06-04 10:40:02.301068', '2025-06-04 10:47:29.737787', '8642875801999507317', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214811', '8644989441305214818', '1002', '2025-06-03 17:28:58.627583', '2025-06-03 17:46:22.983088', '8644989441305214814', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507367', '8642875801999507378', '1002', '2025-06-04 10:39:52.421001', '2025-06-04 10:47:30.904658', '8642875801999507370', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507368', '8642875801999507373', '1002', '2025-06-04 10:39:52.421001', '2025-06-04 10:47:30.904658', '8642875801999507370', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642946617420283896', '8644945289041412075', '1002', '2025-06-04 09:53:40.034299', '2025-06-04 10:19:29.363889', '8642946617420283899', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642946617420283895', '8644945289041412058', '1002', '2025-06-04 09:53:40.045269', '2025-06-04 10:19:34.29842', '8642946617420283899', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214812', '8644989441305214884', '1002', '2025-06-03 17:28:58.627583', '2025-06-04 10:19:39.83697', '8644989441305214814', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642946617420283897', '8644989441305214884', '1002', '2025-06-04 09:53:40.029312', '2025-06-04 10:19:39.83697', '8642946617420283899', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507363', '8642875801999507376', '1002', '2025-06-04 10:39:53.114294', '2025-06-04 10:47:27.37933', '8642875801999507366', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507312', '8642875801999507373', '1002', '2025-06-04 10:40:02.87916', '2025-06-04 10:47:27.956523', '8642875801999507314', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507319', '8642875801999507382', '1002', '2025-06-04 10:40:01.676699', '2025-06-04 10:47:28.550353', '8642875801999507321', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507318', '8642875801999507324', '1002', '2025-06-04 10:40:01.676699', '2025-06-04 10:47:28.550353', '8642875801999507321', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507325', '8642875801999507341', '1002', '2025-06-04 10:40:00.409228', '2025-06-04 10:47:32.623024', '8642875801999507331', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507339', '8642875801999507358', '1002', '2025-06-04 10:39:58.000243', '2025-06-04 10:47:32.623024', '8642875801999507341', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507344', '8642875801999507374', '1002', '2025-06-04 10:39:56.904793', '2025-06-04 10:47:33.197376', '8642875801999507346', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507350', '8642875801999507362', '1002', '2025-06-04 10:39:55.754175', '2025-06-04 10:47:33.768356', '8642875801999507352', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271433', '8645924713383591847', '1001', '2025-06-03 14:27:01.029894', '2025-06-03 17:20:40.340462', '8645782395347271642', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271432', '8645782395347271618', '1001', '2025-06-03 14:27:01.163868', '2025-06-03 17:20:40.340462', '8645782395347271642', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271431', '8645782395347271617', '1001', '2025-06-03 14:27:01.297863', '2025-06-03 17:20:40.340462', '8645782395347271642', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271430', '8645782395347271616', '1001', '2025-06-03 14:27:01.433382', '2025-06-03 17:20:40.340462', '8645782395347271642', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271429', '8645782395347271614', '1001', '2025-06-03 14:27:01.569555', '2025-06-03 17:20:40.340462', '8645782395347271642', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271428', '8645782395347271613', '1001', '2025-06-03 14:27:01.705536', '2025-06-03 17:20:40.340462', '8645782395347271642', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271468', '8645924713383591855', '1001', '2025-06-03 14:26:53.330071', '2025-06-03 17:18:46.452064', '8645782395347271648', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271467', '8645924713383591847', '1001', '2025-06-03 14:26:53.471046', '2025-06-03 17:18:46.452064', '8645782395347271648', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507353', '8642875801999507358', '1002', '2025-06-04 10:39:55.177819', '2025-06-04 10:47:34.344637', '8642875801999507356', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271465', '8645924713383591836', '1001', '2025-06-03 14:26:53.74377', '2025-06-03 17:18:46.452064', '8645782395347271648', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271464', '8645782395347271663', '1001', '2025-06-03 14:26:53.879643', '2025-06-03 17:18:46.452064', '8645782395347271648', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271457', '8645924713383591893', '1005', '2025-06-03 14:26:55.274834', '2025-06-03 17:18:46.452064', '8645782395347271648', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271458', '8645782395347271581', '1001', '2025-06-03 14:26:54.68387', '2025-06-03 17:18:46.452064', '8645782395347271648', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271459', '8645782395347271582', '1001', '2025-06-03 14:26:54.550438', '2025-06-03 17:18:46.452064', '8645782395347271648', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271427', '8645782395347271612', '1001', '2025-06-03 14:27:01.844713', '2025-06-03 17:20:40.340462', '8645782395347271642', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271426', '8645782395347271591', '1001', '2025-06-03 14:27:01.980787', '2025-06-03 17:20:40.340462', '8645782395347271642', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271425', '8645782395347271590', '1001', '2025-06-03 14:27:02.11537', '2025-06-03 17:20:40.340462', '8645782395347271642', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271424', '8645782395347271582', '1001', '2025-06-03 14:27:02.25167', '2025-06-03 17:20:40.340462', '8645782395347271642', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271423', '8645782395347271581', '1001', '2025-06-03 14:27:02.386136', '2025-06-03 17:20:40.340462', '8645782395347271642', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271422', '8645924713383591862', '1005', '2025-06-03 14:27:02.96848', '2025-06-03 17:20:40.340462', '8645782395347271642', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507309', '8642875801999507361', '1002', '2025-06-04 10:40:03.444329', '2025-06-04 10:47:34.916203', '8642875801999507311', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507364', '8642875801999507381', '1002', '2025-06-04 10:39:53.114294', '2025-06-04 10:47:35.489109', '8642875801999507366', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507354', '8642875801999507381', '1002', '2025-06-04 10:39:55.177819', '2025-06-04 10:47:35.489109', '8642875801999507356', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338219', '8642197643843338230', '1002', '2025-06-04 15:55:05.157742', '2025-06-04 16:39:27.264627', '8642197643843338222', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338191', '8642197643843338230', '1002', '2025-06-04 15:55:10.457534', '2025-06-04 16:39:27.264627', '8642197643843338193', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214849', '8644989441305214861', '1002', '2025-06-03 17:26:29.10016', '2025-06-04 10:39:26.983919', '8644989441305214851', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214843', '8644989441305214860', '1002', '2025-06-03 17:26:30.207742', '2025-06-04 10:39:27.588886', '8644989441305214845', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214846', '8644989441305214860', '1002', '2025-06-03 17:26:29.656228', '2025-06-04 10:39:27.588886', '8644989441305214848', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214889', '8644989441305214893', '1002', '2025-06-03 17:26:21.097679', '2025-06-03 17:28:43.469765', '8644989441305214891', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214852', '8644989441305214857', '1002', '2025-06-03 17:26:28.530659', '2025-06-04 10:39:28.194924', '8644989441305214855', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214835', '8644989441305214857', '1002', '2025-06-03 17:26:31.859002', '2025-06-04 10:39:28.194924', '8644989441305214837', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507328', '8642875801999507338', '1002', '2025-06-04 10:40:00.409228', '2025-06-04 10:47:36.059832', '8642875801999507332', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214819', '8644989441305214823', '1002', '2025-06-03 17:26:34.754883', '2025-06-04 10:19:27.507868', '8644989441305214821', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507327', '8642875801999507337', '1002', '2025-06-04 10:40:00.409228', '2025-06-04 10:47:36.633861', '8642875801999507331', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507322', '8642875801999507334', '1002', '2025-06-04 10:40:01.017413', '2025-06-04 10:47:37.206893', '8642875801999507324', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214826', '8644989441305214833', '1002', '2025-06-03 17:26:33.711851', '2025-06-04 10:19:28.126214', '8644989441305214829', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338199', '8642197643843338213', '1002', '2025-06-04 15:55:09.180076', '2025-06-04 16:39:29.10698', '8642197643843338201', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214870', '8644989441305214888', '1002', '2025-06-03 17:26:25.195542', '2025-06-04 10:19:30.611125', '8644989441305214873', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338160', '8642197643843338225', '1002', '2025-06-04 15:55:16.063421', '2025-06-04 16:39:30.964133', '8642197643843338162', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214875', '8644989441305214891', '1002', '2025-06-03 17:26:24.230771', '2025-06-04 10:19:31.844691', '8644989441305214877', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214862', '8644989441305214877', '1002', '2025-06-03 17:26:26.519688', '2025-06-04 10:19:33.078069', '8644989441305214865', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642933182762582013', '8644945289041412075', '1002', '2025-06-04 09:55:48.789525', '2025-06-04 10:19:33.688988', '8642933182762582016', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338220', '8642197643843338225', '1002', '2025-06-04 15:55:05.157742', '2025-06-04 16:39:30.964133', '8642197643843338222', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214867', '8644989441305214873', '1002', '2025-06-03 17:26:25.842585', '2025-06-04 10:19:34.913692', '8644989441305214869', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214825', '8644989441305214839', '1002', '2025-06-03 17:26:33.711851', '2025-06-04 10:19:36.139018', '8644989441305214829', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338198', '8642197643843338228', '1002', '2025-06-04 15:55:09.180076', '2025-06-04 16:39:31.577962', '8642197643843338201', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214840', '8644989441305214874', '1002', '2025-06-03 17:26:30.767988', '2025-06-04 10:19:38.621964', '8644989441305214842', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214824', '8644989441305214837', '1002', '2025-06-03 17:26:33.711851', '2025-06-04 10:19:39.22965', '8644989441305214829', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338215', '8642197643843338228', '1002', '2025-06-04 15:55:05.849245', '2025-06-04 16:39:31.577962', '8642197643843338218', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642933182762582014', '8644989441305214884', '1002', '2025-06-04 09:55:48.785508', '2025-06-04 10:19:39.83697', '8642933182762582016', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214880', '8644989441305214893', '1002', '2025-06-03 17:26:23.10018', '2025-06-04 10:19:39.83697', '8644989441305214884', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214866', '8644989441305214879', '1002', '2025-06-03 17:26:25.843582', '2025-06-04 10:19:40.456732', '8644989441305214869', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214853', '8644989441305214883', '1002', '2025-06-03 17:26:28.530659', '2025-06-04 10:19:41.067611', '8644989441305214855', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271369', '8645924713383591847', '1001', '2025-06-03 14:27:14.299504', '2025-06-03 17:20:38.555614', '8645782395347271593', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271368', '8645782395347271658', '1001', '2025-06-03 14:27:14.434748', '2025-06-03 17:20:38.555614', '8645782395347271593', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271367', '8645782395347271612', '1001', '2025-06-03 14:27:14.568752', '2025-06-03 17:20:38.555614', '8645782395347271593', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271366', '8645924713383591862', '1005', '2025-06-03 14:27:14.970109', '2025-06-03 17:20:38.555614', '8645782395347271593', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271365', '8645924713383591855', '1001', '2025-06-03 14:27:15.280535', '2025-06-03 17:20:41.518918', '8645782395347271586', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214863', '8644989441305214883', '1002', '2025-06-03 17:26:26.518688', '2025-06-04 10:19:41.067611', '8644989441305214865', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338163', '8642197643843338228', '1002', '2025-06-04 15:55:15.406408', '2025-06-04 16:39:31.577962', '8642197643843338166', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642718640556212182', '8642718640556212198', '1002', '2025-06-04 11:41:30.700552', '2025-06-04 11:49:35.412971', '8642718640556212185', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642718640556212194', '8642718640556212221', '1002', '2025-06-04 11:41:28.729523', '2025-06-04 11:49:36.597448', '8642718640556212196', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642723176041676752', '8642723176041676774', '1002', '2025-06-04 11:37:06.130939', '2025-06-04 11:39:43.358507', '8642723176041676754', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642718640556212204', '8642718640556212221', '1002', '2025-06-04 11:41:26.535351', '2025-06-04 11:49:37.772341', '8642718640556212206', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642723176041676738', '8642723176041676754', '1002', '2025-06-04 11:37:08.59295', '2025-06-04 11:39:48.248763', '8642723176041676744', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642723176041676740', '8642723176041676750', '1002', '2025-06-04 11:37:08.59295', '2025-06-04 11:39:48.248763', '8642723176041676744', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642723176041676732', '8642723176041676798', '1002', '2025-06-04 11:37:10.241873', '2025-06-04 11:39:50.059225', '8642723176041676734', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642723176041676739', '8642723176041676757', '1002', '2025-06-04 11:37:08.59295', '2025-06-04 11:39:50.657418', '8642723176041676744', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642718640556212179', '8642718640556212218', '1002', '2025-06-04 11:41:31.320985', '2025-06-04 11:49:40.128441', '8642718640556212181', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642718640556212207', '8642718640556212218', '1002', '2025-06-04 11:41:25.722524', '2025-06-04 11:49:40.714982', '8642718640556212210', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642718640556212162', '8642718640556212178', '1002', '2025-06-04 11:41:34.380352', '2025-06-04 11:49:41.893562', '8642718640556212168', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642718640556212163', '8642718640556212181', '1002', '2025-06-04 11:41:34.380352', '2025-06-04 11:49:41.893562', '8642718640556212168', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338195', '8642197643843338226', '1002', '2025-06-04 15:55:09.840597', '2025-06-04 16:39:32.192512', '8642197643843338197', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338194', '8642197643843338210', '1002', '2025-06-04 15:55:09.840597', '2025-06-04 16:39:32.192512', '8642197643843338197', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646206', '8642197643843338214', '1002', '2025-06-04 16:38:32.889102', '2025-06-04 16:39:32.815473', '8642101470935646208', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642718640556212187', '8642718640556212201', '1002', '2025-06-04 11:41:30.038311', '2025-06-04 11:49:44.845523', '8642718640556212189', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642718640556212183', '8642718640556212214', '1002', '2025-06-04 11:41:30.700552', '2025-06-04 11:49:46.022376', '8642718640556212185', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642718640556212208', '8642718640556212213', '1002', '2025-06-04 11:41:25.721526', '2025-06-04 11:49:46.612101', '8642718640556212210', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642718640556212203', '8642718640556212216', '1002', '2025-06-04 11:41:26.535351', '2025-06-04 11:49:47.213948', '8642718640556212206', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507150', '8642875801999507168', '1002', '2025-06-04 10:59:22.691119', '2025-06-04 11:03:17.963752', '8642875801999507153', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214816', '8644989441305214830', '1002', '2025-06-03 17:28:53.389246', '2025-06-03 17:47:11.698356', '8644989441305214818', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214815', '8644989441305214877', '1002', '2025-06-03 17:28:53.390244', '2025-06-04 10:19:31.844691', '8644989441305214818', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271421', '8645782395347271663', '1001', '2025-06-03 14:27:03.280008', '2025-06-03 14:40:02.233193', '8645924713383591829', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271420', '8645782395347271662', '1001', '2025-06-03 14:27:03.415084', '2025-06-03 14:40:02.233193', '8645924713383591829', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271419', '8645782395347271661', '1001', '2025-06-03 14:27:03.551063', '2025-06-03 14:40:02.233193', '8645924713383591829', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271418', '8645782395347271660', '1001', '2025-06-03 14:27:03.686874', '2025-06-03 14:40:02.233193', '8645924713383591829', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271417', '8645782395347271659', '1001', '2025-06-03 14:27:03.822686', '2025-06-03 14:40:02.233193', '8645924713383591829', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271416', '8645782395347271614', '1001', '2025-06-03 14:27:03.960342', '2025-06-03 14:40:02.233193', '8645924713383591829', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271415', '8645782395347271613', '1001', '2025-06-03 14:27:04.095382', '2025-06-03 14:40:02.233193', '8645924713383591829', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271414', '8645782395347271612', '1001', '2025-06-03 14:27:04.230814', '2025-06-03 14:40:02.233193', '8645924713383591829', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271413', '8645782395347271591', '1001', '2025-06-03 14:27:04.365123', '2025-06-03 14:40:02.233193', '8645924713383591829', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271412', '8645782395347271590', '1001', '2025-06-03 14:27:04.499397', '2025-06-03 14:40:02.233193', '8645924713383591829', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271411', '8645924713383591893', '1005', '2025-06-03 14:27:04.905716', '2025-06-03 14:40:02.233193', '8645924713383591829', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271410', '8645924713383591862', '1005', '2025-06-03 14:27:05.042381', '2025-06-03 14:40:02.233193', '8645924713383591829', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271409', '8645924713383591900', '1004', '2025-06-03 14:27:05.222437', '2025-06-03 14:40:02.233193', '8645924713383591829', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645924713383591880', '8645924713383591884', '1005', '2025-06-03 09:55:56.253751', '2025-06-03 14:46:48.755845', '8645924713383591909', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645924713383591899', '8645924713383591900', '1004', '2025-06-03 09:51:12.251394', '2025-06-03 14:46:49.941886', '8645924713383591910', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645924713383591878', '8645924713383591883', '1005', '2025-06-03 09:55:56.670633', '2025-06-03 14:46:49.941886', '8645924713383591910', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271251', '8645782395347271260', '1002', '2025-06-03 14:45:18.090749', '2025-06-03 14:46:52.308462', '8645782395347271253', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271254', '8645782395347271264', '1002', '2025-06-03 14:45:17.444914', '2025-06-03 14:46:52.89454', '8645782395347271258', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642718640556212186', '8642718640556212216', '1002', '2025-06-04 11:41:30.039308', '2025-06-04 11:49:47.213948', '8642718640556212189', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645275692285558782', '8645924713383591884', '1005', '2025-06-03 15:23:10.920261', '2025-06-03 15:48:15.142669', '8645275692285558784', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645275692285558781', '8645924713383591900', '1004', '2025-06-03 15:23:11.094429', '2025-06-03 15:48:15.142669', '8645275692285558784', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271242', '8645782395347271250', '1002', '2025-06-03 14:47:13.226548', '2025-06-03 15:48:16.307188', '8645782395347271244', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642718640556212165', '8642718640556212175', '1002', '2025-06-04 11:41:34.380352', '2025-06-04 11:49:47.811119', '8642718640556212169', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642723176041676720', '8642723176041676777', '1002', '2025-06-04 11:37:12.257264', '2025-06-04 11:39:53.071827', '8642723176041676722', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642718640556212164', '8642718640556212174', '1002', '2025-06-04 11:41:34.380352', '2025-06-04 11:49:48.400503', '8642718640556212168', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642698677548220373', '8642698677548220390', '1002', '2025-06-04 11:50:41.318567', '2025-06-04 14:10:01.972124', '8642698677548220376', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642723176041676724', '8642723176041676789', '1002', '2025-06-04 11:37:11.602865', '2025-06-04 11:39:57.308782', '8642723176041676726', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642723176041676719', '8642723176041676737', '1002', '2025-06-04 11:37:12.258261', '2025-06-04 11:39:59.121066', '8642723176041676722', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642723176041676723', '8642723176041676737', '1002', '2025-06-04 11:37:11.603862', '2025-06-04 11:39:59.121066', '8642723176041676726', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645275692285558740', '8645782395347271662', '1001', '2025-06-03 15:50:49.430291', '2025-06-03 16:59:12.264287', '8645275692285558771', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645275692285558739', '8645782395347271661', '1001', '2025-06-03 15:50:49.554886', '2025-06-03 16:59:12.264287', '8645275692285558771', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645275692285558738', '8645782395347271660', '1001', '2025-06-03 15:50:49.681063', '2025-06-03 16:59:12.264287', '8645275692285558771', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645275692285558741', '8645782395347271663', '1001', '2025-06-03 15:50:49.304417', '2025-06-03 16:59:12.264287', '8645275692285558771', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645275692285558737', '8645782395347271659', '1001', '2025-06-03 15:50:49.806674', '2025-06-03 16:59:12.264287', '8645275692285558771', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645275692285558736', '8645782395347271614', '1001', '2025-06-03 15:50:49.932657', '2025-06-03 16:59:12.264287', '8645275692285558771', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645275692285558735', '8645782395347271613', '1001', '2025-06-03 15:50:50.057144', '2025-06-03 16:59:12.264287', '8645275692285558771', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645275692285558734', '8645782395347271612', '1001', '2025-06-03 15:50:50.182501', '2025-06-03 16:59:12.264287', '8645275692285558771', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645275692285558733', '8645782395347271591', '1001', '2025-06-03 15:50:50.307838', '2025-06-03 16:59:12.264287', '8645275692285558771', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271352', '8645782395347271663', '1001', '2025-06-03 14:27:17.60663', '2025-06-03 17:20:47.40024', '8645782395347271572', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271351', '8645782395347271662', '1001', '2025-06-03 14:27:17.743489', '2025-06-03 17:20:47.40024', '8645782395347271572', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271350', '8645782395347271661', '1001', '2025-06-03 14:27:17.879297', '2025-06-03 17:20:47.40024', '8645782395347271572', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271349', '8645782395347271660', '1001', '2025-06-03 14:27:18.014427', '2025-06-03 17:20:47.40024', '8645782395347271572', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271348', '8645782395347271659', '1001', '2025-06-03 14:27:18.147788', '2025-06-03 17:20:47.40024', '8645782395347271572', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271347', '8645782395347271658', '1001', '2025-06-03 14:27:18.282494', '2025-06-03 17:20:47.40024', '8645782395347271572', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271346', '8645782395347271618', '1001', '2025-06-03 14:27:18.416662', '2025-06-03 17:20:47.40024', '8645782395347271572', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271345', '8645782395347271617', '1001', '2025-06-03 14:27:18.550929', '2025-06-03 17:20:47.40024', '8645782395347271572', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271344', '8645782395347271616', '1001', '2025-06-03 14:27:18.685598', '2025-06-03 17:20:47.40024', '8645782395347271572', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271343', '8645782395347271591', '1001', '2025-06-03 14:27:18.818214', '2025-06-03 17:20:47.40024', '8645782395347271572', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271342', '8645782395347271583', '1001', '2025-06-03 14:27:18.955377', '2025-06-03 17:20:47.40024', '8645782395347271572', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271341', '8645924713383591893', '1005', '2025-06-03 14:27:19.539885', '2025-06-03 17:20:47.40024', '8645782395347271572', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8642698677548220385', '8642698677548220390', '1002', '2025-06-04 11:50:39.30108', '2025-06-04 14:10:02.58311', '8642698677548220388', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646205', '8642197643843338230', '1002', '2025-06-04 16:38:32.889102', '2025-06-04 16:39:32.815473', '8642101470935646208', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642698677548220367', '8642698677548220390', '1002', '2025-06-04 11:50:42.557452', '2025-06-04 14:10:03.258493', '8642698677548220369', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642698677548220386', '8642698677548220413', '1002', '2025-06-04 11:50:39.300084', '2025-06-04 14:10:03.870087', '8642698677548220388', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338156', '8642197643843338213', '1002', '2025-06-04 15:55:16.703621', '2025-06-04 16:39:33.433818', '8642197643843338158', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338206', '8642197643843338233', '1002', '2025-06-04 15:55:07.901944', '2025-06-04 16:39:34.058645', '8642197643843338208', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645275692285558744', '8645275692285558750', '1002', '2025-06-03 15:50:13.322536', '2025-06-03 15:52:26.913007', '8645275692285558746', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645275692285558751', '8645782395347271241', '1002', '2025-06-03 15:50:11.299087', '2025-06-03 15:52:27.494137', '8645275692285558755', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645275692285558780', '8645924713383591883', '1005', '2025-06-03 15:23:32.59488', '2025-06-03 15:52:27.494137', '8645782395347271241', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645275692285558779', '8645924713383591900', '1004', '2025-06-03 15:23:32.762136', '2025-06-03 15:52:27.494137', '8645782395347271241', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271237', '8645782395347271248', '1002', '2025-06-03 14:47:14.20135', '2025-06-03 15:52:27.494137', '8645782395347271241', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645275692285558743', '8645924713383591884', '1005', '2025-06-03 15:50:42.301519', '2025-06-03 15:52:28.07455', '8645275692285558748', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645275692285558742', '8645924713383591900', '1004', '2025-06-03 15:50:42.476037', '2025-06-03 15:52:28.07455', '8645275692285558748', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645275692285558715', '8645275692285558724', '1002', '2025-06-03 15:52:46.859899', '2025-06-03 16:22:39.378455', '8645275692285558717', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645275692285558718', '8645275692285558728', '1002', '2025-06-03 15:52:46.183641', '2025-06-03 16:22:40.628754', '8645275692285558722', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645275692285558712', '8645275692285558727', '1002', '2025-06-03 16:03:54.24043', '2025-06-03 16:22:41.882089', '8645275692285558714', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644945289041412066', '8644945289041412072', '1002', '2025-06-03 17:48:45.53113', '2025-06-03 17:51:17.145329', '8644945289041412068', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645275692285558732', '8645782395347271590', '1001', '2025-06-03 15:50:50.433333', '2025-06-03 16:59:12.264287', '8645275692285558771', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645275692285558731', '8645924713383591893', '1005', '2025-06-03 15:50:50.811027', '2025-06-03 16:59:12.264287', '8645275692285558771', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645275692285558730', '8645924713383591862', '1005', '2025-06-03 15:50:50.936668', '2025-06-03 16:59:12.264287', '8645275692285558771', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645275692285558729', '8645924713383591900', '1004', '2025-06-03 15:50:51.107519', '2025-06-03 16:59:12.264287', '8645275692285558771', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8642723176041676769', '8642723176041676774', '1002', '2025-06-04 11:37:02.927326', '2025-06-04 11:39:43.972503', '8642723176041676772', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507391', '8642875801999507445', '1002', '2025-06-04 10:22:34.615569', '2025-06-04 10:39:15.414437', '8642875801999507393', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507385', '8642875801999507445', '1002', '2025-06-04 10:31:57.795913', '2025-06-04 10:39:15.414437', '8642875801999507387', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644945289041412069', '8644945289041412075', '1002', '2025-06-03 17:48:44.80312', '2025-06-04 10:19:29.363889', '8644945289041412072', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644945289041412073', '8644989441305214823', '1002', '2025-06-03 17:48:44.136257', '2025-06-04 10:19:29.363889', '8644945289041412075', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644945289041412065', '8644989441305214877', '1002', '2025-06-03 17:48:45.53113', '2025-06-04 10:19:31.844691', '8644945289041412068', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507278', '8642875801999507305', '1002', '2025-06-04 10:47:47.846708', '2025-06-04 10:58:41.706608', '8642875801999507280', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644945289041412056', '8644989441305214877', '1002', '2025-06-03 17:51:25.95442', '2025-06-04 10:19:34.29842', '8644945289041412058', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644945289041412062', '8644989441305214873', '1002', '2025-06-03 17:48:46.107146', '2025-06-04 10:19:35.529803', '8644945289041412064', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644945289041412070', '8644989441305214884', '1002', '2025-06-03 17:48:44.80312', '2025-06-04 10:19:39.83697', '8644945289041412072', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642723176041676770', '8642723176041676797', '1002', '2025-06-04 11:37:02.925363', '2025-06-04 11:39:44.588265', '8642723176041676772', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271460', '8645782395347271613', '1001', '2025-06-03 14:26:54.417154', '2025-06-03 17:18:46.452064', '8645782395347271648', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271461', '8645782395347271616', '1001', '2025-06-03 14:26:54.283514', '2025-06-03 17:18:46.452064', '8645782395347271648', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271462', '8645782395347271617', '1001', '2025-06-03 14:26:54.148629', '2025-06-03 17:18:46.452064', '8645782395347271648', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271463', '8645782395347271662', '1001', '2025-06-03 14:26:54.014988', '2025-06-03 17:18:46.452064', '8645782395347271648', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645046787708551126', '8645924713383591900', '1004', '2025-06-03 16:59:33.033514', '2025-06-03 17:18:46.452064', '8645782395347271648', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214970', '8645782395347271672', '1002', '2025-06-03 17:18:53.87253', '2025-06-03 17:20:39.737597', '8644989441305214972', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645046787708551128', '8645782395347271672', '1002', '2025-06-03 16:59:32.625282', '2025-06-03 17:20:39.737597', '8645782395347271648', 99, 'before', 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271568', '8645782395347271570', '1004', '2025-06-03 14:20:50.171689', '2025-06-03 17:20:39.737597', '8645782395347271672', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271539', '8645782395347271543', '1005', '2025-06-03 14:22:07.844679', '2025-06-03 17:20:39.737597', '8645782395347271672', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338216', '8642197643843338233', '1002', '2025-06-04 15:55:05.848248', '2025-06-04 16:39:34.058645', '8642197643843338218', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645046787708551117', '8645782395347271642', '1002', '2025-06-03 16:59:41.287678', '2025-06-03 17:20:40.340462', '8645782395347271671', 99, 'after', 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271565', '8645782395347271570', '1004', '2025-06-03 14:20:50.559584', '2025-06-03 17:20:40.340462', '8645782395347271642', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271514', '8645782395347271530', '1005', '2025-06-03 14:23:02.684821', '2025-06-03 17:20:40.340462', '8645782395347271642', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507288', '8642875801999507305', '1002', '2025-06-04 10:47:45.893072', '2025-06-04 10:58:42.864674', '8642875801999507290', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507404', '8642875801999507419', '1002', '2025-06-04 10:22:31.366884', '2025-06-04 10:39:19.071428', '8642875801999507409', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507397', '8642875801999507403', '1002', '2025-06-04 10:22:32.68967', '2025-06-04 10:39:20.295418', '8642875801999507400', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642723176041676780', '8642723176041676797', '1002', '2025-06-04 11:37:00.842688', '2025-06-04 11:39:46.427804', '8642723176041676782', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507394', '8642875801999507448', '1002', '2025-06-04 10:22:34.016304', '2025-06-04 10:39:21.515047', '8642875801999507396', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507405', '8642875801999507421', '1002', '2025-06-04 10:22:31.365887', '2025-06-04 10:39:22.736551', '8642875801999507409', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507398', '8642875801999507454', '1002', '2025-06-04 10:22:32.68967', '2025-06-04 10:39:23.342399', '8642875801999507400', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338174', '8642197643843338190', '1002', '2025-06-04 15:55:13.489142', '2025-06-04 16:39:34.683555', '8642197643843338180', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507243', '8642875801999507306', '1002', '2025-06-04 10:47:54.300587', '2025-06-04 10:58:44.593298', '8642875801999507245', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642723176041676783', '8642723176041676794', '1002', '2025-06-04 11:37:00.146396', '2025-06-04 11:39:48.857353', '8642723176041676786', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507291', '8642875801999507302', '1002', '2025-06-04 10:47:45.22959', '2025-06-04 10:58:45.166279', '8642875801999507294', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642723176041676755', '8642723176041676794', '1002', '2025-06-04 11:37:05.522574', '2025-06-04 11:39:50.657418', '8642723176041676757', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642723176041676766', '8642723176041676778', '1002', '2025-06-04 11:37:03.559944', '2025-06-04 11:39:51.260299', '8642723176041676768', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338176', '8642197643843338186', '1002', '2025-06-04 15:55:13.489142', '2025-06-04 16:39:34.683555', '8642197643843338180', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338175', '8642197643843338193', '1002', '2025-06-04 15:55:13.489142', '2025-06-04 16:39:34.683555', '8642197643843338180', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338164', '8642197643843338181', '1002', '2025-06-04 15:55:15.406408', '2025-06-04 16:39:35.297564', '8642197643843338166', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338177', '8642197643843338187', '1002', '2025-06-04 15:55:13.489142', '2025-06-04 16:39:35.297564', '8642197643843338181', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338159', '8642197643843338173', '1002', '2025-06-04 15:55:16.063421', '2025-06-04 16:39:35.914779', '8642197643843338162', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338155', '8642197643843338173', '1002', '2025-06-04 15:55:16.704616', '2025-06-04 16:39:35.914779', '8642197643843338158', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271525', '8645782395347271531', '1005', '2025-06-03 14:23:01.17262', '2025-06-03 17:20:41.518918', '8645782395347271586', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271364', '8645924713383591847', '1001', '2025-06-03 14:27:15.414261', '2025-06-03 17:20:41.518918', '8645782395347271586', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271362', '8645782395347271659', '1001', '2025-06-03 14:27:15.681534', '2025-06-03 17:20:41.518918', '8645782395347271586', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271361', '8645782395347271658', '1001', '2025-06-03 14:27:15.815117', '2025-06-03 17:20:41.518918', '8645782395347271586', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271360', '8645782395347271618', '1001', '2025-06-03 14:27:15.950635', '2025-06-03 17:20:41.518918', '8645782395347271586', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271359', '8645782395347271617', '1001', '2025-06-03 14:27:16.084321', '2025-06-03 17:20:41.518918', '8645782395347271586', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271358', '8645782395347271616', '1001', '2025-06-03 14:27:16.21946', '2025-06-03 17:20:41.518918', '8645782395347271586', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271357', '8645782395347271613', '1001', '2025-06-03 14:27:16.352843', '2025-06-03 17:20:41.518918', '8645782395347271586', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271356', '8645782395347271612', '1001', '2025-06-03 14:27:16.487027', '2025-06-03 17:20:41.518918', '8645782395347271586', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271355', '8645782395347271581', '1001', '2025-06-03 14:27:16.620338', '2025-06-03 17:20:41.518918', '8645782395347271586', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271354', '8645924713383591862', '1005', '2025-06-03 14:27:17.205171', '2025-06-03 17:20:41.518918', '8645782395347271586', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271353', '8645924713383591860', '1004', '2025-06-03 14:27:17.428337', '2025-06-03 17:20:41.518918', '8645782395347271586', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271554', '8645782395347271569', '1004', '2025-06-03 14:20:52.100933', '2025-06-03 17:20:42.108635', '8645782395347271623', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271533', '8645782395347271540', '1005', '2025-06-03 14:22:09.001367', '2025-06-03 17:20:42.108635', '8645782395347271623', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271363', '8645924713383591846', '1001', '2025-06-03 14:27:15.548168', '2025-06-03 17:25:24.997261', '8645782395347271586', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271553', '8645782395347271569', '1004', '2025-06-03 14:20:52.227635', '2025-06-03 17:20:43.287603', '8645782395347271622', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271535', '8645782395347271541', '1005', '2025-06-03 14:22:08.617317', '2025-06-03 17:20:43.287603', '8645782395347271622', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645046787708551120', '8645782395347271593', '1002', '2025-06-03 16:59:39.750467', '2025-06-03 17:20:43.287603', '8645782395347271622', 99, 'after', 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645046787708551118', '8645782395347271608', '1002', '2025-06-03 16:59:41.287678', '2025-06-03 17:20:43.875863', '8645782395347271671', 99, 'after', 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645046787708551122', '8645782395347271608', '1002', '2025-06-03 16:59:38.860038', '2025-06-03 17:20:43.875863', '8645782395347271625', 99, 'before', 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271564', '8645782395347271570', '1004', '2025-06-03 14:20:50.686924', '2025-06-03 17:20:43.875863', '8645782395347271608', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271529', '8645782395347271531', '1005', '2025-06-03 14:23:00.666773', '2025-06-03 17:20:43.875863', '8645782395347271608', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271513', '8645782395347271530', '1005', '2025-06-03 14:23:02.809488', '2025-06-03 17:20:43.875863', '8645782395347271608', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271395', '8645782395347271658', '1001', '2025-06-03 14:27:09.210336', '2025-06-03 17:20:43.875863', '8645782395347271608', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271394', '8645782395347271591', '1001', '2025-06-03 14:27:09.344991', '2025-06-03 17:20:43.875863', '8645782395347271608', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271393', '8645782395347271582', '1001', '2025-06-03 14:27:09.479477', '2025-06-03 17:20:43.875863', '8645782395347271608', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271552', '8645782395347271569', '1004', '2025-06-03 14:20:52.3556', '2025-06-03 17:20:44.460387', '8645782395347271603', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271528', '8645782395347271531', '1005', '2025-06-03 14:23:00.791111', '2025-06-03 17:20:44.460387', '8645782395347271603', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271512', '8645782395347271530', '1005', '2025-06-03 14:23:02.935151', '2025-06-03 17:20:44.460387', '8645782395347271603', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271392', '8645782395347271662', '1001', '2025-06-03 14:27:10.105916', '2025-06-03 17:20:44.460387', '8645782395347271603', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271391', '8645782395347271661', '1001', '2025-06-03 14:27:10.24083', '2025-06-03 17:20:44.460387', '8645782395347271603', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271390', '8645782395347271660', '1001', '2025-06-03 14:27:10.374227', '2025-06-03 17:20:44.460387', '8645782395347271603', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271389', '8645782395347271659', '1001', '2025-06-03 14:27:10.507012', '2025-06-03 17:20:44.460387', '8645782395347271603', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271388', '8645782395347271658', '1001', '2025-06-03 14:27:10.641449', '2025-06-03 17:20:44.460387', '8645782395347271603', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271387', '8645782395347271591', '1001', '2025-06-03 14:27:10.777148', '2025-06-03 17:20:44.460387', '8645782395347271603', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271386', '8645782395347271590', '1001', '2025-06-03 14:27:10.911051', '2025-06-03 17:20:44.460387', '8645782395347271603', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271385', '8645782395347271583', '1001', '2025-06-03 14:27:11.043905', '2025-06-03 17:20:44.460387', '8645782395347271603', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271384', '8645782395347271582', '1001', '2025-06-03 14:27:11.176426', '2025-06-03 17:20:44.460387', '8645782395347271603', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271383', '8645782395347271581', '1001', '2025-06-03 14:27:11.309951', '2025-06-03 17:20:44.460387', '8645782395347271603', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645046787708551133', '8645782395347271623', '1002', '2025-06-03 16:59:27.317207', '2025-06-03 17:20:44.460387', '8645782395347271603', 99, 'before', 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271456', '8645782395347271663', '1001', '2025-06-03 14:26:56.620188', '2025-06-03 17:20:45.046441', '8645924713383591825', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271455', '8645782395347271660', '1001', '2025-06-03 14:26:56.754276', '2025-06-03 17:20:45.046441', '8645924713383591825', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271454', '8645782395347271612', '1001', '2025-06-03 14:26:56.891283', '2025-06-03 17:20:45.046441', '8645924713383591825', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271453', '8645924713383591893', '1005', '2025-06-03 14:26:57.298958', '2025-06-03 17:20:45.046441', '8645924713383591825', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271452', '8645924713383591862', '1005', '2025-06-03 14:26:57.435592', '2025-06-03 17:20:45.046441', '8645924713383591825', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271451', '8645924713383591860', '1004', '2025-06-03 14:26:57.613086', '2025-06-03 17:20:45.046441', '8645924713383591825', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8644989441305214969', '8645924713383591828', '1002', '2025-06-03 17:18:53.87253', '2025-06-03 17:20:45.636151', '8644989441305214972', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507422', '8642875801999507446', '1002', '2025-06-04 10:22:27.803369', '2025-06-04 10:39:19.684455', '8642875801999507424', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645046787708551127', '8645924713383591828', '1002', '2025-06-03 16:59:32.626255', '2025-06-03 17:20:45.636151', '8645782395347271648', 99, 'after', 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271408', '8645782395347271663', '1001', '2025-06-03 14:27:05.400425', '2025-06-03 17:20:45.636151', '8645924713383591828', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271407', '8645782395347271662', '1001', '2025-06-03 14:27:05.535132', '2025-06-03 17:20:45.636151', '8645924713383591828', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271406', '8645782395347271661', '1001', '2025-06-03 14:27:05.670522', '2025-06-03 17:20:45.636151', '8645924713383591828', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271405', '8645782395347271660', '1001', '2025-06-03 14:27:05.803868', '2025-06-03 17:20:45.636151', '8645924713383591828', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271404', '8645782395347271659', '1001', '2025-06-03 14:27:05.939563', '2025-06-03 17:20:45.636151', '8645924713383591828', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271403', '8645782395347271614', '1001', '2025-06-03 14:27:06.076199', '2025-06-03 17:20:45.636151', '8645924713383591828', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338167', '8642197643843338173', '1002', '2025-06-04 15:55:14.758181', '2025-06-04 16:39:35.914779', '8642197643843338170', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507440', '8642875801999507445', '1002', '2025-06-04 10:22:23.27036', '2025-06-04 10:39:22.124425', '8642875801999507442', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644945289041412052', '8644945289041412075', '1002', '2025-06-03 17:51:32.857994', '2025-06-04 10:19:29.363889', '8644945289041412055', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644945289041412051', '8644945289041412058', '1002', '2025-06-03 17:51:32.857994', '2025-06-04 10:19:34.29842', '8644945289041412055', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644945289041412053', '8644989441305214884', '1002', '2025-06-03 17:51:32.856996', '2025-06-04 10:19:39.83697', '8644945289041412055', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271402', '8645782395347271613', '1001', '2025-06-03 14:27:06.211379', '2025-06-03 17:20:45.636151', '8645924713383591828', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271401', '8645782395347271612', '1001', '2025-06-03 14:27:06.346369', '2025-06-03 17:20:45.636151', '8645924713383591828', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271400', '8645782395347271591', '1001', '2025-06-03 14:27:06.480488', '2025-06-03 17:20:45.636151', '8645924713383591828', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271399', '8645782395347271590', '1001', '2025-06-03 14:27:06.61619', '2025-06-03 17:20:45.636151', '8645924713383591828', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271398', '8645924713383591893', '1005', '2025-06-03 14:27:07.019617', '2025-06-03 17:20:45.636151', '8645924713383591828', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271397', '8645924713383591862', '1005', '2025-06-03 14:27:07.154483', '2025-06-03 17:20:45.636151', '8645924713383591828', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271396', '8645924713383591900', '1004', '2025-06-03 14:27:07.334631', '2025-06-03 17:20:45.636151', '8645924713383591828', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271450', '8645924713383591893', '1005', '2025-06-03 14:26:58.065326', '2025-06-03 17:20:46.223657', '8645924713383591823', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271449', '8645924713383591862', '1005', '2025-06-03 14:26:58.200073', '2025-06-03 17:20:46.223657', '8645924713383591823', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271448', '8645924713383591860', '1004', '2025-06-03 14:26:58.380698', '2025-06-03 17:20:46.223657', '8645924713383591823', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645046787708551119', '8645782395347271595', '1002', '2025-06-03 16:59:39.751491', '2025-06-03 17:20:46.812119', '8645782395347271622', 99, 'after', 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271551', '8645782395347271569', '1004', '2025-06-03 14:20:52.483266', '2025-06-03 17:20:46.812119', '8645782395347271595', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271527', '8645782395347271531', '1005', '2025-06-03 14:23:00.91703', '2025-06-03 17:20:46.812119', '8645782395347271595', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271382', '8645924713383591855', '1001', '2025-06-03 14:27:12.113497', '2025-06-03 17:20:46.812119', '8645782395347271595', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271381', '8645924713383591847', '1001', '2025-06-03 14:27:12.246725', '2025-06-03 17:20:46.812119', '8645782395347271595', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271379', '8645924713383591836', '1001', '2025-06-03 14:27:12.515394', '2025-06-03 17:20:46.812119', '8645782395347271595', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271378', '8645782395347271663', '1001', '2025-06-03 14:27:12.649461', '2025-06-03 17:20:46.812119', '8645782395347271595', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271377', '8645782395347271662', '1001', '2025-06-03 14:27:12.784536', '2025-06-03 17:20:46.812119', '8645782395347271595', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271376', '8645782395347271660', '1001', '2025-06-03 14:27:12.918845', '2025-06-03 17:20:46.812119', '8645782395347271595', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271375', '8645782395347271659', '1001', '2025-06-03 14:27:13.051881', '2025-06-03 17:20:46.812119', '8645782395347271595', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271374', '8645782395347271658', '1001', '2025-06-03 14:27:13.185696', '2025-06-03 17:20:46.812119', '8645782395347271595', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271373', '8645782395347271614', '1001', '2025-06-03 14:27:13.318854', '2025-06-03 17:20:46.812119', '8645782395347271595', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271372', '8645782395347271591', '1001', '2025-06-03 14:27:13.452507', '2025-06-03 17:20:46.812119', '8645782395347271595', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271371', '8645782395347271590', '1001', '2025-06-03 14:27:13.58579', '2025-06-03 17:20:46.812119', '8645782395347271595', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271370', '8645924713383591893', '1005', '2025-06-03 14:27:13.990218', '2025-06-03 17:20:46.812119', '8645782395347271595', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271380', '8645924713383591846', '1001', '2025-06-03 14:27:12.381031', '2025-06-03 17:25:24.997261', '8645782395347271595', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645046787708551121', '8645782395347271572', '1002', '2025-06-03 16:59:38.860038', '2025-06-03 17:20:47.40024', '8645782395347271625', 99, 'before', 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271524', '8645782395347271531', '1005', '2025-06-03 14:23:01.299902', '2025-06-03 17:20:47.40024', '8645782395347271572', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271340', '8645924713383591900', '1004', '2025-06-03 14:27:19.763716', '2025-06-03 17:20:47.40024', '8645782395347271572', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271445', '8645924713383591846', '1001', '2025-06-03 14:26:58.830768', '2025-06-03 17:25:24.997261', '8645782395347271644', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271511', '8645782395347271530', '1005', '2025-06-03 14:23:03.059835', '2025-06-03 17:20:47.986318', '8645782395347271574', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271339', '8645782395347271663', '1001', '2025-06-03 14:27:19.942829', '2025-06-03 17:20:47.986318', '8645782395347271574', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271338', '8645782395347271616', '1001', '2025-06-03 14:27:20.075447', '2025-06-03 17:20:47.986318', '8645782395347271574', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271337', '8645782395347271582', '1001', '2025-06-03 14:27:20.20876', '2025-06-03 17:20:47.986318', '8645782395347271574', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271336', '8645924713383591893', '1005', '2025-06-03 14:27:20.611111', '2025-06-03 17:20:47.986318', '8645782395347271574', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271335', '8645924713383591900', '1004', '2025-06-03 14:27:20.835511', '2025-06-03 17:20:47.986318', '8645782395347271574', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645046787708551124', '8645782395347271642', '1002', '2025-06-03 16:59:34.664961', '2025-06-03 17:20:48.572559', '8645782395347271676', 99, 'before', 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645046787708551125', '8645924713383591828', '1002', '2025-06-03 16:59:34.664961', '2025-06-03 17:20:48.572559', '8645782395347271676', 99, 'before', 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271472', '8645924713383591881', '1005', '2025-06-03 14:26:50.943051', '2025-06-03 17:20:49.15994', '8645782395347271680', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271471', '8645924713383591860', '1004', '2025-06-03 14:26:51.126957', '2025-06-03 17:20:49.15994', '8645782395347271680', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645046787708551115', '8645782395347271586', '1002', '2025-06-03 16:59:48.658706', '2025-06-03 17:20:49.15994', '8645782395347271680', 99, 'after', 0, 100001);
INSERT INTO public.lane_ref VALUES ('8642723176041676758', '8642723176041676774', '1002', '2025-06-04 11:37:04.892469', '2025-06-04 11:39:52.46762', '8642723176041676761', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271515', '8645782395347271530', '1005', '2025-06-03 14:23:02.559157', '2025-06-03 17:20:49.745434', '8645782395347271644', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271447', '8645924713383591855', '1001', '2025-06-03 14:26:58.560018', '2025-06-03 17:20:49.745434', '8645782395347271644', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271446', '8645924713383591847', '1001', '2025-06-03 14:26:58.694378', '2025-06-03 17:20:49.745434', '8645782395347271644', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271444', '8645924713383591836', '1001', '2025-06-03 14:26:58.967391', '2025-06-03 17:20:49.745434', '8645782395347271644', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271443', '8645782395347271661', '1001', '2025-06-03 14:26:59.101482', '2025-06-03 17:20:49.745434', '8645782395347271644', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271442', '8645782395347271660', '1001', '2025-06-03 14:26:59.235903', '2025-06-03 17:20:49.745434', '8645782395347271644', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271441', '8645782395347271616', '1001', '2025-06-03 14:26:59.37074', '2025-06-03 17:20:49.745434', '8645782395347271644', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271440', '8645782395347271613', '1001', '2025-06-03 14:26:59.50631', '2025-06-03 17:20:49.745434', '8645782395347271644', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271439', '8645782395347271612', '1001', '2025-06-03 14:26:59.64177', '2025-06-03 17:20:49.745434', '8645782395347271644', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271438', '8645782395347271583', '1001', '2025-06-03 14:26:59.776882', '2025-06-03 17:20:49.745434', '8645782395347271644', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271437', '8645782395347271582', '1001', '2025-06-03 14:26:59.911905', '2025-06-03 17:20:49.745434', '8645782395347271644', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271436', '8645782395347271581', '1001', '2025-06-03 14:27:00.045815', '2025-06-03 17:20:49.745434', '8645782395347271644', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271435', '8645924713383591862', '1005', '2025-06-03 14:27:00.62818', '2025-06-03 17:20:49.745434', '8645782395347271644', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271434', '8645924713383591860', '1004', '2025-06-03 14:27:00.851637', '2025-06-03 17:20:49.745434', '8645782395347271644', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645046787708551114', '8645782395347271665', '1002', '2025-06-03 16:59:50.178456', '2025-06-03 17:20:49.745434', '8645782395347271644', 99, 'after', 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645046787708551123', '8645782395347271679', '1002', '2025-06-03 16:59:35.569496', '2025-06-03 17:20:50.337105', '8645924713383591825', 99, 'before', 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271470', '8645924713383591882', '1005', '2025-06-03 14:26:51.579267', '2025-06-03 17:20:50.337105', '8645782395347271679', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507435', '8642875801999507448', '1002', '2025-06-04 10:22:24.003001', '2025-06-04 10:39:23.948487', '8642875801999507438', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645782395347271469', '8645924713383591860', '1004', '2025-06-03 14:26:51.763563', '2025-06-03 17:20:50.337105', '8645782395347271679', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645046787708551116', '8645782395347271644', '1002', '2025-06-03 16:59:42.234544', '2025-06-03 17:20:50.337105', '8645782395347271679', 99, 'after', 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645046787708551130', '8645924713383591884', '1005', '2025-06-03 16:59:30.547255', '2025-06-03 17:20:50.924473', '8645046787708551144', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645046787708551129', '8645924713383591900', '1004', '2025-06-03 16:59:30.728933', '2025-06-03 17:20:50.924473', '8645046787708551144', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645046787708551138', '8645782395347271572', '1002', '2025-06-03 16:57:44.518131', '2025-06-03 17:20:50.924473', '8645046787708551144', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645046787708551137', '8645782395347271574', '1002', '2025-06-03 16:57:44.518131', '2025-06-03 17:20:50.924473', '8645046787708551144', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645046787708551140', '8645275692285558771', '1002', '2025-06-03 16:57:44.517135', '2025-06-03 17:20:51.513021', '8645046787708551145', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645046787708551132', '8645924713383591883', '1005', '2025-06-03 16:59:29.546196', '2025-06-03 17:20:51.513021', '8645046787708551145', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645046787708551131', '8645924713383591900', '1004', '2025-06-03 16:59:29.726713', '2025-06-03 17:20:51.513021', '8645046787708551145', 99, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8645046787708551141', '8645924713383591828', '1002', '2025-06-03 16:57:44.517135', '2025-06-03 17:20:51.513021', '8645046787708551145', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645046787708551139', '8645046787708551150', '1002', '2025-06-03 16:57:44.517135', '2025-06-03 17:20:52.684808', '8645046787708551144', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8645046787708551134', '8645046787708551147', '1002', '2025-06-03 16:57:45.187654', '2025-06-03 17:20:53.272441', '8645046787708551136', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642946617420283901', '8644945289041412075', '1002', '2025-06-04 09:50:39.708081', '2025-06-04 10:19:29.363889', '8642946617420283904', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642946617420283900', '8644945289041412058', '1002', '2025-06-04 09:50:39.712043', '2025-06-04 10:19:34.29842', '8642946617420283904', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642946617420283902', '8644989441305214884', '1002', '2025-06-04 09:50:39.704063', '2025-06-04 10:19:39.83697', '8642946617420283904', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507439', '8642875801999507450', '1002', '2025-06-04 10:22:23.271358', '2025-06-04 10:39:24.556251', '8642875801999507442', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507406', '8642875801999507415', '1002', '2025-06-04 10:22:31.365887', '2025-06-04 10:39:25.772483', '8642875801999507409', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507401', '8642875801999507412', '1002', '2025-06-04 10:22:32.006567', '2025-06-04 10:39:26.378265', '8642875801999507403', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8644945289041412059', '8644989441305214860', '1002', '2025-06-03 17:48:46.674639', '2025-06-04 10:39:27.588886', '8644945289041412061', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507388', '8644989441305214860', '1002', '2025-06-04 10:22:35.198737', '2025-06-04 10:39:27.588886', '8642875801999507390', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507417', '8644989441305214857', '1002', '2025-06-04 10:22:28.944192', '2025-06-04 10:39:28.194924', '8642875801999507419', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507431', '8644989441305214857', '1002', '2025-06-04 10:22:25.992997', '2025-06-04 10:39:28.799531', '8642875801999507434', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507436', '8642875801999507453', '1002', '2025-06-04 10:22:24.003001', '2025-06-04 10:39:29.407639', '8642875801999507438', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507432', '8642875801999507453', '1002', '2025-06-04 10:22:25.991999', '2025-06-04 10:39:29.407639', '8642875801999507434', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507425', '8644989441305214860', '1002', '2025-06-04 10:22:27.201713', '2025-06-04 10:39:30.013328', '8642875801999507427', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507428', '8644989441305214861', '1002', '2025-06-04 10:22:26.59947', '2025-06-04 10:39:30.616611', '8642875801999507430', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642723176041676763', '8642723176041676777', '1002', '2025-06-04 11:37:04.224474', '2025-06-04 11:39:53.679831', '8642723176041676765', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642723176041676779', '8642723176041676792', '1002', '2025-06-04 11:37:00.842688', '2025-06-04 11:39:54.289379', '8642723176041676782', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642723176041676762', '8642723176041676792', '1002', '2025-06-04 11:37:04.225471', '2025-06-04 11:39:54.289379', '8642723176041676765', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642723176041676727', '8642723176041676792', '1002', '2025-06-04 11:37:10.921979', '2025-06-04 11:39:54.888122', '8642723176041676730', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642723176041676759', '8642723176041676790', '1002', '2025-06-04 11:37:04.892469', '2025-06-04 11:39:55.495', '8642723176041676761', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338171', '8642197643843338183', '1002', '2025-06-04 15:55:14.098929', '2025-06-04 16:39:35.914779', '8642197643843338173', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642723176041676784', '8642723176041676789', '1002', '2025-06-04 11:37:00.146396', '2025-06-04 11:39:57.308782', '8642723176041676786', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642723176041676728', '8642723176041676745', '1002', '2025-06-04 11:37:10.921979', '2025-06-04 11:39:58.519212', '8642723176041676730', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642723176041676741', '8642723176041676751', '1002', '2025-06-04 11:37:08.59295', '2025-06-04 11:39:58.519212', '8642723176041676745', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507231', '8642875801999507285', '1002', '2025-06-04 10:47:56.200081', '2025-06-04 10:58:47.465296', '8642875801999507233', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507271', '8642875801999507285', '1002', '2025-06-04 10:47:48.971098', '2025-06-04 10:58:47.465296', '8642875801999507273', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507287', '8642875801999507300', '1002', '2025-06-04 10:47:45.893072', '2025-06-04 10:58:48.621303', '8642875801999507290', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507238', '8642875801999507300', '1002', '2025-06-04 10:47:54.951039', '2025-06-04 10:58:48.621303', '8642875801999507241', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507268', '8642875801999507298', '1002', '2025-06-04 10:47:49.522817', '2025-06-04 10:58:49.195015', '8642875801999507270', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507292', '8642875801999507297', '1002', '2025-06-04 10:47:45.22959', '2025-06-04 10:58:49.76863', '8642875801999507294', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507235', '8642875801999507297', '1002', '2025-06-04 10:47:55.577602', '2025-06-04 10:58:49.76863', '8642875801999507237', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507347', '8642875801999507361', '1002', '2025-06-04 10:39:56.332271', '2025-06-04 10:47:23.88323', '8642875801999507349', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507274', '8642875801999507286', '1002', '2025-06-04 10:47:48.412114', '2025-06-04 10:58:50.343766', '8642875801999507276', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507277', '8642875801999507282', '1002', '2025-06-04 10:47:47.847704', '2025-06-04 10:58:50.920819', '8642875801999507280', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507263', '8642875801999507282', '1002', '2025-06-04 10:47:50.579739', '2025-06-04 10:58:50.920819', '8642875801999507265', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507239', '8642875801999507256', '1002', '2025-06-04 10:47:54.951039', '2025-06-04 10:58:51.496821', '8642875801999507241', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507249', '8642875801999507265', '1002', '2025-06-04 10:47:53.0876', '2025-06-04 10:58:52.072154', '8642875801999507255', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507250', '8642875801999507267', '1002', '2025-06-04 10:47:53.0876', '2025-06-04 10:58:52.072154', '8642875801999507255', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507230', '8642875801999507248', '1002', '2025-06-04 10:47:56.200081', '2025-06-04 10:58:52.649181', '8642875801999507233', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507242', '8642875801999507248', '1002', '2025-06-04 10:47:54.300587', '2025-06-04 10:58:52.649181', '8642875801999507245', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507234', '8642875801999507248', '1002', '2025-06-04 10:47:55.577602', '2025-06-04 10:58:52.649181', '8642875801999507237', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507252', '8642875801999507262', '1002', '2025-06-04 10:47:53.0876', '2025-06-04 10:59:05.000528', '8642875801999507256', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507251', '8642875801999507261', '1002', '2025-06-04 10:47:53.0876', '2025-06-04 10:59:05.587776', '8642875801999507255', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507246', '8642875801999507258', '1002', '2025-06-04 10:47:53.668628', '2025-06-04 10:59:06.165134', '8642875801999507248', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507151', '8642875801999507206', '1002', '2025-06-04 10:59:22.691119', '2025-06-04 11:03:19.170322', '8642875801999507153', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507192', '8642875801999507206', '1002', '2025-06-04 10:59:15.616442', '2025-06-04 11:03:19.170322', '8642875801999507194', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507191', '8642875801999507221', '1002', '2025-06-04 10:59:15.616442', '2025-06-04 11:03:20.969119', '8642875801999507194', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507188', '8642875801999507219', '1002', '2025-06-04 10:59:16.181927', '2025-06-04 11:03:21.567694', '8642875801999507190', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507213', '8642875801999507218', '1002', '2025-06-04 10:59:11.781844', '2025-06-04 11:03:23.368182', '8642875801999507215', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507212', '8642875801999507223', '1002', '2025-06-04 10:59:11.781844', '2025-06-04 11:03:23.368182', '8642875801999507215', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507209', '8642875801999507226', '1002', '2025-06-04 10:59:12.449795', '2025-06-04 11:03:23.966706', '8642875801999507211', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507208', '8642875801999507221', '1002', '2025-06-04 10:59:12.449795', '2025-06-04 11:03:23.966706', '8642875801999507211', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507159', '8642875801999507176', '1002', '2025-06-04 10:59:21.432856', '2025-06-04 11:03:24.565797', '8642875801999507161', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507158', '8642875801999507221', '1002', '2025-06-04 10:59:21.432856', '2025-06-04 11:03:24.565797', '8642875801999507161', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507170', '8642875801999507187', '1002', '2025-06-04 10:59:19.585378', '2025-06-04 11:03:25.161551', '8642875801999507175', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507162', '8642875801999507168', '1002', '2025-06-04 10:59:20.796556', '2025-06-04 11:03:25.763215', '8642875801999507165', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507163', '8642875801999507227', '1002', '2025-06-04 10:59:20.796556', '2025-06-04 11:03:25.763215', '8642875801999507165', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507154', '8642875801999507168', '1002', '2025-06-04 10:59:22.071146', '2025-06-04 11:03:26.359822', '8642875801999507157', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507155', '8642875801999507218', '1002', '2025-06-04 10:59:22.071146', '2025-06-04 11:03:26.359822', '8642875801999507157', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507195', '8642875801999507207', '1002', '2025-06-04 10:59:14.978078', '2025-06-04 11:03:27.557432', '8642875801999507197', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507199', '8642875801999507226', '1002', '2025-06-04 10:59:14.40988', '2025-06-04 11:03:28.156985', '8642875801999507201', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507198', '8642875801999507203', '1002', '2025-06-04 10:59:14.40988', '2025-06-04 11:03:28.156985', '8642875801999507201', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507169', '8642875801999507185', '1002', '2025-06-04 10:59:19.585378', '2025-06-04 11:03:28.753975', '8642875801999507175', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507183', '8642875801999507203', '1002', '2025-06-04 10:59:17.221101', '2025-06-04 11:03:28.753975', '8642875801999507185', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507172', '8642875801999507182', '1002', '2025-06-04 10:59:19.584803', '2025-06-04 11:03:29.355078', '8642875801999507176', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507171', '8642875801999507181', '1002', '2025-06-04 10:59:19.584803', '2025-06-04 11:03:29.951139', '8642875801999507175', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507166', '8642875801999507178', '1002', '2025-06-04 10:59:20.164247', '2025-06-04 11:03:30.546099', '8642875801999507168', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642723176041676731', '8642723176041676737', '1002', '2025-06-04 11:37:10.241873', '2025-06-04 11:39:59.121066', '8642723176041676734', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642723176041676735', '8642723176041676747', '1002', '2025-06-04 11:37:09.204489', '2025-06-04 11:39:59.121066', '8642723176041676737', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646188', '8642101470935646193', '1002', '2025-06-04 16:39:52.759118', '2025-06-04 16:39:52.759118', '8642101470935646190', 0, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642718640556212140', '8642718640556212202', '1002', '2025-06-04 11:44:15.726636', '2025-06-04 11:49:33.621434', '8642718640556212142', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646187', '8642101470935646198', '1002', '2025-06-04 16:39:52.760089', '2025-06-04 16:39:52.760089', '8642101470935646190', 0, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646184', '8642101470935646201', '1002', '2025-06-04 16:39:53.483027', '2025-06-04 16:39:53.483027', '8642101470935646186', 0, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646183', '8642101470935646196', '1002', '2025-06-04 16:39:53.484023', '2025-06-04 16:39:53.484023', '8642101470935646186', 0, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646174', '8642101470935646201', '1002', '2025-06-04 16:39:55.647664', '2025-06-04 16:39:55.647664', '8642101470935646176', 0, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646173', '8642101470935646178', '1002', '2025-06-04 16:39:55.647664', '2025-06-04 16:39:55.647664', '8642101470935646176', 0, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646170', '8642101470935646182', '1002', '2025-06-04 16:39:56.342132', '2025-06-04 16:39:56.342132', '8642101470935646172', 0, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646169', '8642101470935646198', '1002', '2025-06-04 16:39:56.343129', '2025-06-04 16:39:56.343129', '8642101470935646172', 0, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646166', '8642101470935646181', '1002', '2025-06-04 16:39:57.033219', '2025-06-04 16:39:57.033219', '8642101470935646168', 0, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646165', '8642101470935646196', '1002', '2025-06-04 16:39:57.033219', '2025-06-04 16:39:57.033219', '8642101470935646168', 0, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646162', '8642101470935646194', '1002', '2025-06-04 16:39:57.728241', '2025-06-04 16:39:57.728241', '8642101470935646164', 0, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646161', '8642101470935646178', '1002', '2025-06-04 16:39:57.728241', '2025-06-04 16:39:57.728241', '8642101470935646164', 0, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646158', '8642101470935646198', '1002', '2025-06-04 16:39:58.398382', '2025-06-04 16:39:58.398382', '8642101470935646160', 0, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646155', '8642101470935646178', '1002', '2025-06-04 16:39:59.031542', '2025-06-04 16:39:59.031542', '8642101470935646157', 0, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646144', '8642101470935646154', '1002', '2025-06-04 16:40:01.583049', '2025-06-04 16:40:01.583049', '8642101470935646148', 0, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646143', '8642101470935646153', '1002', '2025-06-04 16:40:01.583049', '2025-06-04 16:40:01.583049', '8642101470935646147', 0, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646142', '8642101470935646160', '1002', '2025-06-04 16:40:01.584011', '2025-06-04 16:40:01.584011', '8642101470935646147', 0, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646141', '8642101470935646157', '1002', '2025-06-04 16:40:01.584011', '2025-06-04 16:40:01.584011', '8642101470935646147', 0, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646138', '8642101470935646150', '1002', '2025-06-04 16:40:02.22185', '2025-06-04 16:40:02.22185', '8642101470935646140', 0, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646135', '8642101470935646202', '1002', '2025-06-04 16:40:02.907792', '2025-06-04 16:40:02.907792', '8642101470935646137', 0, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646134', '8642101470935646140', '1002', '2025-06-04 16:40:02.90879', '2025-06-04 16:40:02.90879', '8642101470935646137', 0, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646131', '8642101470935646148', '1002', '2025-06-04 16:40:03.592335', '2025-06-04 16:40:03.592335', '8642101470935646133', 0, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646130', '8642101470935646196', '1002', '2025-06-04 16:40:03.592335', '2025-06-04 16:40:03.592335', '8642101470935646133', 0, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646127', '8642101470935646193', '1002', '2025-06-04 16:40:04.2808', '2025-06-04 16:40:04.281797', '8642101470935646129', 0, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646126', '8642101470935646140', '1002', '2025-06-04 16:40:04.281797', '2025-06-04 16:40:04.281797', '8642101470935646129', 0, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646123', '8642101470935646181', '1002', '2025-06-04 16:40:04.96024', '2025-06-04 16:40:04.96024', '8642101470935646125', 0, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646122', '8642101470935646140', '1002', '2025-06-04 16:40:04.961238', '2025-06-04 16:40:04.961238', '8642101470935646125', 0, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507105', '8642875801999507143', '1002', '2025-06-04 11:03:46.382543', '2025-06-04 11:30:23.624447', '8642875801999507107', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507132', '8642875801999507143', '1002', '2025-06-04 11:03:41.215495', '2025-06-04 11:30:24.229429', '8642875801999507135', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507129', '8642875801999507146', '1002', '2025-06-04 11:03:41.897981', '2025-06-04 11:30:26.031019', '8642875801999507131', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507119', '8642875801999507146', '1002', '2025-06-04 11:03:43.918683', '2025-06-04 11:30:28.42187', '8642875801999507121', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507082', '8642875801999507147', '1002', '2025-06-04 11:03:50.62839', '2025-06-04 11:30:29.021525', '8642875801999507084', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507115', '8642875801999507127', '1002', '2025-06-04 11:03:44.523259', '2025-06-04 11:30:29.629426', '8642875801999507117', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642765198001700858', '8642875801999507127', '1002', '2025-06-04 11:20:22.047248', '2025-06-04 11:30:29.629426', '8642765198001700860', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642765198001700855', '8642875801999507127', '1002', '2025-06-04 11:25:35.340907', '2025-06-04 11:30:29.629426', '8642765198001700857', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507102', '8642875801999507123', '1002', '2025-06-04 11:03:46.980663', '2025-06-04 11:30:30.233786', '8642875801999507104', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642765198001700861', '8642875801999507123', '1002', '2025-06-04 11:17:19.768072', '2025-06-04 11:30:30.233786', '8642765198001700864', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507118', '8642875801999507123', '1002', '2025-06-04 11:03:43.918683', '2025-06-04 11:30:30.233786', '8642875801999507121', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507112', '8642875801999507126', '1002', '2025-06-04 11:03:45.16954', '2025-06-04 11:30:30.857147', '8642875801999507114', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507070', '8642875801999507126', '1002', '2025-06-04 11:03:52.566901', '2025-06-04 11:30:30.857147', '8642875801999507072', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642743998043127805', '8642875801999507143', '1002', '2025-06-04 11:27:47.69377', '2025-06-04 11:30:31.469176', '8642743998043127808', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642743998043127806', '8642875801999507127', '1002', '2025-06-04 11:27:47.692772', '2025-06-04 11:30:31.469176', '8642743998043127808', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507128', '8642875801999507141', '1002', '2025-06-04 11:03:41.897981', '2025-06-04 11:30:32.06407', '8642875801999507131', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507077', '8642875801999507141', '1002', '2025-06-04 11:03:51.281286', '2025-06-04 11:30:32.06407', '8642875801999507080', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507111', '8642875801999507141', '1002', '2025-06-04 11:03:45.17051', '2025-06-04 11:30:32.06407', '8642875801999507114', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507108', '8642875801999507139', '1002', '2025-06-04 11:03:45.778722', '2025-06-04 11:30:32.671166', '8642875801999507110', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642765198001700862', '8642875801999507139', '1002', '2025-06-04 11:17:19.767075', '2025-06-04 11:30:32.671166', '8642765198001700864', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507133', '8642875801999507138', '1002', '2025-06-04 11:03:41.215495', '2025-06-04 11:30:33.276547', '8642875801999507135', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507074', '8642875801999507138', '1002', '2025-06-04 11:03:51.927633', '2025-06-04 11:30:33.276547', '8642875801999507076', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507089', '8642875801999507107', '1002', '2025-06-04 11:03:49.378216', '2025-06-04 11:30:34.471926', '8642875801999507094', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507088', '8642875801999507104', '1002', '2025-06-04 11:03:49.378216', '2025-06-04 11:30:34.471926', '8642875801999507094', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507081', '8642875801999507087', '1002', '2025-06-04 11:03:50.62839', '2025-06-04 11:30:35.068925', '8642875801999507084', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507073', '8642875801999507087', '1002', '2025-06-04 11:03:51.927633', '2025-06-04 11:30:35.068925', '8642875801999507076', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507069', '8642875801999507087', '1002', '2025-06-04 11:03:52.566901', '2025-06-04 11:30:35.068925', '8642875801999507072', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507078', '8642875801999507095', '1002', '2025-06-04 11:03:51.281286', '2025-06-04 11:30:35.672312', '8642875801999507080', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507091', '8642875801999507101', '1002', '2025-06-04 11:03:49.378216', '2025-06-04 11:30:36.271583', '8642875801999507095', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507090', '8642875801999507100', '1002', '2025-06-04 11:03:49.378216', '2025-06-04 11:30:36.871222', '8642875801999507094', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642875801999507085', '8642875801999507097', '1002', '2025-06-04 11:03:49.976328', '2025-06-04 11:30:37.475239', '8642875801999507087', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642735957864349676', '8642735957864349693', '1002', '2025-06-04 11:31:06.159521', '2025-06-04 11:36:19.105191', '8642735957864349678', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642735957864349680', '8642735957864349685', '1002', '2025-06-04 11:31:05.373622', '2025-06-04 11:36:31.390988', '8642735957864349682', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642735957864349679', '8642735957864349690', '1002', '2025-06-04 11:31:05.373622', '2025-06-04 11:36:31.390988', '8642735957864349682', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646100', '8642101470935646104', '1002', '2025-06-04 16:48:13.791147', '2025-06-04 17:28:37.503923', '8642101470935646102', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646059', '8642101470935646083', '1002', '2025-06-04 17:04:42.158773', '2025-06-04 17:28:38.663176', '8642101470935646061', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642718640556212190', '8642718640556212202', '1002', '2025-06-04 11:41:29.369793', '2025-06-04 11:49:33.621434', '8642718640556212192', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642718640556212193', '8642718640556212198', '1002', '2025-06-04 11:41:28.730521', '2025-06-04 11:49:34.216545', '8642718640556212196', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642698677548220381', '8642698677548220410', '1002', '2025-06-04 11:50:39.972119', '2025-06-04 14:10:09.134291', '8642698677548220384', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642718640556212147', '8642718640556212161', '1002', '2025-06-04 11:41:36.961003', '2025-06-04 11:49:42.483757', '8642718640556212150', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642698677548220399', '8642698677548220410', '1002', '2025-06-04 11:50:36.496316', '2025-06-04 14:10:09.134291', '8642698677548220402', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642718640556212155', '8642718640556212161', '1002', '2025-06-04 11:41:35.643123', '2025-06-04 11:49:42.483757', '8642718640556212158', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642735957864349664', '8642735957864349693', '1002', '2025-06-04 11:31:08.546436', '2025-06-04 11:36:17.922641', '8642735957864349666', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642718640556212152', '8642718640556212169', '1002', '2025-06-04 11:41:36.297972', '2025-06-04 11:49:43.084526', '8642718640556212154', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642735957864349652', '8642735957864349670', '1002', '2025-06-04 11:31:10.629708', '2025-06-04 11:36:19.69142', '8642735957864349655', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642735957864349646', '8642735957864349670', '1002', '2025-06-04 11:31:11.908791', '2025-06-04 11:36:19.69142', '8642735957864349648', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642718640556212143', '8642718640556212161', '1002', '2025-06-04 11:41:37.624084', '2025-06-04 11:49:43.671522', '8642718640556212146', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642698677548220370', '8642698677548220410', '1002', '2025-06-04 11:50:41.941819', '2025-06-04 14:10:10.410395', '8642698677548220372', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642735957864349661', '8642735957864349674', '1002', '2025-06-04 11:31:09.241233', '2025-06-04 11:36:20.276861', '8642735957864349663', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642735957864349668', '8642735957864349674', '1002', '2025-06-04 11:31:07.894121', '2025-06-04 11:36:20.276861', '8642735957864349670', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642735957864349667', '8642735957864349674', '1002', '2025-06-04 11:31:07.895095', '2025-06-04 11:36:20.276861', '8642735957864349670', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642718640556212144', '8642718640556212201', '1002', '2025-06-04 11:41:37.624084', '2025-06-04 11:49:44.845523', '8642718640556212146', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642718640556212148', '8642718640556212213', '1002', '2025-06-04 11:41:36.961003', '2025-06-04 11:49:46.612101', '8642718640556212150', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642735957864349657', '8642735957864349673', '1002', '2025-06-04 11:31:09.9396', '2025-06-04 11:36:21.446227', '8642735957864349659', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642735957864349675', '8642735957864349688', '1002', '2025-06-04 11:31:06.160519', '2025-06-04 11:36:22.612827', '8642735957864349678', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642735957864349656', '8642735957864349688', '1002', '2025-06-04 11:31:09.940598', '2025-06-04 11:36:22.612827', '8642735957864349659', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642735957864349653', '8642735957864349686', '1002', '2025-06-04 11:31:10.629708', '2025-06-04 11:36:23.784446', '8642735957864349655', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642718640556212151', '8642718640556212216', '1002', '2025-06-04 11:41:36.297972', '2025-06-04 11:49:47.213948', '8642718640556212154', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642718640556212159', '8642718640556212171', '1002', '2025-06-04 11:41:34.985143', '2025-06-04 11:49:48.986788', '8642718640556212161', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642735957864349660', '8642735957864349690', '1002', '2025-06-04 11:31:09.241233', '2025-06-04 11:36:27.875711', '8642735957864349663', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642735957864349649', '8642735957864349690', '1002', '2025-06-04 11:31:11.273796', '2025-06-04 11:36:30.208981', '8642735957864349651', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642735957864349639', '8642735957864349645', '1002', '2025-06-04 11:31:13.368897', '2025-06-04 11:36:30.80427', '8642735957864349641', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642718640556212156', '8642718640556212222', '1002', '2025-06-04 11:41:35.643123', '2025-06-04 11:49:38.953743', '8642718640556212158', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642698677548220336', '8642698677548220393', '1002', '2025-06-04 11:50:48.270176', '2025-06-04 14:10:11.624845', '8642698677548220338', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642698677548220378', '8642698677548220393', '1002', '2025-06-04 11:50:40.648504', '2025-06-04 14:10:11.624845', '8642698677548220380', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642698677548220382', '8642698677548220394', '1002', '2025-06-04 11:50:39.972119', '2025-06-04 14:10:05.132327', '8642698677548220384', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642698677548220396', '8642698677548220413', '1002', '2025-06-04 11:50:37.200668', '2025-06-04 14:10:06.391487', '8642698677548220398', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642698677548220347', '8642698677548220414', '1002', '2025-06-04 11:50:46.318906', '2025-06-04 14:10:07.102487', '8642698677548220349', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642698677548220374', '8642698677548220406', '1002', '2025-06-04 11:50:41.318567', '2025-06-04 14:10:12.233212', '8642698677548220376', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642698677548220377', '8642698677548220408', '1002', '2025-06-04 11:50:40.649503', '2025-06-04 14:10:12.840935', '8642698677548220380', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642698677548220395', '8642698677548220408', '1002', '2025-06-04 11:50:37.201665', '2025-06-04 14:10:12.840935', '8642698677548220398', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642698677548220400', '8642698677548220405', '1002', '2025-06-04 11:50:36.496316', '2025-06-04 14:10:14.066061', '8642698677548220402', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642698677548220340', '8642698677548220405', '1002', '2025-06-04 11:50:47.612485', '2025-06-04 14:10:14.066061', '8642698677548220342', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646097', '8642101470935646104', '1002', '2025-06-04 16:50:12.469443', '2025-06-04 17:28:37.503923', '8642101470935646099', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646094', '8642101470935646104', '1002', '2025-06-04 16:51:33.86935', '2025-06-04 17:28:37.503923', '8642101470935646096', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642698677548220343', '8642698677548220360', '1002', '2025-06-04 11:50:46.943107', '2025-06-04 14:10:16.49988', '8642698677548220345', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642668028661596158', '8642698677548220360', '1002', '2025-06-04 12:05:23.904554', '2025-06-04 14:10:16.49988', '8642668028661596160', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642698677548220356', '8642698677548220366', '1002', '2025-06-04 11:50:45.030721', '2025-06-04 14:10:16.49988', '8642698677548220360', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642698677548220353', '8642698677548220369', '1002', '2025-06-04 11:50:45.030721', '2025-06-04 14:10:17.115262', '8642698677548220359', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642698677548220354', '8642698677548220372', '1002', '2025-06-04 11:50:45.030721', '2025-06-04 14:10:17.115262', '8642698677548220359', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646081', '8642101470935646104', '1002', '2025-06-04 16:57:23.5888', '2025-06-04 17:28:38.663176', '8642101470935646083', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646065', '8642101470935646106', '1002', '2025-06-04 17:00:10.664266', '2025-06-04 17:28:39.24105', '8642101470935646067', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416776', '8642660435159416795', '1002', '2025-06-04 14:10:44.658193', '2025-06-04 14:17:21.10645', '8642660435159416779', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416783', '8642660435159416795', '1002', '2025-06-04 14:10:43.286338', '2025-06-04 14:17:21.10645', '8642660435159416787', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416797', '8642660435159416825', '1002', '2025-06-04 14:10:41.020678', '2025-06-04 14:17:22.289051', '8642660435159416799', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416755', '8642660435159416826', '1002', '2025-06-04 14:10:48.607582', '2025-06-04 14:17:24.635757', '8642660435159416757', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416740', '8642660435159416753', '1002', '2025-06-04 14:10:50.779069', '2025-06-04 14:17:25.221153', '8642660435159416744', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416788', '8642660435159416820', '1002', '2025-06-04 14:10:42.535752', '2025-06-04 14:17:25.804944', '8642660435159416791', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416807', '8642660435159416820', '1002', '2025-06-04 14:10:38.488252', '2025-06-04 14:17:25.804944', '8642660435159416810', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416750', '8642660435159416820', '1002', '2025-06-04 14:10:49.305539', '2025-06-04 14:17:25.804944', '8642660435159416753', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416785', '8642660435159416818', '1002', '2025-06-04 14:10:43.286338', '2025-06-04 14:17:27.544698', '8642660435159416787', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416745', '8642660435159416753', '1002', '2025-06-04 14:10:50.048026', '2025-06-04 14:17:28.128846', '8642660435159416749', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416812', '8642660435159416817', '1002', '2025-06-04 14:10:37.754407', '2025-06-04 14:17:28.72661', '8642660435159416814', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416747', '8642660435159416817', '1002', '2025-06-04 14:10:50.048026', '2025-06-04 14:17:28.72661', '8642660435159416749', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416777', '8642660435159416802', '1002', '2025-06-04 14:10:44.657197', '2025-06-04 14:17:29.302015', '8642660435159416779', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416796', '8642660435159416802', '1002', '2025-06-04 14:10:41.020678', '2025-06-04 14:17:29.302015', '8642660435159416799', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416784', '8642660435159416802', '1002', '2025-06-04 14:10:43.286338', '2025-06-04 14:17:29.302015', '8642660435159416787', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416793', '8642660435159416806', '1002', '2025-06-04 14:10:41.753842', '2025-06-04 14:17:29.882879', '8642660435159416795', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416800', '8642660435159416806', '1002', '2025-06-04 14:10:40.184651', '2025-06-04 14:17:29.882879', '8642660435159416802', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416742', '8642660435159416805', '1002', '2025-06-04 14:10:50.779069', '2025-06-04 14:17:30.459343', '8642660435159416744', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416789', '8642660435159416805', '1002', '2025-06-04 14:10:42.534755', '2025-06-04 14:17:30.459343', '8642660435159416791', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416735', '8642660435159416795', '1002', '2025-06-04 14:15:59.433927', '2025-06-04 14:17:31.043482', '8642660435159416739', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416736', '8642660435159416802', '1002', '2025-06-04 14:15:59.428941', '2025-06-04 14:17:31.043482', '8642660435159416739', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416811', '8642660435159416822', '1002', '2025-06-04 14:10:37.754407', '2025-06-04 14:17:31.631715', '8642660435159416814', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416792', '8642660435159416822', '1002', '2025-06-04 14:10:41.75484', '2025-06-04 14:17:31.631715', '8642660435159416795', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416780', '8642660435159416822', '1002', '2025-06-04 14:10:43.972676', '2025-06-04 14:17:31.631715', '8642660435159416782', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416737', '8642660435159416768', '1002', '2025-06-04 14:15:59.424981', '2025-06-04 14:17:32.784157', '8642660435159416739', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416762', '8642660435159416779', '1002', '2025-06-04 14:10:47.225077', '2025-06-04 14:17:32.784157', '8642660435159416768', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416763', '8642660435159416782', '1002', '2025-06-04 14:10:47.225077', '2025-06-04 14:17:32.784157', '8642660435159416768', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416751', '8642660435159416769', '1002', '2025-06-04 14:10:49.305539', '2025-06-04 14:17:33.366116', '8642660435159416753', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416741', '8642660435159416761', '1002', '2025-06-04 14:10:50.779069', '2025-06-04 14:17:33.952861', '8642660435159416744', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416754', '8642660435159416761', '1002', '2025-06-04 14:10:48.607582', '2025-06-04 14:17:33.952861', '8642660435159416757', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416746', '8642660435159416761', '1002', '2025-06-04 14:10:50.048026', '2025-06-04 14:17:33.952861', '8642660435159416749', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416758', '8642660435159416769', '1002', '2025-06-04 14:10:47.916944', '2025-06-04 14:17:33.952861', '8642660435159416761', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416764', '8642660435159416774', '1002', '2025-06-04 14:10:47.225077', '2025-06-04 14:17:34.532475', '8642660435159416768', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416759', '8642660435159416771', '1002', '2025-06-04 14:10:47.916944', '2025-06-04 14:17:35.104019', '8642660435159416761', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642660435159416765', '8642660435159416775', '1002', '2025-06-04 14:10:47.224079', '2025-06-04 14:17:35.676881', '8642660435159416769', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646056', '8642101470935646083', '1002', '2025-06-04 17:06:35.799884', '2025-06-04 17:28:38.663176', '8642101470935646058', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642101470935646053', '8642101470935646083', '1002', '2025-06-04 17:07:36.950848', '2025-06-04 17:28:38.663176', '8642101470935646055', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640615', '8642391707645640650', '1002', '2025-06-04 14:28:40.886795', '2025-06-04 14:39:42.12229', '8642391707645640618', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640614', '8642391707645640648', '1002', '2025-06-04 14:28:40.890784', '2025-06-04 14:39:44.019381', '8642391707645640618', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640644', '8642391707645640654', '1002', '2025-06-04 14:20:26.354744', '2025-06-04 14:39:44.019381', '8642391707645640648', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640658', '8642391707645640698', '1002', '2025-06-04 14:20:23.166583', '2025-06-04 14:39:49.688854', '8642391707645640660', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640625', '8642391707645640640', '1002', '2025-06-04 14:20:29.202566', '2025-06-04 14:26:46.450909', '8642391707645640628', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640638', '8642391707645640650', '1002', '2025-06-04 14:20:27.031672', '2025-06-04 14:39:42.12229', '8642391707645640640', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640610', '8642391707645640650', '1002', '2025-06-04 14:36:21.438291', '2025-06-04 14:39:42.12229', '8642391707645640613', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640637', '8642391707645640648', '1002', '2025-06-04 14:20:27.031672', '2025-06-04 14:39:44.019381', '8642391707645640640', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640609', '8642391707645640648', '1002', '2025-06-04 14:36:21.438291', '2025-06-04 14:39:44.019381', '8642391707645640613', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640643', '8642391707645640653', '1002', '2025-06-04 14:20:26.354744', '2025-06-04 14:39:44.642997', '8642391707645640647', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895805', '8642391707645640650', '1002', '2025-06-04 14:39:07.999979', '2025-06-04 14:39:45.282035', '8642348861051895808', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640642', '8642391707645640660', '1002', '2025-06-04 14:20:26.354744', '2025-06-04 14:39:46.555113', '8642391707645640647', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640641', '8642391707645640657', '1002', '2025-06-04 14:20:26.354744', '2025-06-04 14:39:47.183693', '8642391707645640647', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640616', '8642391707645640636', '1002', '2025-06-04 14:28:40.881809', '2025-06-04 14:39:47.81171', '8642391707645640618', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640611', '8642391707645640636', '1002', '2025-06-04 14:36:21.438291', '2025-06-04 14:39:47.81171', '8642391707645640613', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895806', '8642391707645640636', '1002', '2025-06-04 14:39:07.998981', '2025-06-04 14:39:47.81171', '8642348861051895808', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640633', '8642391707645640640', '1002', '2025-06-04 14:20:27.743488', '2025-06-04 14:39:47.81171', '8642391707645640636', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640624', '8642391707645640632', '1002', '2025-06-04 14:20:29.202566', '2025-06-04 14:39:48.4388', '8642391707645640628', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640630', '8642391707645640648', '1002', '2025-06-04 14:20:28.423895', '2025-06-04 14:39:48.4388', '8642391707645640632', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640620', '8642391707645640640', '1002', '2025-06-04 14:20:29.929188', '2025-06-04 14:39:49.06618', '8642391707645640623', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640619', '8642391707645640632', '1002', '2025-06-04 14:20:29.929188', '2025-06-04 14:39:49.06618', '8642391707645640623', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640629', '8642391707645640696', '1002', '2025-06-04 14:20:28.423895', '2025-06-04 14:39:50.314528', '8642391707645640632', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640626', '8642391707645640693', '1002', '2025-06-04 14:20:29.201569', '2025-06-04 14:39:51.559883', '8642391707645640628', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640687', '8642391707645640698', '1002', '2025-06-04 14:20:17.515529', '2025-06-04 14:39:52.187076', '8642391707645640690', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640688', '8642391707645640693', '1002', '2025-06-04 14:20:17.515529', '2025-06-04 14:39:52.187076', '8642391707645640690', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640683', '8642391707645640696', '1002', '2025-06-04 14:20:18.241549', '2025-06-04 14:39:52.8147', '8642391707645640686', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8552983717042192380', '80192', '1010', '2025-07-04 17:12:20.427485', '2025-07-04 17:12:20.427485', '8642101470935646150', 0, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640669', '8642391707645640698', '1002', '2025-06-04 14:20:21.125835', '2025-06-04 14:39:53.437099', '8642391707645640672', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640665', '8642391707645640696', '1002', '2025-06-04 14:20:21.825431', '2025-06-04 14:39:54.070463', '8642391707645640668', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640662', '8642391707645640694', '1002', '2025-06-04 14:20:22.520044', '2025-06-04 14:39:54.697488', '8642391707645640664', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640634', '8642391707645640702', '1002', '2025-06-04 14:20:27.743488', '2025-06-04 14:39:55.327708', '8642391707645640636', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640684', '8642391707645640701', '1002', '2025-06-04 14:20:18.241549', '2025-06-04 14:39:55.945858', '8642391707645640686', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640670', '8642391707645640682', '1002', '2025-06-04 14:20:21.125835', '2025-06-04 14:39:56.567397', '8642391707645640672', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640621', '8642391707645640681', '1002', '2025-06-04 14:20:29.929188', '2025-06-04 14:39:57.18668', '8642391707645640623', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640666', '8642391707645640681', '1002', '2025-06-04 14:20:21.825431', '2025-06-04 14:39:57.18668', '8642391707645640668', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640655', '8642391707645640678', '1002', '2025-06-04 14:20:23.80246', '2025-06-04 14:39:57.808074', '8642391707645640657', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640661', '8642391707645640678', '1002', '2025-06-04 14:20:22.520044', '2025-06-04 14:39:57.808074', '8642391707645640664', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640674', '8642391707645640701', '1002', '2025-06-04 14:20:20.43133', '2025-06-04 14:39:58.425076', '8642391707645640676', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642391707645640673', '8642391707645640678', '1002', '2025-06-04 14:20:20.432327', '2025-06-04 14:39:58.425076', '8642391707645640676', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8552983717042192379', '80174', '1006', '2025-07-04 17:12:41.651725', '2025-07-04 17:12:41.651725', '8642101470935646153', 0, NULL, 0, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895774', '8642348861051895801', '1002', '2025-06-04 14:40:45.443671', '2025-06-04 15:54:34.587921', '8642348861051895776', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642272238835335164', '8642348861051895764', '1002', '2025-06-04 15:16:10.759022', '2025-06-04 15:54:35.197855', '8642272238835335168', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642272238835335159', '8642348861051895764', '1002', '2025-06-04 15:21:10.671544', '2025-06-04 15:54:35.197855', '8642272238835335163', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642272238835335154', '8642348861051895764', '1002', '2025-06-04 15:22:32.012461', '2025-06-04 15:54:35.197855', '8642272238835335158', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642272238835335150', '8642348861051895764', '1002', '2025-06-04 15:39:22.516803', '2025-06-04 15:54:35.197855', '8642272238835335153', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642272238835335146', '8642348861051895764', '1002', '2025-06-04 15:48:28.77639', '2025-06-04 15:54:35.197855', '8642272238835335149', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895784', '8642348861051895801', '1002', '2025-06-04 14:40:43.303137', '2025-06-04 15:54:37.621247', '8642348861051895786', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895769', '8642348861051895798', '1002', '2025-06-04 14:40:46.126733', '2025-06-04 15:54:38.220009', '8642348861051895772', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642305877019197437', '8642348861051895796', '1002', '2025-06-04 15:02:23.403224', '2025-06-04 15:54:38.823001', '8642305877019197440', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642272238835335165', '8642348861051895796', '1002', '2025-06-04 15:16:10.758026', '2025-06-04 15:54:38.823001', '8642272238835335168', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642272238835335160', '8642348861051895796', '1002', '2025-06-04 15:21:10.669548', '2025-06-04 15:54:38.823001', '8642272238835335163', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642272238835335155', '8642348861051895796', '1002', '2025-06-04 15:22:32.012461', '2025-06-04 15:54:38.823001', '8642272238835335158', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895765', '8642348861051895796', '1002', '2025-06-04 14:40:46.825824', '2025-06-04 15:54:38.823001', '8642348861051895768', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895783', '8642348861051895796', '1002', '2025-06-04 14:40:43.30513', '2025-06-04 15:54:38.823001', '8642348861051895786', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895787', '8642348861051895798', '1002', '2025-06-04 14:40:42.585992', '2025-06-04 15:54:39.424765', '8642348861051895790', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895762', '8642348861051895794', '1002', '2025-06-04 14:40:47.510457', '2025-06-04 15:54:40.024665', '8642348861051895764', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895788', '8642348861051895793', '1002', '2025-06-04 14:40:42.585992', '2025-06-04 15:54:40.623595', '8642348861051895790', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895758', '8642348861051895798', '1002', '2025-06-04 14:40:48.164161', '2025-06-04 15:54:41.828672', '8642348861051895760', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895735', '8642348861051895802', '1002', '2025-06-04 14:40:52.63081', '2025-06-04 15:54:43.024232', '8642348861051895737', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895728', '8642348861051895793', '1002', '2025-06-04 14:40:53.948789', '2025-06-04 15:54:43.626995', '8642348861051895730', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338237', '8642348861051895796', '1002', '2025-06-04 15:51:57.079582', '2025-06-04 15:54:44.822772', '8642197643843338240', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895731', '8642348861051895748', '1002', '2025-06-04 14:40:53.264331', '2025-06-04 15:54:45.424985', '8642348861051895733', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895720', '8642348861051895748', '1002', '2025-06-04 14:47:00.826238', '2025-06-04 15:54:45.424985', '8642348861051895722', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642315944422539262', '8642348861051895748', '1002', '2025-06-04 14:55:22.022037', '2025-06-04 15:54:45.424985', '8642315944422539264', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642305877019197438', '8642348861051895748', '1002', '2025-06-04 15:02:23.403224', '2025-06-04 15:54:45.424985', '8642305877019197440', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642296977846960126', '8642348861051895748', '1002', '2025-06-04 15:04:19.961528', '2025-06-04 15:54:45.424985', '8642296977846960128', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642272238835335166', '8642348861051895748', '1002', '2025-06-04 15:16:10.758026', '2025-06-04 15:54:45.424985', '8642272238835335168', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642272238835335161', '8642348861051895748', '1002', '2025-06-04 15:21:10.667553', '2025-06-04 15:54:45.424985', '8642272238835335163', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642272238835335156', '8642348861051895748', '1002', '2025-06-04 15:22:32.011464', '2025-06-04 15:54:45.424985', '8642272238835335158', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642272238835335151', '8642348861051895748', '1002', '2025-06-04 15:39:22.516803', '2025-06-04 15:54:45.424985', '8642272238835335153', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642272238835335147', '8642348861051895748', '1002', '2025-06-04 15:48:28.77639', '2025-06-04 15:54:45.424985', '8642272238835335149', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338238', '8642348861051895748', '1002', '2025-06-04 15:51:57.078585', '2025-06-04 15:54:45.424985', '8642197643843338240', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895742', '8642348861051895760', '1002', '2025-06-04 14:40:51.308648', '2025-06-04 15:54:46.020122', '8642348861051895747', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895741', '8642348861051895757', '1002', '2025-06-04 14:40:51.308648', '2025-06-04 15:54:46.020122', '8642348861051895747', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895734', '8642348861051895740', '1002', '2025-06-04 14:40:52.63081', '2025-06-04 15:54:46.621915', '8642348861051895737', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895727', '8642348861051895740', '1002', '2025-06-04 14:40:53.948789', '2025-06-04 15:54:46.621915', '8642348861051895730', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895723', '8642348861051895740', '1002', '2025-06-04 14:40:54.618889', '2025-06-04 15:54:46.621915', '8642348861051895726', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895770', '8642348861051895782', '1002', '2025-06-04 14:40:46.126733', '2025-06-04 15:54:47.225832', '8642348861051895772', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895766', '8642348861051895781', '1002', '2025-06-04 14:40:46.825824', '2025-06-04 15:54:47.828162', '8642348861051895768', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895724', '8642348861051895781', '1002', '2025-06-04 14:40:54.617892', '2025-06-04 15:54:47.828162', '8642348861051895726', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895773', '8642348861051895778', '1002', '2025-06-04 14:40:45.444668', '2025-06-04 15:54:48.425402', '8642348861051895776', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895761', '8642348861051895778', '1002', '2025-06-04 14:40:47.511456', '2025-06-04 15:54:48.425402', '8642348861051895764', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895755', '8642348861051895778', '1002', '2025-06-04 14:40:48.793573', '2025-06-04 15:54:48.425402', '8642348861051895757', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895744', '8642348861051895754', '1002', '2025-06-04 14:40:51.307648', '2025-06-04 15:54:49.016431', '8642348861051895748', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895743', '8642348861051895753', '1002', '2025-06-04 14:40:51.308648', '2025-06-04 15:54:49.605524', '8642348861051895747', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642348861051895738', '8642348861051895750', '1002', '2025-06-04 14:40:51.940629', '2025-06-04 15:54:50.197074', '8642348861051895740', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338202', '8642197643843338214', '1002', '2025-06-04 15:55:08.517063', '2025-06-04 16:39:19.779781', '8642197643843338204', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338205', '8642197643843338210', '1002', '2025-06-04 15:55:07.902941', '2025-06-04 16:39:20.40158', '8642197643843338208', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338188', '8642197643843338210', '1002', '2025-06-04 15:55:11.061545', '2025-06-04 16:39:21.032436', '8642197643843338190', 99, 'after', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8642197643843338168', '8642197643843338234', '1002', '2025-06-04 15:55:14.758181', '2025-06-04 16:39:26.647661', '8642197643843338170', 99, 'before', 1, 100001);
INSERT INTO public.lane_ref VALUES ('8552983717042192384', '80191', '1007', '2025-07-04 17:05:58.760897', '2025-07-04 17:06:45.601901', '8642101470935646150', 99, NULL, 0, 100001);


--
-- TOC entry 4509 (class 0 OID 18053)
-- Dependencies: 224
-- Data for Name: obstacle; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4510 (class 0 OID 18062)
-- Dependencies: 225
-- Data for Name: point; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4511 (class 0 OID 18068)
-- Dependencies: 226
-- Data for Name: pole; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4512 (class 0 OID 18077)
-- Dependencies: 227
-- Data for Name: road_mark; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.road_mark VALUES ('8678550728073019387', 100001, '01030000A0E610000001000000050000006F37BB5CEA535E40CCDB8CEA27373F40000000A06B0AF83FA82210BBEA535E4030AAE2FC27373F40000000608A8FF73F324A0ACBEA535E40805EEF3A24373F40000000C01775F73FF85EB56CEA535E405C8F992824373F40000000C0EE18F83F6F37BB5CEA535E40CCDB8CEA27373F40000000A06B0AF83F', '2025-06-03 09:10:05.274275', '2025-06-03 09:10:05.274524', 99, 'straight_through', 'directional_arrow', '0', NULL);
INSERT INTO public.road_mark VALUES ('8645924713383591893', 100001, '01030000A0E610000001000000070000008DD15C5FE9535E401062512FC6363F40000000E0F074F93FF9337B6CE9535E40B88B82A1C2363F40000000C0E772F83FB5BA3262ED535E40E821C446C5363F4000000060B997F83F441DCE40ED535E40C891278DC6363F40000000000179F73F226CFD22ED535E4018E84392C7363F40000000403517F73F79581017ED535E4050CA4B93C8363F40000000002B40F73F8DD15C5FE9535E401062512FC6363F40000000E0F074F93F', '2025-06-03 09:54:25.50715', '2025-06-03 09:54:25.50715', 0, '', 'crosswalk', '0', NULL);
INSERT INTO public.road_mark VALUES ('8680617535055331327', 100001, '01030000A0E6100000010000000500000095772AD1E9535E4028FF41E127373F4000000040E17AF4BF15CD6F24EA535E4028FF41E127373F4000000040E17AF4BF8E9C6028EA535E40349CE53B24373F4000000040E17AF4BF735F81D8E9535E405CC10E5624373F4000000040E17AF4BF95772AD1E9535E4028FF41E127373F4000000040E17AF4BF', '2025-05-23 10:30:26.197676', '2025-05-23 10:30:26.19771', 99, 'straight_through', 'directional_arrow', '0', NULL);
INSERT INTO public.road_mark VALUES ('8680617535055331325', 100001, '01030000A0E610000001000000050000007290355CEA535E40603ECDC627373F4000000040E17AF4BF146C2CC2EA535E404C7F9DCC27373F4000000040E17AF4BF146C2CC2EA535E40083F8FAA23373F4000000040E17AF4BF6BCDB464EA535E403C805FB023373F4000000040E17AF4BF7290355CEA535E40603ECDC627373F4000000040E17AF4BF', '2025-05-23 10:30:26.812442', '2025-05-23 10:30:26.812659', 99, 'straight_through', 'directional_arrow', '0', NULL);
INSERT INTO public.road_mark VALUES ('8678550728073019388', 100001, '01030000A0E61000000100000005000000CCE6BAC7E9535E406C248DF527373F40000000A042AEF83F07EB6B2BEA535E4030AAE2FC27373F40000000A042AEF83FE78FDA31EA535E403804B4FD23373F4000000080E441F83FAC8B29CEE9535E40247E5EF623373F4000000080E441F83FCCE6BAC7E9535E406C248DF527373F40000000A042AEF83F', '2025-06-03 09:10:04.652971', '2025-06-03 09:10:04.653029', 99, 'straight_through', 'directional_arrow', '0', NULL);
INSERT INTO public.road_mark VALUES ('8645924713383591884', 100001, '01030000A0E610000001000000050000004F1D3853EA535E405411EF5ECF363F40000000201ED0F83F53558DA6EA535E40C4CCA57FCF363F4000000040F573F93F99CE02C5EA535E40B065A2F3CB363F40000000C0E0C5F93F9796AD71EA535E4008A9EBD2CB363F40000000E04CE1F83F4F1D3853EA535E405411EF5ECF363F40000000201ED0F83F', '2025-06-03 09:55:56.073232', '2025-06-03 09:55:56.073232', 0, '["straight_through","turn_right"]', 'directional_arrow', '0', NULL);
INSERT INTO public.road_mark VALUES ('8645924713383591883', 100001, '01030000A0E61000000100000005000000BFC0F4EEEA535E40AC305284CF363F40000000E0A3F7F93FBFE5B938EB535E4084F8AA8DCF363F40000000E0A3F7F93F80640E43EB535E40949C86D3CB363F4000000040DE00FA3F813F49F9EA535E4060D42DCACB363F4000000080E8D7F93FBFC0F4EEEA535E40AC305284CF363F40000000E0A3F7F93F', '2025-06-03 09:55:56.073232', '2025-06-03 09:55:56.073232', 0, '["turn_left"]', 'directional_arrow', '0', NULL);
INSERT INTO public.road_mark VALUES ('8645924713383591882', 100001, '01030000A0E610000001000000050000006507DC83EF535E40DC61A3A6C1363F40000000809567F83FFA9D7C92EF535E401CF76470C0363F40000000806C0BF93F97BC10B7F0535E40D45FD411C1363F40000000207959F83F002670A8F0535E40A8C81248C2363F4000000020A2B5F73F6507DC83EF535E40DC61A3A6C1363F40000000809567F83F', '2025-06-03 09:55:56.073232', '2025-06-03 09:55:56.073232', 0, '["straight_through","turn_right"]', 'directional_arrow', '0', NULL);
INSERT INTO public.road_mark VALUES ('8645924713383591881', 100001, '01030000A0E610000001000000050000003CE0D0ACEF535E4038C045D5BF363F40000000406234F93F46ECE7BCEF535E40784F079FBE363F4000000000585DF93F5640DCC5F0535E40604BD73FBF363F40000000605AD4F83F4B34C5B5F0535E4008BA1576C0363F40000000A064ABF83F3CE0D0ACEF535E4038C045D5BF363F40000000406234F93F', '2025-06-03 09:55:56.073232', '2025-06-03 09:55:56.073232', 0, '["turn_left"]', 'directional_arrow', '0', NULL);
INSERT INTO public.road_mark VALUES ('8645924713383591862', 100001, '01030000A0E6100000010000000C000000B9C9F886ED535E4004AEC5A8C3363F40000000E0A4E9F83F4F743370ED535E40C041B485B8363F40000000605D79F83F90316708EE535E40F88292EDB8363F40000000C09911F83F52C72330EE535E408C008457B9363F40000000C09911F83FCDF9D05CEE535E407C0EBFB7B9363F40000000405C07F93FA251C667EE535E40FC9959CFB9363F40000000808F3AF83F97850D87EE535E4064DB6CE7B9363F40000000405C07F93F9F768892EE535E40B4661C2FC3363F40000000203EB0F73FE8FA2780EE535E406C66E830C3363F4000000080525EF73F6BEA0738EE535E40CC83DD78C3363F40000000203EB0F73F2FB736FEED535E40444DD5E2C3363F40000000E033D9F73FB9C9F886ED535E4004AEC5A8C3363F40000000E0A4E9F83F', '2025-06-03 10:04:18.842666', '2025-06-03 10:04:18.842666', 0, '', 'crosswalk', '0', NULL);
INSERT INTO public.road_mark VALUES ('8645782395347271543', 100001, '01030000A0E610000001000000050000006AB74C22E6535E40E45A1F73BA363F400000000074BBF93F3DA9C32CE6535E408CE1BA54B9363F40000000405536FA3F6703D324E7535E40302DCEBEB9363F4000000040C7EAF93F96115C1AE7535E4010A532DDBA363F4000000080D1C1F93F6AB74C22E6535E40E45A1F73BA363F400000000074BBF93F', '2025-06-03 14:22:07.628343', '2025-06-03 14:22:07.628343', 0, '["turn_left"]', 'directional_arrow', '0', NULL);
INSERT INTO public.road_mark VALUES ('8645782395347271542', 100001, '01030000A0E6100000010000000500000007655239E6535E406C57418CB8363F40000000A0EB90F93FDC56C943E6535E4098AB2E7CB7363F40000000E01EC4F83F9B9C2A45E7535E40602A09F0B7363F40000000203703F93FC6AAB33AE7535E40F8D41B00B9363F40000000C0DB98F93F07655239E6535E406C57418CB8363F40000000A0EB90F93F', '2025-06-03 14:22:07.628343', '2025-06-03 14:22:07.628343', 0, '["straight_through","turn_right"]', 'directional_arrow', '0', NULL);
INSERT INTO public.road_mark VALUES ('8645782395347271541', 100001, '01030000A0E610000001000000050000006528BCF7EB535E40B0920965AE363F40000000A0731BFA3F16234447EC535E40E03BAD81AE363F40000000C0E28DF93F2E861363EC535E40F801DFF9AA363F4000000040CEDFF93F7F8B8B13EC535E40B8573BDDAA363F40000000606944FA3F6528BCF7EB535E40B0920965AE363F40000000A0731BFA3F', '2025-06-03 14:22:07.628343', '2025-06-03 14:22:07.628343', 0, '["straight_through","turn_right"]', 'directional_arrow', '0', NULL);
INSERT INTO public.road_mark VALUES ('8645782395347271540', 100001, '01030000A0E61000000100000005000000FFFCC35AEB535E408C6B701DAE363F40000000E05496FA3F9D8B7BAEEB535E40DC14143AAE363F40000000E05496FA3FC995E8C7EB535E40840844D4AA363F40000000205F6DFA3F2B073174EB535E40305EA0B7AA363F40000000E05496FA3FFFFCC35AEB535E408C6B701DAE363F40000000E05496FA3F', '2025-06-03 14:22:07.628343', '2025-06-03 14:22:07.628343', 0, '["turn_left"]', 'directional_arrow', '0', NULL);
INSERT INTO public.road_mark VALUES ('8645782395347271531', 100001, '01030000A0E61000000100000008000000259FAA2CE9535E40440826EAB4363F40000000E02879F93FDF557C33ED535E40C45BD80BB7363F400000002053A2F83F88C58C3FED535E40142A4B7BB3363F4000000080FD82F73F4263E797E9535E4090FE9F90B1363F4000000040CE3BF83F135B6F7EE9535E405C5C0296B2363F40000000C0B98DF83F9BA4A567E9535E40DC4A1F72B3363F4000000080FD02F93F5C89C03CE9535E409CF59360B4363F40000000203350F93F259FAA2CE9535E40440826EAB4363F40000000E02879F93F', '2025-06-03 14:23:00.49782', '2025-06-03 14:23:00.49782', 0, '', 'crosswalk', '0', NULL);
INSERT INTO public.road_mark VALUES ('8645782395347271530', 100001, '01030000A0E610000001000000070000008FB249F0E7535E40F838D316BF363F40000000E0E4FEF73F65CBC62EE8535E40C4397366B6363F4000000080705AF83F70A210AAE8535E404C3CC90FB6363F40000000603D27F93F76DF650FE9535E40B8A17332B6363F40000000A01EA2F93F0FA021FBE8535E40BC58ED31C0363F4000000020412AF83F7499A470E8535E40446443DBBF363F40000000C05FAFF73F8FB249F0E7535E40F838D316BF363F40000000E0E4FEF73F', '2025-06-03 14:23:00.49782', '2025-06-03 14:23:00.49782', 0, '', 'crosswalk', '0', NULL);


--
-- TOC entry 4513 (class 0 OID 18085)
-- Dependencies: 228
-- Data for Name: road_mark_ref; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.road_mark_ref VALUES ('8552983717042192377', '80174', '1006', '2025-07-04 17:12:57.0914', '2025-07-04 17:12:57.0914', '8645924713383591884', 0, 0, 100001);


--
-- TOC entry 4303 (class 0 OID 16693)
-- Dependencies: 199
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4514 (class 0 OID 18090)
-- Dependencies: 229
-- Data for Name: stop_line; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.stop_line VALUES ('8680617535055331328', 100001, '01030000A0E610000001000000050000002B2879CFE9535E40D41D27EA27373F4000000040E17AF4BF85518618EA535E4050820DE527373F4000000040E17AF4BFC639F125EA535E401C020C1C24373F4000000040E17AF4BF7A60DFDFE9535E403CD5582B24373F4000000040E17AF4BF2B2879CFE9535E40D41D27EA27373F4000000040E17AF4BF', '2025-05-22 17:59:54.678311', '2025-05-22 17:59:54.678362', 99, 'solid', '0', NULL);
INSERT INTO public.stop_line VALUES ('8680617535055331326', 100001, '01030000A0E61000000100000005000000E0CC5FB9E9535E40E4F09E5228373F4000000040E17AF4BFABF18829EA535E4008B0CE4C28373F4000000040E17AF4BFDBFD3B2BEA535E4034C554D828373F4000000040E17AF4BFE0CC5FB9E9535E40548484D228373F4000000040E17AF4BFE0CC5FB9E9535E40E4F09E5228373F4000000040E17AF4BF', '2025-05-22 18:05:09.799894', '2025-05-22 18:05:09.799934', 99, 'solid', '0', NULL);
INSERT INTO public.stop_line VALUES ('8680617535055331324', 100001, '01030000A0E61000000100000005000000893AD032E9535E40D0CAB1E423373F4000000040E17AF4BF5B227A9AE9535E40CC51930724373F4000000040E17AF4BF2916C798E9535E40EC2B8B4D23373F4000000040E17AF4BF26226A2FE9535E40EC2B8B4D23373F4000000040E17AF4BF893AD032E9535E40D0CAB1E423373F4000000040E17AF4BF', '2025-05-23 10:30:27.427836', '2025-05-23 10:30:27.427867', 99, 'solid', '0', NULL);
INSERT INTO public.stop_line VALUES ('8678550728073019390', 100001, '01030000A0E61000000100000005000000BA24AE37E9535E40589316F222373F40000000008D20F73F5AADCDA1E9535E40B0626C0423373F4000000000F9EFF73F8BD6A89FE9535E40D477BAED21373F40000000204424F83F1F90C038E9535E4028C1BAF821373F40000000003257F73FBA24AE37E9535E40589316F222373F40000000008D20F73F', '2025-06-03 09:10:05.864373', '2025-06-03 09:10:05.864423', 99, 'solid', '0', NULL);
INSERT INTO public.stop_line VALUES ('8678550728073019389', 100001, '01030000A0E61000000100000005000000F63B54D6E9535E40C89BB9CC21373F4000000060259FF83F96C47340EA535E4044A864DB21373F40000000E0394DF83F96C47340EA535E40247D5DC820373F40000000E0394DF83FC31279D8E9535E40D8F607C120373F40000000E0394DF83FF63B54D6E9535E40C89BB9CC21373F4000000060259FF83F', '2025-06-03 09:10:06.446081', '2025-06-03 09:10:06.446112', 99, 'solid', '0', NULL);
INSERT INTO public.stop_line VALUES ('8645924713383591900', 100001, '01030000A0E610000001000000050000007492234AEA535E409893C858C8363F400000002057B8F83F6E46DA81EB535E40F07C15FFC8363F4000000040DE00FA3F6B01EB82EB535E4054573CCAC8363F4000000080E8D7F93F2AB1AB4DEA535E40E0460513C8363F40000000A0420AF93F7492234AEA535E409893C858C8363F400000002057B8F83F', '2025-06-03 09:51:12.12082', '2025-06-03 09:52:17.111749', 0, 'solid', '0', NULL);
INSERT INTO public.stop_line VALUES ('8645924713383591860', 100001, '01030000A0E6100000010000000500000020F97FE0EE535E4068FB99F2C2363F4000000080525EF73FCDB0BBF7EE535E400CD0E5F6C2363F40000000604887F73F41EE18EDEE535E40A8AC3FAEBD363F40000000405099F93F72F500D9EE535E40A8AC3FAEBD363F40000000405099F93F20F97FE0EE535E4068FB99F2C2363F4000000080525EF73F', '2025-06-03 10:04:19.178722', '2025-06-03 10:04:19.178722', 0, 'solid', '0', NULL);
INSERT INTO public.stop_line VALUES ('8645782395347271570', 100001, '01030000A0E61000000100000005000000A18E5196E7535E40540570C9BB363F4000000080D1C1F93FC92334ACE7535E40347E5ED8BB363F40000000C0DB98F93FF3B531DEE7535E40DCBFE17EB6363F4000000080740DF83F70AE85CAE7535E408CF12678B6363F40000000406A36F83FA18E5196E7535E40540570C9BB363F4000000080D1C1F93F', '2025-06-03 14:20:49.986235', '2025-06-03 14:20:49.986235', 0, 'solid', '0', NULL);
INSERT INTO public.stop_line VALUES ('8645782395347271569', 100001, '01030000A0E610000001000000050000001855D726EB535E40D4A09834B1363F4000000020DB16FA3F45F8CA28EB535E40D464DA01B1363F40000000E0D03FFA3FBB178370EC535E40E098509CB1363F40000000E03A8DFA3FB199C76DEC535E40301918E7B1363F4000000080FD82FB3F1855D726EB535E40D4A09834B1363F4000000020DB16FA3F', '2025-06-03 14:20:49.986235', '2025-06-03 14:20:49.986235', 0, 'solid', '0', NULL);


--
-- TOC entry 4515 (class 0 OID 18098)
-- Dependencies: 230
-- Data for Name: traffic_light; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4516 (class 0 OID 18106)
-- Dependencies: 231
-- Data for Name: traffic_light_group; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4517 (class 0 OID 18113)
-- Dependencies: 232
-- Data for Name: traffic_sign; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4518 (class 0 OID 18121)
-- Dependencies: 233
-- Data for Name: worker_node; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4709 (class 0 OID 0)
-- Dependencies: 213
-- Name: worker_node_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.worker_node_id_seq', 1, false);


--
-- TOC entry 4344 (class 2606 OID 18149)
-- Name: boundary boundary_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.boundary
    ADD CONSTRAINT boundary_info_pkey PRIMARY KEY (boundary_id);


--
-- TOC entry 4364 (class 2606 OID 18151)
-- Name: traffic_light_group lane_group_copy1_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traffic_light_group
    ADD CONSTRAINT lane_group_copy1_pkey PRIMARY KEY (traffic_light_group_id);


--
-- TOC entry 4349 (class 2606 OID 18153)
-- Name: road_mark roadmark_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.road_mark
    ADD CONSTRAINT roadmark_info_pkey PRIMARY KEY (road_mark_id);


--
-- TOC entry 4358 (class 2606 OID 18155)
-- Name: stop_line stopline_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stop_line
    ADD CONSTRAINT stopline_pkey PRIMARY KEY (stop_line_id);


--
-- TOC entry 4354 (class 2606 OID 18157)
-- Name: road_mark_ref traffic_light_ref_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.road_mark_ref
    ADD CONSTRAINT traffic_light_ref_pkey PRIMARY KEY (road_mark_ref_id);


--
-- TOC entry 4362 (class 2606 OID 18159)
-- Name: traffic_light trafficlight_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traffic_light
    ADD CONSTRAINT trafficlight_pkey PRIMARY KEY (traffic_light_id);


--
-- TOC entry 4369 (class 2606 OID 18161)
-- Name: traffic_sign trafficsign_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.traffic_sign
    ADD CONSTRAINT trafficsign_pkey PRIMARY KEY (traffic_sign_id);


--
-- TOC entry 4342 (class 1259 OID 18162)
-- Name: boundary_geom_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX boundary_geom_idx ON public.boundary USING gist (geom);


--
-- TOC entry 4345 (class 1259 OID 18163)
-- Name: boundary_task_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX boundary_task_id_idx ON public.boundary USING btree (task_id);


--
-- TOC entry 4346 (class 1259 OID 18164)
-- Name: road_mark_geom_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX road_mark_geom_idx ON public.road_mark USING gist (geom);


--
-- TOC entry 4350 (class 1259 OID 18165)
-- Name: road_mark_ref_feature_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX road_mark_ref_feature_id_idx ON public.road_mark_ref USING btree (feature_id);


--
-- TOC entry 4351 (class 1259 OID 18166)
-- Name: road_mark_ref_road_mark_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX road_mark_ref_road_mark_id_idx ON public.road_mark_ref USING btree (road_mark_id);


--
-- TOC entry 4352 (class 1259 OID 18167)
-- Name: road_mark_ref_type_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX road_mark_ref_type_idx ON public.road_mark_ref USING btree (type);


--
-- TOC entry 4347 (class 1259 OID 18168)
-- Name: road_mark_task_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX road_mark_task_id_idx ON public.road_mark USING btree (task_id);


--
-- TOC entry 4355 (class 1259 OID 18169)
-- Name: stop_line_geom_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX stop_line_geom_idx ON public.stop_line USING gist (geom);


--
-- TOC entry 4356 (class 1259 OID 18170)
-- Name: stop_line_task_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX stop_line_task_id_idx ON public.stop_line USING btree (task_id);


--
-- TOC entry 4359 (class 1259 OID 18171)
-- Name: traffic_light_geom_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX traffic_light_geom_idx ON public.traffic_light USING gist (geom);


--
-- TOC entry 4365 (class 1259 OID 18172)
-- Name: traffic_light_group_task_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX traffic_light_group_task_id_idx ON public.traffic_light_group USING btree (task_id);


--
-- TOC entry 4360 (class 1259 OID 18173)
-- Name: traffic_light_task_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX traffic_light_task_id_idx ON public.traffic_light USING btree (task_id);


--
-- TOC entry 4366 (class 1259 OID 18174)
-- Name: traffic_sign_geom_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX traffic_sign_geom_idx ON public.traffic_sign USING gist (geom);


--
-- TOC entry 4367 (class 1259 OID 18175)
-- Name: traffic_sign_task_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX traffic_sign_task_id_idx ON public.traffic_sign USING btree (task_id);


--
-- TOC entry 4524 (class 0 OID 0)
-- Dependencies: 8
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2025-07-30 12:00:42

--
-- PostgreSQL database dump complete
--

